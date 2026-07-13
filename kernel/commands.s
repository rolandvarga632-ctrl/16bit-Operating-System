HELP_CMD:
  mov si, Help_msg
  call write
  call Enter
  call clr_pfr
  ret

CLR_CMD:
  call clr_screen
  call clr_pfr
  ret


Help_msg:
  db "All available commands:", 13, 10,10
  db "help - show this message", 13, 10
  db "clear - clear the screen", 13, 10, 0

help_cmd db "help",0
clr_cmd db "clear",0
