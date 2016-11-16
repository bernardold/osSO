all:
	@as --32 bootloader.s -o bootloader.o
	@gcc -m32 -c kernel.c -o kernel.o -ffreestanding -nostdinc
	@gcc -m32 -T  linker.ld -o  kernel.bin -nostdlib -ffreestanding bootloader.o kernel.o 
	@qemu-system-i386 -kernel kernel.bin 

	@# VER: http://arjunsreedharan.org/post/82710718100/kernel-101-lets-write-a-kernel
	@# 		http://wiki.osdev.org/Bare_Bones#Building_a_bootable_cdrom_image

clean:
	rm ./*.bin ./*.o ./*.elf
