# DOS Assembly Programs and Utilities
I wrote these programs and utilities, when I was a teenager in the 90s, for MS-DOS 5.0 and MS-DOS 6.22 etc. I used (mostly) Turbo Assembler (TASM) and later (some) Microsoft Macro Assembler (MASM). I'll port each program to Netwide Assembler (NASM), add comments, and refactor code. Add a Makefile, and after testing them using FreeDOS or DOSBox, I'll add it here.

## Why are all projects .COM files?
Back in the days, I would write small utilities in real-mode x86 assembly to take advantage of the small size of .COM files. If I wanted to compile and link to .EXE files then I would rather prefer the C language (mostly Turbo C, and later Turbo C++).

## How to build?
I have added a `Makefile` in each project (directory). Use `GNU Make` (v4.4 or later) from DJGPP (or Linux build toolchain). You also need NASM to translate code to .COM files. However, since these are .COM files, therefore, you don't need any linker. NASM can write to a .COM file. 

> [!NOTE]
> Makefile contains commands for DOS (mkdir, del, etc). If you are using any other operating system then you might need to update the Makefile.

If you don't have `Make` but you have NASM then you can translate any project to .COM file, for example:
```
NASM -f bin -o HELLO.COM SRC/MAIN.ASM
```

## Projects
| Project | Description | Notes |
| --- | --- | --- |
| [Hello](hello/) | Hello world | Basic hello world program. Print "Hello, world!" to screen. |
| [ErrLvl](errlvl/) | Testing ERRORLEVEL | Exit program and sets ERRORLEVEL to 5. Testing returning error code to calling program. Call it from a DOS batch file to check returned ERRORLEVEL. |
| [PauseEnt](pauseent/) | Pause for ENTER key | Useful in DOS batch programs to make sure user press the ENTER key instead of accidentally pressing any key on keyboard. |
| [PauseSpc](pausespc/) | Pause for SPACE key | Useful in DOS batch programs to make sure user press the SPACE BAR key instead of accidentally pressing any key on keyboard. |
| [AsciiChr](asciichr/) | ASCII character set | Print Extended ASCII characters set (from 0 to 255) to screen. Useful to quickly check text-mode font. |
| [RomFont](romfont/) | Text-mode ROM font | Load text-mode (default) font stored in BIOS ROM. |
| [CmdArgs](cmdargs/) | Testing Command-line arguments | Print supplied command-line arguments to screen. It is a test to read and display command-line arguments to screen. Useful to process command-line arguments supplied by user or calling program. |
| [TailDir](taildir/) | Tail directory | Print tail part of the current directory. Useful in DOS batch files, especially if project name is same as directory name. |
| [PrjDir](prjdir/) | Project directory | Creates PRJNAME.BAT batch file in current directory and save tail part of current directory. Running that batch file will set PROJECT environment variable to tail directory. Useful for compiling and building projects when directory name and project name are same. If PRJNAME.BAT already exists then it will be overwritten. If executed in root directory then default project name "PROJECT" will be used, instead of empty string. <br /><br />**NOTE:** The original assembly code file was corrupted and probably lost forever. Therefore, I rewrote it. However, I tried to keep the original vibes. |
| [GetYN](getyn/) | Get user input of Y or N | If a prompt is given as command-line arguments then program will display it on screen and wait for user input of Y or N keys (case-insentive). If no prompt is given then silently wait for Y or N key input. User input is returned as exit code: 2 for N and 1 for Y. <br /><br />I wrote this program for the startup batch file for my game IceCream, which I mentioned in related backup files. I'll try to find that game in other source files backup. If I recall correctly, I wrote this program for MS-DOS 5.0, before CHOICE command was added in later versions of MS-DOS. |

## Lost Projects
There are many projects files which are probably lost forever due to corrupted copies of backup. I'll try to search and look in other backups. If I find more source code then I'll add them here.
