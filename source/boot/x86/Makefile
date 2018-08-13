
BIN_FOLDER=../../../bin
OUT_DEV=/dev/sdb

LD_FLAGS=-static -Tsetup.ld
DD_FLAGS=bs=1 count=$(shell ls -l ../../../bin/boot | cut -d' ' -f5)
CC_FLAGS=
AS_FLAGS=

all: boot.o kloader.o kernel.o
	ld --oformat binary -o $(BIN_FOLDER)/boot $(LD_FLAGS) boot.o kloader.o
	ld -estart_kernel -static --oformat binary -o $(BIN_FOLDER)/kernel kernel.o
main.o:
	gcc -c -o main.o $(CC_FLAGS) main.c 

kernel.o:
	as -o kernel.o $(AS_FLAGS) kernel.s

boot.o:
	as -o boot.o $(AS_FLAGS) boot.s

kloader.o:
	as -o kloader.o $(AS_FLAGS) kloader.s

deploy:
	dd if=$(BIN_FOLDER)/boot of=$(OUT_DEV) $(DD_FLAGS)
	dd if=$(BIN_FOLDER)/kernel of=$(OUT_DEV) bs=1 seek=512 count=$(shell ls -l ../../../bin/kernel | cut -d' ' -f5)
erase:
	dd if=/dev/zero of=/dev/sdb count=2048 bs=1
clean:
	rm -f *.o
	rm -f $(BIN_FOLDER)/boot
