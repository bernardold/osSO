/*  VER:    http://wiki.osdev.org/Bare_Bones#Building_a_bootable_cdrom_image
            http://arjunsreedharan.org/post/82710718100/kernel-101-lets-write-a-kernel */
            
OUTPUT_FORMAT(elf32-i386)
ENTRY(_start)
SECTIONS
 {
   . = 0x100000;
   .text : { *(.text) }
   .data : { *(.data) }
   .bss  : { *(.bss)  }
 }