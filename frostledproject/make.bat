
echo ASSEMBLING TARGET...
wine 'c:/Program Files (x86)/Microchip/MPASM Suite/MPASMWIN.exe' /w2 /q /p16f1827 "target.asm" /l"target.lst" /e"target.err" /otarget.o
cat target.err

wine 'c:/Program Files (x86)/Microchip/MPASM Suite/MPLink.exe' "../frostcompiler/hloe16f1827.lkr"  target.o  /o"hloe.hex" /M"hloe.map" /W
