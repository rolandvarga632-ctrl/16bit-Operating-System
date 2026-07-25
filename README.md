--R16-DOS--

Egy egyszerű 16bites operációs rendszer x86 real mode-ban assembly nyelven írva.ű

A projekt célja a tanulás és egy MS-DOS-hoz hasonló os megvalósítása volt, saját alap MRB bootloader-el, kernel és egy nagyon alap és egyszerű fájlrendszerrel.

Jelenlegi állapot:
Elérhető parancsok:
help -- Elérhető parancsok listázása
hello -- Üdvözlő üzenet
clear -- Képernyő tisztítása
mkfile -- fájl létrehozása
ls -- fájlok listázása

Megvalósítás:
A bootloadeLemez elrendezés

Szektor 1: Bootloader
Szektor 2-4: Kernel
Szektor 5: Directory tábla
Szektor 6+: Fájlok tartalmar betölti a kernelt a lemezről.
Saját kernel.
Shell parancsértelmezővel.
Backspace és Enter kezelése.
Parancssoros argumentum feldolgozás (parancs + argumentum szétválasztása)
Saját egyszerű fájlrendszer:
Directory tábla a lemezen (max 24 fájl)

Tervezett funkciók:
rm <fájlnév> — fájl törlése
write <fájlnév> <tartalom> — fájlba írás
read <fájlnév> — fájl tartalmának kiírás

Technikai részletek
Architektúra x86 Real Mode (16 bit)
Nyelv NASM assembly
Bootloader MBR, 512 byte
Kernel méret 3 szektor (1536 byte)
Fájlrendszer Saját, egyszerű
Max fájlok 24
Max fájlméret 512 byte (1 szektor)

Lemez elrendezés
Szektor 1: Bootloader
Szektor 2-4: Kernel
Szektor 5: Directory tábla
Szektor 6+: Fájlok tartalma

--R16-DOS--

A simple 16-bit operating system written in assembly language for x86 real mode.
The goal of the project was learning and implementing an MS-DOS-like OS featuring a custom basic MBR bootloader, a kernel, and a very basic, simple filesystem.

Current State
Available commands:
help — List available commands
hello — Welcome message
clear — Clear the screen
mkfile — Create a file
ls — List files

Implementation:
The bootloader loads the kernel from the disk.
Custom kernel.
Shell command interpreter.
Backspace and Enter key handling.
Command-line argument processing (separating command + argument).
Custom simple filesystem:
Directory table on disk (max 24 files).

Planned Features:
rm <filename> — Delete a file
write <filename> <content> — Write to a file
read <filename> — Display file content

Technical Details:
Detail Specification

Architecturex86 Real Mode (16-bit)
Language NASM assembly
Bootloader MBR, 512 bytes
Kernel size 3 sectors (1536 bytes)
Filesystem Custom, simple
Max files 24
Max file size 512 bytes (1 sector)

Disk Layout
Sector 1: Bootloader

Sectors 2–4: Kernel

Sector 5: Directory table

Sectors 6+: File contents
