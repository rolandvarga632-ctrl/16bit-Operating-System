shell:
    mov si, help_cmd

    call strcmp
    test ax, ax
    jz HELP_CMD

    mov si, clr_cmd
    call strcmp
    test ax, ax
    jz CLR_CMD

    jmp not_equ


not_equ:
    call clr_pfr
    ret