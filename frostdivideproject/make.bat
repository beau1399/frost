
@echo off

REM "w2" option squelches warnings, shows errors

echo ASSEMBLING TARGET... 

"C:\Program Files (x86)\Microchip\MPASM Suite\MPAsmWin.exe" /w2 /q /p16f690 "target.asm" /l"target.lst" /e"target.err" /o"target.o"

type target.err


"C:\Program Files (x86)\Microchip\MPASM Suite\MPLink.exe" "C:\Users\james.wilkinson\Downloads\frost\frostcompiler\hloe16f690.lkr"  /p16f690 "target.o"  /o"hloe.hex" /M"hloe.map" /W
