STATUS_OFFSET equ 20
FS_START_ADR equ 0x8000
MAX_FILES equ 0x18
SECTOR_OFFSET equ 18
NEXT_SECTOR_OFFSET equ 512
FILENAME_OFFSET equ 16
FIRST_SECTOR equ 0x06

fs_find:
  mov bx, 0x8000
  mov al, 1
  mov cl, 5
  call disk_read
  mov di, 0x8001
  mov cx, 24
  push ax
  mov ax, 0
find_loop:
  cmp byte [di + STATUS_OFFSET], 0x01
  je there_is_file
  add di, 21
  inc ax
  loop find_loop
  jmp there_is_no_file
there_is_file:
  mov si, arg
  inc ax
  push ax
  call strcmp
  test ax, ax
  jz file_match
  pop ax
  add di, 21
  loop find_loop
file_match:
  add di, SECTOR_OFFSET
  xor ax, ax
  ret
there_is_no_file:
  mov ax, 1 
  mov si, not_found
  call write
  ret

file_remove:
  pop ax
  mov bx, FS_START_ADR
  add bx, ax
  mov al, 1
  mov cl, [di]
  call disk_read
  ret


fs_search:
  mov bx, 0x8000
  mov al, 1
  mov cl, 5
  call disk_read
  mov di, 0x8001
  mov cx, 24
  push ax
  mov ax, 0
search_loop:
  cmp byte [di + STATUS_OFFSET], 0
  je fs_create
  add di, 21
  inc ax
  loop search_loop
  jmp fs_full

; if directory is full
fs_full:
  mov si, full_msg
  call write
  ret

fs_create:
  mov cx, FILENAME_OFFSET
  push di
  push ax
write_file_name:
  mov al, [si]
  cmp al, 0
  je fill_the_remainder
  mov [di], al
  inc di
  inc si
  loop write_file_name
  jmp start_sector
start_sector:
  pop ax
  pop di
  add ax, FIRST_SECTOR
  mov word [di + SECTOR_OFFSET], ax
write_status:
  mov byte [di + STATUS_OFFSET], 0x01
write_to_disk:
  mov bx, 0x8000
  mov al, 1
  mov cl, 5
  call disk_write
  pop ax
  ret
fill_the_remainder:
  mov byte [di], 0
  inc di
  loop fill_the_remainder
  jmp start_sector

fs_list:
  mov bx, 0x8000
  mov al, 1
  mov cl, 5
  call disk_read
  mov di, 0x8001
  mov cx, 24
list_search_loop:
  cmp di, 0x81F9
  jge end_of_dir
  cmp byte [di+20], 0x01
  je print_file
  add di, 21
  loop list_search_loop
  ret
print_file:
  push di
  mov si, file_name
print_loop:
  mov al, [di]
  cmp al, 0
  je end_of_filename
  mov [si], al
  inc di
  inc si
  jmp print_loop
end_of_filename:
  push si
  mov si, file_name
  mov al, [si]
  cmp al, 0
  jz bad_val
  pop si
  mov byte [si], BOTL
  inc si
  mov byte [si], NEWLINE
  inc si
  mov byte [si], 0
  mov si, file_name
  call write
  pop di
  add di, 21
  call clr_filename
  jmp list_search_loop
end_of_dir:
  ret
bad_val:
  pop di
  add di, 21
  call clr_filename_puffer
  jmp list_search_loop

clr_filename:
  push cx
  mov si, file_name
  mov cx, 16
clr_filename_puffer:
  mov byte [si], 0
  inc si
  loop clr_filename_puffer
  pop cx
  ret
  
file_name times 16 db 0
not_found db "File not found!", 13, 10, 0
full_msg db "The file directory is full(24 file max).",13, 10, 0