DEPLOYER=dd
ASM=nasm
FLAGS=bs=1 count=$(shell ls -lh bin/boot | cut -d' ' -f5)
SOURCE_FOLDER=source
BIN_FOLDER=bin
BOOT_FILE=$(SOURCE_FOLDER)/boot.s
OUT_DEV=/dev/sdb
LD_FLAGS=-static -T$(SOURCE_FOLDER)/setup.ld -M

all: boot.o
	ld --oformat binary -o $(BIN_FOLDER)/boot $(LD_FLAGS) $(SOURCE_FOLDER)/boot.o 

main.o:
	gcc -c -o $(SOURCE_FOLDER)/main.o $(SOURCE_FOLDER)/main.c 

boot.o:
	as -o $(SOURCE_FOLDER)/boot.o $(BOOT_FILE)

deploy:
	$(DEPLOYER) if=$(BIN_FOLDER)/boot of=$(OUT_DEV) $(FLAGS)

clean:
	rm -f $(SOURCE_FOLDER)/*.o
	rm -f $(BIN_FOLDER)/*
