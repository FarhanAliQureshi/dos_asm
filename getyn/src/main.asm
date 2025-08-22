; Size of command-line is a byte at offset 80h in Program Segment Prefix (PSP).
; Command-line starts at 81h and ends with 0Dh (CR) character.
; However, we don't want the leading space character, therefore, start at 82h.
; Maximum size of command-line is 127 bytes including 0Dh.

org 100h

section .data
    textYes     db ' Yes', 13, 10, '$'
    textNo      db ' No', 13, 10, '$'

section .text
start:
    ; Size of command-line arguments (including CR character)
    mov cl, byte[80h]
    ; If no command-line arguments were given then get user input
    cmp cl, 0
    je GetUserInput

    ; Display prompt given as command-line argument
    xor bx, bx
    mov ah, 2
    ; Keep printing each character until we find a CR character
loop:
    mov dl, byte[bx + 82h]
    cmp dl, 0Dh
    je GetUserInput         ; If we found CR character then break the loop
    int 21h
    inc bx
    jmp loop

GetUserInput:
    ; Wait for Y or N key (case insensitive)
    mov ah, 8h
    int 21h
    cmp al, 89              ; Y
    je UserSelectedYes
    cmp al, 121             ; y
    je UserSelectedYes
    cmp al, 78              ; N
    je UserSelectedNo
    cmp al, 110             ; n
    je UserSelectedNo
    ; Check if user pressed an extended key (2 bytes, with first byte as NUL character)
    cmp al, 0
    jne GetUserInput
    int 21h                 ; Eat up next byte of extended key from buffer 
    jmp GetUserInput

UserSelectedYes:
    ; If user didn't provide any prompt then silently exit
    cmp cl, 0
    je ExitWithYes
    ; Print "Yes"
    mov dx, textYes
    mov ah, 9
    int 21h
    jmp ExitWithYes

UserSelectedNo:
    ; If user didn't provide any prompt then silently exit
    cmp cl, 0
    je ExitWithNo
    ; Print "No"
    mov dx, textNo
    mov ah, 9
    int 21h
    jmp ExitWithNo

ExitWithYes:
    ; Check ERRORLEVEL in calling batch file (or exit code in calling program)
    mov al, 1
    jmp exit

ExitWithNo:
    ; Check ERRORLEVEL in calling batch file (or exit code in calling program)
    mov al, 2

exit:
    ; Terminate the program by calling the DOS exit function
    mov ah, 4Ch
    int 21h