org 100h

section .data
    text db 'Press SPACE key to continue...$'

section .text
start:
    ; Display text on screen
    mov dx, text
    mov ah, 9h
    int 21h

loop:
    ; Wait for a key input without echo
    mov ah, 8h
    int 21h
    ; The input character will be in AL.
    ; If the input character is zero then user pressed an extended key.
    ; Extended key is a WORD. In that case, eat up the next byte to
    ; clear the keyboard buffer.
    cmp al, 32              ; Enter key
    je exit
    cmp al, 0
    jne loop
    int 21h                 ; Eat up next byte of extended key from buffer 
    jmp loop

exit:
    ; Print CR and LF before exiting
    xor ax, ax
    mov ah, 2h
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    ; Terminate the program by calling the DOS exit function
    mov ax, 4c00h
    int 21h