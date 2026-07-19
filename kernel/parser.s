parser_input:
  mov si, command
parser_command_loop:
  mov al, [di]
  cmp al, 0x20
  je parser_arg
  cmp al, 0
  je parser_command_end
  mov [si], al
  inc di
  inc si
  jmp parser_command_loop
parser_arg:
  mov byte [si], 0
  inc di
  mov si, arg
parser_arg_loop:
  mov al, [di]
  cmp al, 0
  je parser_end
  mov [si], al
  inc di
  inc si
  jmp parser_arg_loop
parser_command_end:
  mov byte [si], 0
  mov di, command
  ret
parser_end:
  mov byte [si], 0
  mov di, command
  ret
  

clr_parser:
  mov di, command
  mov si, arg
  mov cx, 16
clr_parser_loop:
  mov byte [di], 0
  mov byte [si], 0
  loop clr_parser_loop
  ret