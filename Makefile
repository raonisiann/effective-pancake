shell=/bin/bash

export ROOT_DIR=$(shell pwd)
export SOURCE_DIR=source
export BIN_DIR=bin

BIN_DIR_EXISTS=$(shell ls | grep '^bin$$' | wc -l)

all: boot

boot:
ifeq ($(BIN_DIR_EXISTS),0)
	/bin/mkdir bin
endif
	$(MAKE) -C source/boot/x86

image:
	dd if=/dev/zero of=$(BIN_DIR)/hd.img bs=1K count=10
	dd if=$(BIN_DIR)/boot of=$(BIN_DIR)/hd.img bs=1 count=512 conv=fdatasync
	dd if=$(BIN_DIR)/kmain of=$(BIN_DIR)/hd.img bs=1 seek=512 conv=fdatasync
	chmod 755 $(BIN_DIR)/hd.img

clean:
	$(MAKE) clean -C source/boot/x86
	rm -f $(BIN_DIR)/*
