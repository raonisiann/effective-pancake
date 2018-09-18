OUT_DIR=$(ROOT_DIR)/$(BIN_DIR)
INCLUDE_DIR=-I$(SRC_DIR)/kernel/include
CC_FLAGS=$(INCLUDE_DIR)
CC_FLAGS+= -m32 -Wall -Os -fno-asynchronous-unwind-tables -fno-pie -nostdlib -ffreestanding -fno-exceptions

all: kmain.o
	ld --oformat binary -Tkmain.ld -o $(OUT_DIR)/kmain kmain.o

kmain.o:
	gcc -c -o kmain.o $(CC_FLAGS) kmain.c

clean:
	rm -f *.o
	rm -f $(OUT_DIR)/kmain
