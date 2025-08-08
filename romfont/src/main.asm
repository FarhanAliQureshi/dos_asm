org 100h

section .text
start:
    xor bx, bx
    mov ax, 1104h
    int 10h

exit:
    ; Terminate the program by calling the DOS exit function
    mov ax, 4c00h
    int 21h
