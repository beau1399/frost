set frost=C:\Users\james.wilkinson\Downloads\frost\frostcompiler\
del hloe.hex
REM %frost%frost.exe file sieve.frost proc 16f690 board lpc nobounds
%frost%frost.exe file sieve.frost proc 16f1827 board nextsys nobounds
pause
