org 100h

section .data
    text db 'ASCII Characters Set', 13, 10, '$'

section .text
start:
    ; Display text on screen
    mov dx, text
    mov ah, 9
    int 21h

    ; Display each ASCII character on screen
    xor dx, dx
    mov ah, 2
loop:
    int 21h
    inc dl
    cmp dl, 255
    jne loop
    
    ; Print the last remaining character
    int 21h
    ; Print CR and LF
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

exit:
    ; Terminate the program by calling the DOS exit function
    mov ax, 4c00h
    int 21h