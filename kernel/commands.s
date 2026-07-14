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
  db "All Available commands:", 13, 10,10
  db "help - Show this message", 13, 10
  db "clear - Clear the screen", 13, 10
  db "hello - Greating message", 13, 10, 0

hello_cmd db "hello",0
help_cmd db "help",0
clr_cmd db "clear",0
