; kernel.s
[bits 16]
[org 0x1000]

; KERNEL START BASIC SETTING
kernel_start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov di, puffer

; CLEARING THE DISPLAY

clear_display:
    mov ah, 0x00
    mov al, 0x03
    int 0x10

;WRITE A WELCOME MSG TO THE SCREEN
welcome:
    mov si, welcome_msg
    call write

; THE MAIN OF THE KERNEL
main:
    mov ah, 0x00
    int 0x16
    cmp al, 13
    je enter_push
    mov [di], al
    inc di
    mov ah, 0x0E
    int 0x10
    jmp main

enter_push:
    mov byte [di], 0
    mov di, puffer
    mov si, help_cmd

    mov al, 10
    mov ah, 0x0e
    int 0x10

    mov al, 13
    mov ah, 0x0e
    int 0x10
    call check

    mov di, puffer
    jmp main

; FUNCTIONS

write:
    lodsb
    test al, al
    jz write_end
    mov ah, 0x0E
    int 0x10
    jmp write

write_end:
    ret

Enter:
    mov al, 10
    mov ah, 0x0e
    int 0x10

    mov al, 13
    mov ah, 0x0e
    int 0x10
    ret

clr_pfr:
    mov di, puffer
    mov cx, 32
    loop_start:
        mov byte [di], 0
        inc di
        loop loop_start
        ret

check:
    mov al, [di]
    mov bl, [si]

    cmp al, bl
    jne not_equ

    test al, al
    jz HELP_CMD
    
    inc di
    inc si
    jmp check

not_equ:
    call clr_pfr
    ret


; COMMANDS

HELP_CMD:
    mov si, help_msg
    call write
    call Enter
    call clr_pfr
    ret


; BYTES

puffer:
    times 32 db 0

welcome_msg db "Welcome in the R16-DOS!", 13, 10, 10, 0
help_cmd db "help",0
help_msg db "Help is reachable!",0
times 512 - ($ - $$) db 0

