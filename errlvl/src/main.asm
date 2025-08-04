org 100h

section .data
    msg db 'Program will exit with Error Level of 5', 13, 10, '$'

section .text
start:
    ; Display text to screen
    mov dx, msg
    mov ah, 9
    int 21h

    ; Terminate the program by calling the DOS exit function
    mov ah, 4ch
    mov al, 5           ; Exit return code
    int 21h
