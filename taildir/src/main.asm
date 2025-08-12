org 100h

%define MAX_PATH 64

section .bss
    buffer resb MAX_PATH

section .text
start:
    ; Get current directory in buffer
    mov dl, 0
    mov si, buffer
    mov ah, 47h
    int 21h

    ; Find NUL character and replace it with '$' character
    ; for printing string with INT 21h AH 9h.
    xor bx, bx
loop_find_nul:
    cmp byte [bx + buffer], 0
    je found_nul
    inc bx
    jmp loop_find_nul

found_nul:
    ; Replace NUL character with '$' character
    mov byte [bx + buffer], '$'

loop_find_backslash:
    cmp byte [bx + buffer], '\'
    je found_backslash
    cmp bx, 0
    je print_tail_dir       ; We are at the start of buffer and we haven't found backslash
    dec bx
    jmp loop_find_backslash

found_backslash:
    inc bx                      ; We don't want the leading backslash

print_tail_dir:
    lea dx, [buffer + bx]
    mov ah, 9
    int 21h
    ; Print CR and LF
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

exit:
    ; Terminate the program by calling the DOS exit function
    mov ax, 4c00h
    int 21h