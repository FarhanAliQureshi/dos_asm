; Size of command-line is a byte at offset 80h in Program Segment Prefix (PSP).
; Command-line starts at 81h and ends with 0Dh (CR) character.
; However, we don't want the leading space character, therefore, start at 82h.
; Maximum size of command-line is 127 bytes including 0Dh.

org 100h

section .data
    textNoCmdArgGiven   db 'No command-line arguments were given.', 13, 10, '$'
    textCmdArgFound     db 'Command-line arguments are: [$'
    textEndOfCmdArg     db ']', 13, 10, '$'

section .text
start:
    ; Size of command-line arguments (including CR character)
    mov cl, byte[80h]
    ; If no command-line arguments were given then inform user
    cmp cl, 0
    je NoCmdArgGiven

    ; Display command-line arguments on screen
    mov dx, textCmdArgFound
    mov ah, 9
    int 21h
    ; Keep printing each character until we find a CR character
    xor dx, dx
    mov ah, 2
loop:
    mov dl, byte[bx + 82h]
    cmp dl, 0Dh
    je EndOfCmdLine                 ; If we found 0Dh character then break the loop
    int 21h
    inc bx
    jmp loop

EndOfCmdLine:
    mov dx, textEndOfCmdArg
    mov ah, 9
    int 21h
    jmp exit

NoCmdArgGiven:
    mov dx, textNoCmdArgGiven
    mov ah, 9
    int 21h

exit:
    ; Terminate the program by calling the DOS exit function
    mov ax, 4c00h
    int 21h
