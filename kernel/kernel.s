ENTER_KEY equ 13
BACKSPACE equ 8
BOTL equ 13         ; Begining of the line (BOTL)
NEWLINE equ 10

[bits 16]
[org 0x1000]

; A kernel elindul
kernel_start:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov di, puffer
	mov cx, 0
	mov al, [0x500]
	mov [boot_drive], al
; A lemez olvasása
	mov bx, 0x8000
	mov al, 1
	mov cl, 5
	call disk_read
	mov al, [0x8000]
	cmp al, 0xAB
	je fs_done

fs_init:
	mov di, 0x8000
	mov cx, 512
	xor al, al
init_loop:
	mov byte [di], 0
	inc di
	loop init_loop

	mov byte [0x8000], 0xAB
	mov bx, 0x8000
	mov al, 1
	mov cl, 5
	call disk_write
fs_done:
	call clr_screen
	xor cx, cx

welcome:
	mov si, welcome_msg
	call write
	
main:
	mov di, puffer
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
%include "/home/roland/Projects/16bit_os/kernel/disk.s"
%include "/home/roland/Projects/16bit_os/kernel/parser.s"
%include "/home/roland/Projects/16bit_os/kernel/filesys.s"
; BYTES

puffer:	times 32 db 0
command: times 16 db 0
arg:	times 16 db 0	
boot_drive:	db 0

welcome_msg:
	db "Welcome in the R16-DOS!", 13, 10
	db "Type ,help' to show all available commands", 13, 10, 13, 10 ,0

promt_msg:	db "R16-DOS>",0

times 1536 - ($ - $$) db 0

