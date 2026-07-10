all:
	@nasm -f bin bootloader/bootloader.s -o bootloader/bootloader.bin
	@nasm -f bin kernel/kernel.s -o kernel/kernel.bin
	@cat bootloader/bootloader.bin kernel/kernel.bin > img/os.img
	@qemu-system-x86_64 -hda img/os.img