shell=/bin/bash

export ROOT_DIR=$(shell pwd)
export SRC_DIR=$(ROOT_DIR)/source
export BIN_DIR=bin

BIN_DIR_EXISTS=$(shell ls | grep '^bin$$' | wc -l)

IMG_SECTORS=1008

all: boot kmain

boot:
ifeq ($(BIN_DIR_EXISTS),0)
	/bin/mkdir bin
endif
	$(MAKE) -C $(SRC_DIR)/boot/x86

kmain:
	$(MAKE) -C $(SRC_DIR)/kernel

image:
	dd if=/dev/zero of=$(BIN_DIR)/hd.img bs=1K count=10
	dd if=$(BIN_DIR)/boot of=$(BIN_DIR)/hd.img bs=1 count=512 conv=fdatasync
	dd if=$(BIN_DIR)/kmain of=$(BIN_DIR)/hd.img bs=1 seek=512 conv=fdatasync
	chmod 755 $(BIN_DIR)/hd.img

bochs:
	dd if=/dev/zero of=$(BIN_DIR)/hd.img bs=512 count=$(IMG_SECTORS)
	dd if=$(BIN_DIR)/boot of=$(BIN_DIR)/hd.img bs=1 count=512 conv=fdatasync,notrunc
	dd if=$(BIN_DIR)/kmain of=$(BIN_DIR)/hd.img bs=1 seek=512 conv=fdatasync,notrunc

clean:
	$(MAKE) clean -C $(SRC_DIR)/boot/x86
	$(MAKE) clean -C $(SRC_DIR)/kernel
