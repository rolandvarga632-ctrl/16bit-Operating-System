; kernel.s
[bits 16]
[org 0x1000]

clear_display:
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    

welcome:
    mov si, welcome_msg
    call write





write:
    lodsb
    test al, al
    jz write_end
    mov ah, 0x0E
    int 0x10
    jmp write

write_end:
    ret

welcome_msg db "Welcome in the R16-DOS!", 13, 10, 0
times 512 - ($ - $$) db 0

