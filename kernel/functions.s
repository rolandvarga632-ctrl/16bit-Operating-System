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

BackSpace:
    test cx, cx
    jz main
    mov byte [di-1], 0
    dec di
    dec cx

    mov ah, 0x0E
    mov al, 8
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 8
    int 0x10
    jmp main



clr_pfr:
  mov di, puffer
  mov cx, 32
  loop_start:
    mov byte [di], 0
    inc di
    loop loop_start
    ret

strcmp:
    push di             
check_loop:
    mov al, [di]        
    mov bl, [si]        

    cmp al, bl          
    jne not_match

    test al, al         
    jz end_check

    inc di
    inc si
    jmp check_loop

not_match:
    mov ax, 1           
    pop di              
    ret

end_check:
    xor ax, ax          
    pop di              
    ret