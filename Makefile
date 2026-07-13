run: img/os.img
	qemu-system-x86_64 -hda img/os.img

all: img/os.img

img/os.img: bootloader/boot.bin kernel/kernel.bin
	cat bootloader/boot.bin kernel/kernel.bin > img/os.img

bootloader/boot.bin: bootloader/bootloader.s
	nasm -f bin bootloader/bootloader.s -o bootloader/boot.bin


kernel/kernel.bin: kernel/kernel.s kernel/shell.s kernel/commands.s kernel/functions.s
	nasm -f bin kernel/kernel.s -o kernel/kernel.bin


clean:
	rm -f bootloader/boot.bin
	rm -f kernel/kernel.bin
	rm -f img/os.img