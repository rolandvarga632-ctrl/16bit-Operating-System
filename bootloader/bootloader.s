[bits 16]
[org 0x7C00]

KERNEL_OFFSET equ 0x1000 

start:
    
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    
    mov [boot_drive], dl
    

    
    mov si, msg_bootloader
    call kiir

    
    mov bx, KERNEL_OFFSET   
    mov ah, 0x02            
    mov al, 3               
    mov ch, 0               
    mov dh, 0               
    mov cl, 2               
    mov dl, [boot_drive] 
    int 0x13                
   

    jc lemez_hiba           

    mov [0x500], dl
    jmp 0x0000:KERNEL_OFFSET

lemez_hiba:
    mov si, msg_error
    call kiir
    cli
    hlt

kiir:
    lodsb
    test al, al
    jz kiir_vege
    mov ah, 0x0E
    int 0x10
    jmp kiir
kiir_vege:
    ret


boot_drive db 0
msg_bootloader db "Bootloader elindult...", 13, 10, 0 
msg_error       db "Hiba a lemez olvasasakor!", 13, 10, 0

times 510 - ($ - $$) db 0
dw 0xAA55