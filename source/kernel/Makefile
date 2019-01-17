OUT_DIR=$(ROOT_DIR)/$(BIN_DIR)
INCLUDE_DIR=-I$(SRC_DIR)/kernel/include
CC_FLAGS=$(INCLUDE_DIR) -Wall -O0 -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin

all: kmain.o
	ld --oformat binary -Tkmain.ld -o $(OUT_DIR)/kmain kmain.o

kmain.o:
	gcc -c -o kmain.o $(CC_FLAGS) kmain.c

clean:
	rm -f *.o
	rm -f $(OUT_DIR)/kmain
