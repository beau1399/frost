
echo ASSEMBLING TARGET...
wine 'c:/Program Files (x86)/Microchip/MPASM Suite/MPASMWIN.exe' /w2 /q /p16F690 "target.asm" /l"target.lst" /e"target.err" /otarget.o
cat target.err

wine 'c:/Program Files (x86)/Microchip/MPASM Suite/MPLink.exe' "../frostcompiler/hloe16F690.lkr"  target.o  /o"hloe.hex" /M"hloe.map" /W
