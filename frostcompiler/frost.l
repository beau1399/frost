%{
#define YYSTYPE char*
#include <stdio.h>
#include "frost.tab.hpp"
%}

%option noyywrap


%%



[\r] {}
[ \t\n]+  {printf(yytext); }
[\;] {printf(yytext); return SEMITOK;}
[d][ \t\n\r]+ {printf(yytext);  return DEETOK;}
[t][ \t\n\r]+  {printf(yytext); return TTETOK;}
[i][s][ \t\n\r]+  {printf(yytext); return ISTOK;}
[i][f][ \t\n\r]+  {printf(yytext); return IFTOK;}
[e][v][e][n][t][ \t\n\r]+ {printf(yytext); return EVENTTOK;}
[\.] {printf(yytext); return DOTTOK;}
[\[] {printf(yytext); return LPARENTOK;}
[\]] {printf(yytext); return RPARENTOK;}
[a-zA-Z][a-zA-Z0-9\-]*    {printf(yytext); yylval=strdup(yytext); return IDENTTOK;}
[0-9]+[ \t\n\r]+ {printf(yytext); yylval=strdup(yytext); return NATNUMTOK;}
[\-]?[0-9]*[\.]?[0-9]*    {printf(yytext); yylval=strdup(yytext); return NUMBERTOK;}
[\@] {printf(yytext); return ATTOK;}
[\>] {printf(yytext); return ASSIGNTOK;}
[\,] {printf(yytext); return COMMATOK;}
[\*] {printf(yytext); return STARTOK;}
[\'][a-zA-Z0-9\`\~\!\@\#\$\%\^\&\*\(\)\_\+\=\-\,\.\/\<\>\?\;\"\\\:\|\[\]\{\} ]*[\'] { printf(yytext);  yylval=strdup(yytext); return QUOTTOK;}
.                       { yyterminate();}

%%
