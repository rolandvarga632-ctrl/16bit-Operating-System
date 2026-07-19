HELP_CMD:
  mov si, Help_msg
  call write
  call clr_pfr
  call clr_parser
  ret

CLR_CMD:
  call clr_screen
  call clr_pfr
  call clr_parser
  ret

HELLO_CMD:
  mov si, HELLO_msg
  call write
  call clr_pfr
  call clr_parser
  ret

MKFILE:
  mov si, arg
  call fs_search
  call clr_pfr
  call clr_parser
  ret

LS:
  call fs_list
  call clr_pfr
  call clr_parser 
  ret

HELLO_msg:  db "Hello from R16-DOS, have a nice day!",13, 10, 0
Help_msg:
  db "All Available commands:", 13, 10,10
  db "help - Show this message", 13, 10
  db "clear - Clear the screen", 13, 10
  db "hello - Greating message", 13,10
  db "mkfile - Create a file, useage: mkfile <filename>", 13, 10
  db "ls - list all available files", 13, 10, 0

hello_cmd:  db "hello",0
help_cmd: db "help",0
clr_cmd:  db "clear",0
mkfile_cmd: db "mkfile",0
ls_cmd: db "ls", 0
