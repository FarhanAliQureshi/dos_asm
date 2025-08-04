# DOS Assembly Programs and Utilities
I wrote these programs and utilities, when I was a teenager in the 90s, for MS-DOS 5.0 and MS-DOS 6.22 etc. I used (mostly) Turbo Assembler (TASM) and later (some) Microsoft Macro Assembler (MASM). I'll port each program to Netwide Assembler (NASM), add comments, and refactor code. Add a Makefile, and after testing them using FreeDOS or DOSBox, I'll add it here.

## Why are all projects .COM files?
Back in the days, I would write small utilities in real-mode x86 assembly to take advantage of the small size of .COM files. If I wanted to compile and link to .EXE files then I would rather prefer the C language (mostly Turbo C, and later Turbo C++).

## How to build?
I have added a `Makefile` in each project (directory). Use `GNU Make` (v4.4 or later) from DJGPP (or Linux build toolchain). You also need NASM to translate code to .COM files. However, since these are .COM files, therefore, you don't need any linker. NASM can write to a .COM file. 

_Please note that Makefile contains commands for DOS (mkdir, del, etc). If you are using any other operating system then you might need to update the Makefile._

If you don't have `Make` but you have NASM then you can translate any project to .COM file, for example:
```
NASM -f bin -o HELLO.COM SRC/MAIN.ASM
```
