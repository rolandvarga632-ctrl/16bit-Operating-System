disk_read:
  push ax
  push bx
  push cx
  push dx
  mov ah, 0x02
  mov ch, 0
  mov dh, 0
  mov dl, [boot_drive]
  int 0x13
  jnc disk_is_ok
  xor ah, ah
  int 0x13
  mov ah, 0x02
  mov ch, 0
  mov dh, 0
  int 0x13
  jc disk_error

disk_is_ok:
  pop dx
  pop cx
  pop bx
  pop ax
  ret

disk_write:
  push ax
  push bx
  push cx
  push dx
  mov ah, 0x03
  mov ch, 0
  mov dh, 0
  mov dl, [boot_drive]
  int 0x13
  jnc disk_is_ok
  xor ah, ah
  int 0x13
  mov ah, 0x03
  mov ch, 0
  mov dh, 0
  int 0x13
  jc disk_error
  pop dx
  pop cx
  pop bx
  pop ax

disk_error:
  mov si, disk_error_msg
  call write
  cli
  hlt


disk_error_msg db "Disk Error",13, 10, 0
