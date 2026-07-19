run: img/os.img
	qemu-system-x86_64 -fda img/os.img

all: img/os.img
	

img/os.img: bootloader/boot.bin kernel/kernel.bin
	dd if=/dev/zero of=img/os.img bs=512 count=2048
	dd if=bootloader/boot.bin of=img/os.img bs=512 seek=0 conv=notrunc
	dd if=kernel/kernel.bin of=img/os.img bs=512 seek=1 conv=notrunc

bootloader/boot.bin: bootloader/bootloader.s
	nasm -f bin bootloader/bootloader.s -o bootloader/boot.bin

kernel/kernel.bin: kernel/kernel.s
	nasm -f bin kernel/kernel.s -o kernel/kernel.bin

clean:
	rm -f bootloader/boot.bin kernel/kernel.bin img/os.img