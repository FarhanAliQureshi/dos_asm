org 100h

%define MAX_PATH 64                 ; Maximum path length for DOS

section .data
    db_filename                     db 'PRJNAME.BAT', 0
    db_fileline1                    db '@ECHO OFF', 13, 10
    dw_fileline1_length             dw $-db_fileline1
    db_fileline2                    db 'SET PROJECT='
    dw_fileline2_length             dw $-db_fileline2
    db_default_project_name         db 'PROJECT'
    dw_default_project_name_length  dw $-db_default_project_name

section .bss
    db_buffer                       resb MAX_PATH
    ptr_project_name                resw 1
    dw_path_length                  resw 1
    dw_project_name_length          resw 1
    hfile                           resw 1       ; File Handle

section .text
start:
    ; Initialize variables
    mov word [dw_path_length], 0
    mov word [dw_project_name_length], 0

    ; Get current directory (from DOS) in db_buffer
    ; Reference for function 47h: https://www.delorie.com/djgpp/doc/rbinter/id/45/29.html
    mov dl, 0       ; Default drive
    mov si, db_buffer
    mov ah, 47h
    int 21h
    jc error_exit   ; We got some error. Exit program with an error code

    ; Find NUL character to determine the length of 
    ; path (which is in db_buffer)
    xor bx, bx
find_nul:
    cmp byte [bx + db_buffer], 0
    je found_nul
    inc bx
    cmp bx, MAX_PATH
    je use_default      ; We reached at the end of the db_buffer and we still
                        ; can't find NUL character. Something is wrong.
                        ; Let's abandon the search and use default 
                        ; project name.
    jmp find_nul

found_nul:
    cmp bx, 0           
    je use_default      ; If we found NUL at the start of the db_buffer then
                        ; we are at the root directory, for example C:\
                        ; That's because DOS function AH 47h will return 
                        ; empty string (in db_buffer) for root directory.
    mov word [dw_path_length], bx

    ; From the NUL character, go backwards and find the first backslash
find_backslash:
    cmp byte [bx + db_buffer], '\'
    je found_backslash
    dec bx
    cmp bx, 0
    je backslash_not_found      ; We have reached at the start of db_buffer 
                                ; and still not found any backslash. It means
                                ; we are at the first level directory. For
                                ; example, C:\DATA. DOS function AH 47h will
                                ; return DATA for this example, without
                                ; any backslash.
    jmp find_backslash

found_backslash:
    inc bx                      ; We don't want the leading backslash in project name

backslash_not_found:
    ; Pseudocode: LEN(PROJECT NAME) = LEN(PATH) - POS(BACKSLASH)
    mov dx, word [dw_path_length]
    sub dx, bx
    mov word [dw_project_name_length], dx
    ; Pseudocode: POINTER(PROJECT NAME) = POINTER(BUFFER) + POS(BACKSLASH)
    mov dx, db_buffer
    add dx, bx
    mov word [ptr_project_name], dx
    jmp write_to_file

use_default:
    ; Use default project name
    mov bx, db_default_project_name
    mov word [ptr_project_name], bx
    mov bx, [dw_default_project_name_length]
    mov word [dw_project_name_length], bx

write_to_file:
    xor ax, ax
    ; Create file
    ; Reference for function 3Ch: https://www.delorie.com/djgpp/doc/rbinter/id/89/27.html
    mov ah, 3ch
    ; Reference for CX: https://www.delorie.com/djgpp/doc/rbinter/it/01/14.html
    mov cx, 0010_0000b          ; Set Archive bit (5th bit)
    mov dx, db_filename
    int 21h
    jc error_exit   ; We got some error. Exit program with an error code
    ; Save file handle
    mov word [hfile], ax

    ; Write data to file
    ; Reference for function 40h https://www.delorie.com/djgpp/doc/rbinter/id/02/28.html
    ; Line 1
    mov ah, 40h
    mov bx, [hfile]
    mov cx, [dw_fileline1_length]
    mov dx, db_fileline1
    int 21h
    jc error_exit   ; We got some error. Exit program with an error code
    ; Line 2
    mov ah, 40h
    mov cx, [dw_fileline2_length]
    mov dx, db_fileline2
    int 21h
    jc error_exit   ; We got some error. Exit program with an error code
    ; Project name taken from current directory
    mov ah, 40h
    mov cx, [dw_project_name_length]
    mov dx, [ptr_project_name]
    int 21h
    jc error_exit   ; We got some error. Exit program with an error code

    ; Close file
    ; Reference for function 3Eh https://www.delorie.com/djgpp/doc/rbinter/id/93/27.html
    mov ah, 3eh
    mov bx, [hfile]
    int 21h
    jc error_exit   ; We got some error. Exit program with an error code

exit:
    ; Terminate the program by calling the DOS exit function
    mov ax, 4c00h
    int 21h

error_exit:
    ; We got some error. Terminate the program with an error code
    mov ax, 4c01h       ; Exit return code is in AL
    int 21h
