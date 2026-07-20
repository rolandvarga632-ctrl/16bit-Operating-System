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

  mov si, rmfile
  call strcmp
  test ax, ax
  jz RMFILE

  jmp not_equ


not_equ:
  cmp byte [di], 0
  je return
  mov si, no_command
  call write
  call clr_pfr
return:
  ret

no_command: db "Command not found!", 13, 10, 0