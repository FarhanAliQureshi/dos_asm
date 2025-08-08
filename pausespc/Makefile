# Use GNU Make v4.4 (or later) from DJGPP (or linux build toolchain)
# This Makefile is written for DOS commands. If you are using any other
# operating system then use its commands (for example: mkdir, del, etc).

PROJECT = pausespc
OUTPUT_DIR = BUILD
SOURCE_DIR = SRC
OUTPUT_FILE = $(OUTPUT_DIR)/$(PROJECT).COM
SRC_FILES = $(SOURCE_DIR)/MAIN.ASM
FLAGS = -f bin
ASSEMBLER = NASM

.PHONY: all
all: $(OUTPUT_FILE)

$(OUTPUT_FILE): $(SRC_FILES)
	@echo Assembling code...
	@mkdir $(OUTPUT_DIR)
	$(ASSEMBLER) $(FLAGS) -o $@ $^

.PHONY: debug
debug: $(OUTPUT_FILE)
	@echo Launching GNU Debugger...
	gdb $<
	
.PHONY: run
run: $(OUTPUT_FILE)
	$< $(filter-out $@,$(MAKECMDGOALS))

.PHONY: clean
clean: 
	@echo Removing all files generated using source files
	@del $(OUTPUT_DIR)\*.* > silent
	@rmdir $(OUTPUT_DIR) > silent
	@del silent