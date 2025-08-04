org 100h

section .data
    msg db 'Hello, world!', 13, 10, '$'

section .text
start:
    ; Display text to screen
    mov dx, msg
    mov ah, 9
    int 21h

    ; Terminate the program by calling the DOS exit function
    mov ah, 4ch
    mov al, 0           ; Exit return code
    int 21h
