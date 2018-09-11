OUT_DIR =$(ROOT_DIR)/$(BIN_DIR)
CC_FLAGS = -c -fno-pic -static -fno-builtin -fno-strict-aliasing -Wall
CC_FLAGS += -m32 -Werror -fno-omit-frame-pointer -fno-stack-protector
CC_FLAGS += -I$(SRC_DIR)/boot/x86/include -I$(SRC_DIR)/kernel/include

all: boot.o kloader.o protectedm.o
	ld --oformat binary -Tboot.ld  -o $(OUT_DIR)/boot boot.o kloader.o protectedm.o

protectedm.o:
	gcc -o protectedm.o $(CC_FLAGS) protectedm.S

boot.o:
	gcc -o boot.o $(CC_FLAGS) boot.S

kloader.o:
	gcc -o kloader.o $(CC_FLAGS) kloader.S

clean:
	rm -f *.o
	rm -f $(OUT_DIR)/boot
