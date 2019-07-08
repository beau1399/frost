g++ -c -w ./nonbison.cpp 
g++ -c -w ./frostcore.cpp 
gcc -c -w ./lex.yy.c
g++ -w -ofrostcompiler ./frost.tab.cpp  ./lex.yy.o ./frostcore.o ./nonbison.o -static
