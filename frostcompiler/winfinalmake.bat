set path=%path%;c:\mingw\bin
set frost=C:\Users\james.wilkinson\Downloads\frost\frostcompiler\

del *.o
del frost.exe
c:\mingw\bin\g++ -c nonbison.cpp
c:\mingw\bin\g++ -c frostcore.cpp
c:\mingw\bin\gcc -c lex.yy.c
c:\mingw\bin\g++  -ofrost.exe frost.tab.cpp  lex.yy.o frostcore.o nonbison.o -static
pause
