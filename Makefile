SOURCE_FOLDER=source
BIN_FOLDER=bin

all: boot

boot:
	make -f $(SOURCE_FOLDER)/boot/x86/Makefile
clean:
	rm -f $(SOURCE_FOLDER)/*.o
	rm -f $(BIN_FOLDER)/*
