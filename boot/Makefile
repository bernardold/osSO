PROG = boot
CURRENT_DIR = $(shell pwd)
ECHO_OPT = -ne
BOOT_SIGNATURE = seek=510 bs=1
SIGNATURE_DUMP = signature
ASSEMBLER_FLAGS = --32 -o
LINKER_FLAGS = -m elf_i386
OPT_LK_FLAGS = -nostdlib -N -Ttext 7C00
DUMP_OPT = -O binary

all: clean assembly link object appending
assembly:
	as $(ASSEMBLER_FLAGS) $(PROG).o $(PROG).s
link:
	ld $(LINKER_FLAGS) $(OPT_LK_FLAGS) $(PROG).o -o $(PROG).elf
object:
	objcopy $(DUMP_OPT) $(PROG).elf $(PROG).bin
test:
	qemu-system-i386 $(PROG).bin -boot a
clean:
	@rm -rf ./*.bin ./*.o ./*.elf
appending:
	dd $(BOOT_SIGNATURE) if=$(SIGNATURE_DUMP) of=$(CURRENT_DIR)/$(PROG).bin
debug: clean assembly link object appending
	hexdump -C $(PROG).bin
full: clean assembly link object appending test
