all:
		as --32 ./src/asm/boot.s -o ./bin/boot.o
		gcc -m32 -c src/kernel/kernel.c -o ./bin/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
		ld -m elf_i386 -T ./kernel/linker.ld ./bin/kernel.o ./bin/boot.o -o ./out/RatKernel.bin -nostdlib
		grub-file --is-x86-multiboot ./out/RatKernel.bin
		mkdir -p isodir/boot/grub
		cp ./out/RatKernel.bin isodir/boot/RatKernel.bin
		cp ./kernel/grub.cfg isodir/boot/grub/grub.cfg
		grub-mkrescue -o ./out/Rat.iso isodir
		qemu-system-x86_64 -cdrom ./out/Rat.iso
