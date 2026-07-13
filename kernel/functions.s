clr_screen:
  mov ah, 0x00
  mov al, 0x03
  int 0x10
  ret

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
    mov al, NEWLINE
    mov ah, 0x0e
    int 0x10

    mov al, BOTL
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

strcmp:
    push di             ; elmenti di-t mert módosítjuk
check_loop:
    mov al, [di]        ; puffer következő karaktere
    mov bl, [si]        ; parancs következő karaktere

    cmp al, bl          ; egyeznek?
    jne not_match

    test al, al         ; végére értünk?
    jz end_check

    inc di
    inc si
    jmp check_loop

not_match:
    mov ax, 1           ; ax = 1, nem egyeznek
    pop di              ; visszaállítjuk di-t
    ret

end_check:
    xor ax, ax          ; ax = 0, egyeznek
    pop di              ; visszaállítjuk di-t
    ret