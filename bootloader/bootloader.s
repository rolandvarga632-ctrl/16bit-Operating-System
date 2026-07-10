; bootloader.asm
[bits 16]
[org 0x7C00]

KERNEL_OFFSET equ 0x1000 ; Ide fogjuk betölteni a kernelt a memóriában

start:
    ; Szegmensek beállítása
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Biztonsági mentés a boot meghajtó számáról (a BIOS a DL-ben adja át)
    mov [boot_meghajto], dl

    ; Üzenet: Bootloader indul
    mov si, msg_bootloader
    call kiir

    ; KERNEL BETÖLTÉSE
    mov bx, KERNEL_OFFSET   ; ES:BX -> ahová a memóriába töltünk (ES=0, BX=0x1000)
    mov ah, 0x02            ; BIOS olvasás funkció
    mov al, 1               
    mov ch, 0               ; Cylinder 0
    mov dh, 0               ; Head 0
    mov cl, 2               ; Sector 2 (A bootloader utáni legelső szektor)
    mov dl, [boot_meghajto] ; A lemez száma, amiről bootoltunk
    int 0x13                ; BIOS Lemez Megszakítás
   

    jc lemez_hiba           ; Ha a Carry Flag (JC) be van állítva, hiba történt!

    ; Ha sikerült, átugrunk a frissen betöltött Kernelre!
    jmp 0x0000:KERNEL_OFFSET

lemez_hiba:
    mov si, msg_hiba
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

; Adatok
boot_meghajto db 0
msg_bootloader db "Bootloader elindult...", 13, 10, 0 ; 13, 10 = új sor
msg_hiba       db "Hiba a lemez olvasasakor!", 13, 10, 0

times 510 - ($ - $$) db 0
dw 0xAA55