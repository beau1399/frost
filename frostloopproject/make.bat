
@echo off

REM "w2" option squelches warnings, shows errors

echo ASSEMBLING TARGET... 

"C:\Program Files\Microchip\MPASM Suite\MPAsmWin.exe" /w2 /q /p16f687 "target.asm" /l"target.lst" /e"target.err" /o"target.o"

type target.err


"C:\Program Files\Microchip\MPASM Suite\MPLink.exe" "f:\beau\frostcompiler\hloe16f687.lkr"  /p16f687 "target.o"  /o"hloe.hex" /M"hloe.map" /W
