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
clean:
	rm -f $(SOURCE_DIR)/*.o
	rm -f $(BIN_DIR)/*
