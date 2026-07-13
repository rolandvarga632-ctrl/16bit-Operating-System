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

HELLO_CMD:
  mov si, HELLO_msg
  call write
  call Enter
  call clr_pfr
  ret


HELLO_msg:
  db "Hello from R16-DOS, have a nice day!",13,10, 0
Help_msg:
  db "All available commands:", 13, 10,10
  db "help - show this message", 13, 10
  db "clear - clear the screen", 13, 10, 0

hello_cmd db "hello",0
help_cmd db "help",0
clr_cmd db "clear",0
