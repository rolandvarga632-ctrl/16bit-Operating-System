ENTER_KEY equ 13
BACKSPACE equ 8
BOTL equ 13         ; Begining of the line (BOTL)
NEWLINE equ 10

[bits 16]
[org 0x1000]

; KERNEL START BASIC SETTING
kernel_start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov di, puffer
    mov cx, 0
    call clr_screen

;WRITE A WELCOME MSG TO THE SCREEN
welcome:
    mov si, welcome_msg
    call write

; THE MAIN OF THE KERNEL
main:
    mov si, promt_msg
    call write
input_loop:
    mov ah, 0x00
    int 0x16
    cmp al, ENTER_KEY
    je enter_push
    cmp al, BACKSPACE
    je BackSpace
    mov [di], al
    inc di
    inc cx
    mov ah, 0x0E
    int 0x10
    jmp input_loop

enter_push:
    mov byte [di], 0
    mov di, puffer

    mov al, NEWLINE
    mov ah, 0x0e
    int 0x10

    mov al, BOTL
    mov ah, 0x0e
    int 0x10
    call shell
    mov di, puffer
    xor cx, cx
    jmp main


%include "/home/roland/Projects/16bit_os/kernel/shell.s"
%include "/home/roland/Projects/16bit_os/kernel/commands.s"
%include "/home/roland/Projects/16bit_os/kernel/functions.s"

; BYTES

puffer:
    times 32 db 0

welcome_msg:
    db "Welcome in the R16-DOS!", 13, 10
    db "Type ,help' to show all available commands", 13, 10, 0
promt_msg:
    db "R16-DOS>",0

times 1024 - ($ - $$) db 0

