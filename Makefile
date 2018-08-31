SOURCE_FOLDER=source
BIN_FOLDER=bin

all: boot

boot:
	$(MAKE) -C source/boot/x86
clean:
	rm -f $(SOURCE_FOLDER)/*.o
	rm -f $(BIN_FOLDER)/*
