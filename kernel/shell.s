shell:
  call parser_input
  mov si, help_cmd
  call strcmp
  test ax, ax
  jz HELP_CMD

  mov si, clr_cmd
  call strcmp
  test ax, ax
  jz CLR_CMD

  mov si, hello_cmd
  call strcmp
  test ax, ax
  jz HELLO_CMD

  mov si, mkfile_cmd
  call strcmp
  test ax, ax
  jz MKFILE

  mov si, ls_cmd
  call strcmp
  test ax, ax
  jz LS

  jmp not_equ


not_equ:
  call clr_pfr
  ret

