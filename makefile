all:
	nasm -f bin boot/boot.asm -o build/boot.bin
	nasm -f bin kernel/kernel.asm -o build/kernel.bin
	cat build/boot.bin build/kernel.bin > build/sleos.img

run:
	qemu-system-i386 -drive format=raw,file=build/sleos.img