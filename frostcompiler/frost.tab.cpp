/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 2 "frost.ypp" /* yacc.c:339  */

#define YYSTYPE char*
#include<iostream>
#include<fstream>
#include<vector> 
#include<set>
#include<string>
#include<map>
#include<sstream>
#include<stack>
#include<ctime>
#include<cstdio> //Actual flex generation of C++ parser is experimental, so we need this
#include<cstring>
#include<algorithm>
 //Often too broad, here it avoids about a dozen "using" statments
 using namespace std;
#define NULL_ARGS -1 //Placeholder for "program did not supply an argument count"
#include "state.h"
 //From (F)lex 
 extern "C"
 {
  void yyset_in ( FILE *  in_str  );
  int yyparse(void);
  int yylex(void);  
  int yywrap()
  {
   return 1;
  }
 }
#include "frostcore.h"
#include "nonbison.h"
 static compilerstate c;
 //The output stream
 ofstream target_s("target.tmp");  //Generated assembly language output
 ofstream inc_file_s("hloe.inc");  //Included by libraries, allow portability
 ofstream make_file_s("make.bat"); //Build script for target
 int yyerror(const char * str)
 {
  cout<<"^"<<str<<endl;
  exit(0);
  return 0;
 }
 

#line 111 "frost.tab.cpp" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "frost.tab.hpp".  */
#ifndef YY_YY_FROST_TAB_HPP_INCLUDED
# define YY_YY_FROST_TAB_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    DOTTOK = 258,
    LPARENTOK = 259,
    RPARENTOK = 260,
    SEMITOK = 261,
    IDENTTOK = 262,
    NUMBERTOK = 263,
    DEETOK = 264,
    ISTOK = 265,
    ATTOK = 266,
    IFTOK = 267,
    ASSIGNTOK = 268,
    COMMATOK = 269,
    STARTOK = 270,
    EVENTTOK = 271,
    QUOTTOK = 272,
    TTETOK = 273,
    NATNUMTOK = 274
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_FROST_TAB_HPP_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 182 "frost.tab.cpp" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   114

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  20
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  21
/* YYNRULES -- Number of rules.  */
#define YYNRULES  37
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  63

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   274

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    49,    49,    50,    49,    57,    57,    57,    61,    73,
      73,    74,    74,    74,    80,    80,   126,   126,   133,   133,
     134,   134,   135,   157,   169,   169,   171,   178,   182,   188,
     190,   210,   256,   285,   306,   308,   325,   346
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "DOTTOK", "LPARENTOK", "RPARENTOK",
  "SEMITOK", "IDENTTOK", "NUMBERTOK", "DEETOK", "ISTOK", "ATTOK", "IFTOK",
  "ASSIGNTOK", "COMMATOK", "STARTOK", "EVENTTOK", "QUOTTOK", "TTETOK",
  "NATNUMTOK", "$accept", "prog", "$@1", "$@2", "vents", "$@3", "ventit",
  "proc", "defs", "$@4", "defit", "$@5", "$@6", "tcollect", "numbv",
  "tabit", "signature", "unity", "unit", "conditi", "fcall", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274
};
# endif

#define YYPACT_NINF -14

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-14)))

#define YYTABLE_NINF -7

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -14,     5,   -10,   -14,   -14,    -9,    95,     3,   -14,     2,
     -14,   -14,     6,   -14,     8,   -14,   -14,   -14,   -14,   -14,
     -14,   -14,   -14,   -14,    18,    19,   -14,    13,   -14,    33,
     -14,   -14,   -14,    -7,    28,    41,    54,    34,    35,   -14,
     -14,   -14,   -14,    43,    44,    67,   -14,   -14,   -14,   -11,
     -14,   -14,    23,    45,    -5,   -14,   -14,   -14,   -14,   -14,
     -14,    82,   -14
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       5,     0,     2,     1,    27,     0,     3,     0,     7,     0,
      35,    20,     0,    27,     0,    30,    21,    11,    31,    28,
      34,    29,    10,     9,     0,     0,    32,     0,    33,    12,
      27,    27,    27,     0,     0,     0,     0,     0,     0,    13,
       8,    37,    27,     0,     0,     0,    14,    16,    36,    24,
      18,    25,     0,     0,     0,    26,    27,    17,    23,    22,
      19,     0,    15
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -14,   -14,   -14,   -14,   -14,   -14,   -14,   -14,   -14,   -14,
     -14,   -14,   -14,   -14,     9,   -14,   -14,   -13,   -14,   -14,
     -14
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     1,     4,    17,     2,     5,     8,    24,    29,    33,
      39,    49,    50,    54,    18,    60,    53,     6,    19,    20,
      21
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      27,    57,    37,    11,    51,     3,    -6,     7,    52,    25,
      22,    38,    58,    26,    16,    28,     9,    34,    35,    36,
      10,    11,    23,    31,    12,    13,    14,    32,    30,    45,
      15,     9,    16,    -4,    40,    10,    11,    43,    44,    12,
      13,    14,    55,    61,     9,    15,    41,    16,    10,    11,
      46,    47,    12,    13,    14,    56,     0,     9,    15,     0,
      16,    10,    11,    59,     0,    12,    13,    14,    42,     0,
       9,    15,     0,    16,    10,    11,     0,     0,    12,    13,
      14,    48,     0,     0,    15,     9,    16,     0,    62,    10,
      11,     0,     0,    12,    13,    14,     0,     0,     9,    15,
       0,    16,    10,    11,     0,     0,    12,    13,    14,     0,
       0,     0,    15,     0,    16
};

static const yytype_int8 yycheck[] =
{
      13,     6,     9,     8,    15,     0,    16,    16,    19,     7,
       7,    18,    17,     7,    19,     7,     3,    30,    31,    32,
       7,     8,    19,     4,    11,    12,    13,    14,    10,    42,
      17,     3,    19,     0,     6,     7,     8,     3,     3,    11,
      12,    13,    19,    56,     3,    17,     5,    19,     7,     8,
       7,     7,    11,    12,    13,    10,    -1,     3,    17,    -1,
      19,     7,     8,    54,    -1,    11,    12,    13,    14,    -1,
       3,    17,    -1,    19,     7,     8,    -1,    -1,    11,    12,
      13,    14,    -1,    -1,    17,     3,    19,    -1,     6,     7,
       8,    -1,    -1,    11,    12,    13,    -1,    -1,     3,    17,
      -1,    19,     7,     8,    -1,    -1,    11,    12,    13,    -1,
      -1,    -1,    17,    -1,    19
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    21,    24,     0,    22,    25,    37,    16,    26,     3,
       7,     8,    11,    12,    13,    17,    19,    23,    34,    38,
      39,    40,     7,    19,    27,     7,     7,    37,     7,    28,
      10,     4,    14,    29,    37,    37,    37,     9,    18,    30,
       6,     5,    14,     3,     3,    37,     7,     7,    14,    31,
      32,    15,    19,    36,    33,    19,    10,     6,    17,    34,
      35,    37,     6
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    20,    22,    23,    21,    24,    25,    24,    26,    27,
      27,    28,    29,    28,    31,    30,    32,    30,    33,    33,
      34,    34,    35,    35,    36,    36,    36,    37,    37,    38,
      38,    38,    38,    38,    38,    38,    39,    40
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     0,     5,     0,     0,     3,     5,     1,
       1,     0,     0,     3,     0,     8,     0,     6,     0,     2,
       1,     1,     1,     1,     0,     1,     2,     0,     2,     1,
       1,     1,     2,     2,     1,     1,     7,     5
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 49 "frost.ypp" /* yacc.c:1646  */
    {c.in_isr=0;}
#line 1307 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 3:
#line 50 "frost.ypp" /* yacc.c:1646  */
    {
 insert_file(get_module_name(("header"),(".inc"),0,1),target_s);
 target_s<<(yyvsp[0]); //UNITY
 free((yyvsp[0]));
 emit_inclusion("progend",".inc","","",target_s); //
}
#line 1318 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 6:
#line 57 "frost.ypp" /* yacc.c:1646  */
    {
 c.multitask=1;
 c.in_isr=1;
}
#line 1327 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 8:
#line 62 "frost.ypp" /* yacc.c:1646  */
    {
 string fname_procno("process");//Get snippet from .inc, to reset this event's interrupt
 fname_procno.append(1,(yyvsp[-3])[0]); 
 ostringstream osproc; 
 osproc<<((int)(fname_procno.substr(fname_procno.length()-1).c_str())[0]);
 emit_inclusion(
 fname_procno,(".inc"),osproc.str().c_str(),osproc.str().c_str(),target_s); // //
 target_s<<(yyvsp[-1]); //UNITY
 free((yyvsp[-1]));
 emit_inclusion("isrjump",".inc",((int)(yyvsp[-3])[0]),((int)(yyvsp[-3])[0]),target_s);    
}
#line 1343 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 12:
#line 74 "frost.ypp" /* yacc.c:1646  */
    {
 c.nofparms=NULL_ARGS;
 c.nofrets=NULL_ARGS; 
}
#line 1352 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 14:
#line 80 "frost.ypp" /* yacc.c:1646  */
    {c.in_function=(yyvsp[0]);
 transform(c.in_function.begin(), c.in_function.end(), c.in_function.begin(), makefunctionname);       
 //HAVING this intermediate rule somehow breaks our ability to use $6 later
 // but the rule is nececcsarry to set "in_function"
}
#line 1362 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 15:
#line 85 "frost.ypp" /* yacc.c:1646  */
    {
 //If put here, then we get actual code for the funciont implementation TODO, but in_function is wrong
 //c.in_function=$3; 
 emit_inclusion(("startfunc"),(".inc"),c.labels,c.labels,target_s);  //
 ++c.labels;
 target_s<<c.in_function<<":\n"; //
 if((c.nofparms!=NULL_ARGS)||(c.nofrets!=NULL_ARGS)||c.star)
 {//Push new base ptr. for this call 
  insert_file(get_module_name(("getptr"),(".inc"),0,1),target_s);
  emit_inclusion(("invokeb"),(".inc"),c.in_function,c.in_function,target_s);
 }
 target_s<<    (yyvsp[-1]); //UNITY object code
 free((yyvsp[-1]));
 // FUNCTION DEFINITION WRAP-UP //////////////////////////////////////////////
 if((c.nofparms!=NULL_ARGS)||(c.nofrets!=NULL_ARGS)) 
 emit_inclusion(("invokec"),(".inc"),c.in_function,c.in_function,target_s);
 else if(c.star)
 emit_inclusion(("hlkdiscard"),(".inc"),"","",target_s);
 if((c.nofparms!=NULL_ARGS)||(c.nofrets!=NULL_ARGS)) //Function cleanup routine
 {   
  if(c.nofrets>0) 
  insert_file(get_module_name(("savetemp"),(".inc"),0,1),target_s); //Base ptr.     
  for(int np=0; np<c.nofrets; ++np) //Pop retvals to kernel stack; return values will...
  emit_inclusion(("transfer"),(".inc"),c.in_function,c.in_function,target_s);
  if(c.nofrets>0) //Return to this function's BP
  insert_file(get_module_name(("gettemp"),(".inc"),0,1),target_s);  
  insert_file(get_module_name(("loadptr"),(".inc"),0,1),target_s);    
  for(int np=0; np<c.nofparms; ++np) 
  emit_inclusion(("hldiscard"),(".inc"),"","",target_s); //Clean up args this call
  for(int np=0; np<c.nofrets; ++np)//Get retval(s) back from stack
  {
   emit_inclusion(("invoked"),(".inc"),c.in_function,c.in_function,target_s);
   if(c.checks)
   emit_inclusion(("invokee"),(".inc"),c.in_function,c.in_function,target_s);
   else
   target_s<<"\n PUSH \n";
  }
 }
 emit_inclusion(("return"),(".inc"),"","",target_s);
}
#line 1407 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 16:
#line 126 "frost.ypp" /* yacc.c:1646  */
    {
 emit_inclusion(("starttbl"),(".inc"),c.labels,c.labels,target_s); 
 ++c.labels;   
 string intbl=(yyvsp[0]);
 transform(intbl.begin(), intbl.end(), intbl.begin(), makefunctionname);          
 target_s<<" "<<intbl<<endl;
}
#line 1419 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 22:
#line 136 "frost.ypp" /* yacc.c:1646  */
    {
 string thenum((yyvsp[0]));
 if(thenum.find(".")==string::npos)
 {
  int ix;
  istringstream realsr(thenum);
  realsr>>ix; 
  emit_inclusion(("retbegin"),(".inc"),"","",target_s);
  target_s<<ix;
 }else{
  float f;
  unsigned char m,e;
  istringstream realsr(thenum);
  realsr>>f; 
  make_real(f,m,e);
  emit_inclusion(("retbegin"),(".inc"),"","",target_s);
  target_s<<((int)m);
  emit_inclusion(("retbegin"),(".inc"),"","",target_s);
  target_s<<((int)e);  
 }
}
#line 1445 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 23:
#line 157 "frost.ypp" /* yacc.c:1646  */
    {
 string fscbuffer=(yyvsp[0]);
 do{
  fscbuffer.erase(0,1);
  //Translate " to ' to allow ' in frost strings
  if(fscbuffer[0]!='\"') emit_inclusion(("rettbl"),(".inc"),((int)(unsigned char)fscbuffer[0]),((int)(unsigned char)fscbuffer[0]),
  target_s);
  else 
  emit_inclusion(("rettbl"),(".inc"),((int)('\'')),((int)('\'')),target_s);
 }while(fscbuffer[1]!='\'' && fscbuffer[0]!='\'');
}
#line 1461 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 24:
#line 169 "frost.ypp" /* yacc.c:1646  */
    {c.star=0;}
#line 1467 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 25:
#line 169 "frost.ypp" /* yacc.c:1646  */
    {c.star=1;
}
#line 1474 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 26:
#line 171 "frost.ypp" /* yacc.c:1646  */
    {
 istringstream realsr((yyvsp[-1]));
 realsr>>c.nofparms;
 istringstream realtr((yyvsp[0]));
 realtr>>c.nofrets; 
 c.star=0;  
}
#line 1486 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 27:
#line 178 "frost.ypp" /* yacc.c:1646  */
    {
 char * buffer=(char*)malloc(strlen("")+1); //Leex TODO
 sprintf(buffer,"");
 (yyval)=buffer;
}
#line 1496 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 28:
#line 182 "frost.ypp" /* yacc.c:1646  */
    {
 char * buffer=(char*)malloc(strlen((yyvsp[-1]))+strlen((yyvsp[0]))+1);
 sprintf(buffer,(yyvsp[-1])); 
 strcat(buffer,(yyvsp[0]));
 (yyval)=buffer; 
}
#line 1507 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 30:
#line 191 "frost.ypp" /* yacc.c:1646  */
    {
 ostringstream os1; 
 for(int multich=strlen((yyvsp[0]))-2;multich>=1;--multich)
 {
  os1<<endl<<" ; char "<<(yyvsp[0])<<"\n";
  emit_inclusion(("posmov2"),(".inc"),"","",os1); //     
  os1<<((int)(unsigned char)((yyvsp[0])[multich]))<<endl; 
  if(c.checks)
  emit_inclusion(("safep2"),(".inc"),c.memzone,c.memzone,os1);
  else
  os1<<"\n PUSH \n";
 }
 //TODO abstract over this repetitive crap
 char * buffer=(char*)malloc(strlen(os1.str().c_str())+1);//Oops! leaks... TODO!
 sprintf(buffer,os1.str().c_str()); 
 (yyval)=buffer; 
}
#line 1529 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 31:
#line 210 "frost.ypp" /* yacc.c:1646  */
    {
 ostringstream os1; 
 string thenum((yyvsp[0]));
 //This is repeated ... is there a better way TODO
 if(c.in_function.length()) c.memzone=c.in_function; 
 else c.memzone=(c.in_isr)?"ISR":"hlluserprog"; //Allows proper paging for "far" return
 if(thenum.find(".")==string::npos)
 {
  //INTEGER
  if((yyvsp[0])[0]=='-')
  {
   emit_inclusion(("negmove"),(".inc"),"","",os1);  
   os1<<(yyvsp[0])+1; 
  }
  else
  {
   emit_inclusion(("posmove"),(".inc"),"","",os1); //
   os1<<(yyvsp[0]); //NEW STREAM
  }
  if(c.checks)
  emit_inclusion(("wdsp"),(".inc"),c.memzone,c.memzone,os1);  
  else
  os1<<"\n PUSH \n";  //
 }else{
  //FLOAT
  float f;
  int pointFound=0;
  unsigned char m,e;
  istringstream realsr((yyvsp[0]));
  realsr>>f; 
  make_real(f,m,e);
  emit_inclusion(("loadm"),(".inc"),(int)m,(int)m,os1);  
  if(c.checks)
  emit_inclusion(("wrsp1"),(".inc"),c.memzone,c.memzone,os1);  
  else
  os1<<"\n PUSH \n"; 
  emit_inclusion(("loade"),(".inc"),(int)e,(int)e,os1);
  if(c.checks)
  emit_inclusion(("wrsp2"),(".inc"),c.memzone,c.memzone,os1);
  else
  os1<<"\n PUSH \n";
 }
 char * buffer=(char*)malloc(strlen(os1.str().c_str())+1);//Oops! leaks... TODO!
 sprintf(buffer,os1.str().c_str()); 
 (yyval)=buffer; 
}
#line 1580 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 32:
#line 256 "frost.ypp" /* yacc.c:1646  */
    {
 // DEREFERENCE //////////////////////////////////////////////////////////
 bool is_var=0;
 set<string>::iterator pstats=c.statics.begin();   
 string slot=(yyvsp[0]);
 ostringstream os1;
 while(pstats!=c.statics.end())                
 {
  if(!(pstats->compare(slot))){ is_var=1; break;}
  ++pstats;
 }
 if(!is_var)
 { 
  //Variable dereference of MPASM constant reg. file name... we must
  // force this to uppercase and also make - into _
  transform(slot.begin(), slot.end(), slot.begin(), makempasmid);
 }
 if(c.in_function.length()) c.memzone=c.in_function; 
 else c.memzone=(c.in_isr)?"ISR":"hlluserprog"; //Allows proper paging for "far" return
 emit_inclusion(("at"),(".inc"),slot,slot,os1);
 if(c.checks)
 emit_inclusion(("at2"),(".inc"),c.memzone,c.memzone,os1);
 else
 os1<<"\n PUSH \n";
 char * buffer=(char*)malloc(strlen(os1.str().c_str())+1);//Oops! leaks... TODO!
 sprintf(buffer,os1.str().c_str()); 
 (yyval)=buffer; 
}
#line 1613 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 33:
#line 285 "frost.ypp" /* yacc.c:1646  */
    {
 ostringstream os1;
 bool is_var=0;
 set<string>::iterator pstats=c.statics.begin();   
 while(pstats!=c.statics.end())                
 {
  if(!(pstats->compare((yyvsp[0])))){ is_var=1; break;}
  ++pstats;
 }
 string dollar2((yyvsp[0]));
 if(!is_var)
 {
  //Force this to ucase since it's an MPASM literal
  transform(dollar2.begin(), dollar2.end(), dollar2.begin(), makempasmid); 
 }
 //Assgt.; In both cases, must build RHS
 emit_inclusion(("assign"),(".inc"),dollar2.c_str(),dollar2.c_str(),os1);
 char * buffer=(char*)malloc(strlen(os1.str().c_str())+1);//Oops! leaks... TODO!
 sprintf(buffer,os1.str().c_str()); 
 (yyval)=buffer; 
}
#line 1639 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 35:
#line 308 "frost.ypp" /* yacc.c:1646  */
    {
 ostringstream os1;
 //TODO repeated
 if(c.in_function.length()) c.memzone=c.in_function; 
 else c.memzone=(c.in_isr)?"ISR":"hlluserprog"; //Allows proper paging for "far" return
 string dollar1((yyvsp[0]));
 transform(dollar1.begin(), dollar1.end(), dollar1.begin(), makempasmid);    
 emit_inclusion(("movelit"),(".inc"),dollar1.c_str(),dollar1.c_str(),os1);  
 if(c.checks)
 emit_inclusion(("inwsp"),(".inc"),c.memzone,c.memzone,os1);
 else
 os1<<"\n PUSH \n";
 char * buffer=(char*)malloc(strlen(os1.str().c_str())+1);//Oops! leaks... TODO!
 sprintf(buffer,os1.str().c_str()); 
 (yyval)=buffer; 
}
#line 1660 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 36:
#line 326 "frost.ypp" /* yacc.c:1646  */
    {   
 ostringstream os1;
 os1<<(yyvsp[-5]);  //Emit condition to be tested
 free((yyvsp[-5]));
 int baselabel=c.labels;
 c.labels+=2;  
 emit_inclusion(("if1"),(".inc"),baselabel,baselabel,os1); //the test... goto 0
 os1<<(yyvsp[-3]); //Emit "true" actions
 free((yyvsp[-3]));
 emit_inclusion(("jump1"),(".inc"),baselabel+1,baselabel+1,os1);   //goto 1
 emit_inclusion(("label1"),(".inc"),baselabel,baselabel,os1); //0
 os1<<(yyvsp[-1]); //Emit "false" actions
 free((yyvsp[-1]));
 emit_inclusion(("label2"),(".inc"),baselabel+1,baselabel+1,os1); //1    
 char * buffer=(char*)malloc(strlen(os1.str().c_str())+1);//Oops! leaks... TODO!
 sprintf(buffer,os1.str().c_str()); 
 (yyval)=buffer; 
}
#line 1683 "frost.tab.cpp" /* yacc.c:1646  */
    break;

  case 37:
#line 346 "frost.ypp" /* yacc.c:1646  */
    {
 ostringstream os1;  
 os1<<(yyvsp[-1]); //All of the parameters
 free((yyvsp[-1]));
 if(c.in_function.length()) c.memzone=c.in_function; 
 else c.memzone=(c.in_isr)?"ISR":"hlluserprog"; //Allows proper paging for "far" return
 transform(c.memzone.begin(), c.memzone.end(), c.memzone.begin(), makefunctionname);   
 bool tr;//Pre-selection for potential tail recursion...
 string dollars2((yyvsp[-3]));
 transform(dollars2.begin(), dollars2.end(), dollars2.begin(), makefunctionname);   
 //Some aspects of the tail recursion check are done here. Others - in 
 // particular those that relate to whether or not any code is present 
 // after the recursive call in question - are deferred until a 
 // postprocessing step.
 tr=(!(c.in_function.compare(dollars2)));
 tr&=(!(c.in_isr))&& // Not possible from ISR (must return, clean up)
 c.in_function.length();   //fs.c.funcs w/ neither numbers nor a star (can't use "parm")
 tr&=(c.nofparms==NULL_ARGS); tr&=(c.nofrets==NULL_ARGS);//Need to run cleanup routines? 
 if(tr)
 {
//  cout<<"TAIL RECURSION FOUND for "<<dollars2<<" STAR="<<c.star<<endl;
  if(c.star) os1<<"\n ;~IFTR~KDISCARD \n"; //TODO refactor - string constant?
  else os1<<"\n ;~IFTR~ \n";
 }
 //Here is the actual function invocation, after the parameters and preliminaries
 emit_inclusion("invoke",".inc",c.memzone,dollars2,os1); 
 //Tables, necessarily, use a different calling convention. Since tables consist
 // purely of RETLW calls into which an indexed jump is made,the return value
 // arrives in W, not atop the stack, and must be placed atop the stack.
 if(istable(dollars2,c.text))    
 { 
  if(c.checks)
  {
   emit_inclusion(("invsp"),(".inc"),c.memzone,c.memzone,os1);
  }
  else
  {
   os1<<"\n PUSH \n";
  }
 }
 //TODO WHY NOT?? 
 char * buffer=(char*)malloc(os1.str().length()+1);//Oops! leaks... TODO!
 sprintf(buffer,os1.str().c_str()); 
 (yyval)=buffer; 
 //Some bookkeeping follows
 if(c.in_function.length())
 {
  (c.ds_to_calls[c.in_function]).insert(c.ds_to_calls[c.in_function].end(),dollars2);
 }
 if(!(c.in_isr))
 {
  if(!(c.in_function.length()))
  {
   if(c.thunks[dollars2].length())
   c.maincalls.insert(c.maincalls.end(),c.thunks[dollars2]); //bottom-level HLOE call
   else
   c.maincalls.insert(c.maincalls.end(),dollars2); //call into "d" function
  }
 }else{
  if(c.thunks[dollars2].length())
  c.eventcalls.insert(c.eventcalls.end(),c.thunks[dollars2]); //bottom-level HLOE call
  else
  c.eventcalls.insert(c.eventcalls.end(),dollars2); //call into "d" function
 }
}
#line 1753 "frost.tab.cpp" /* yacc.c:1646  */
    break;


#line 1757 "frost.tab.cpp" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 411 "frost.ypp" /* yacc.c:1906  */
  
int main(const int argc, const char *argv[]) 
{
 cout<<"WORKING...\n";
 //TODO should these not all be in c? OR can things from "c" be here?
 static map<string,string> macromap;
 static map<string,vector<string> > ds_to_thunks; 
 static string argproc(""),argboard("");//Set at command line or in source; source wins
 static vector<string> libs,macroorder; 
 static set<string> guards;
 static string usercode2; //Handy for string manipulation
 clock_t dcloc,ccloc; //For performance profiling   
 c.in_function=""; 
 c.checks=true; //Check stack bounds by default
 c.canonize=false; //Don't canonize spacing in TARGET.ASM by default
 for(int garg=1; garg<argc; ++garg)
 {
  if(!(string(argv[garg]).compare(("file")))) 
  c.buffer=read_file(string(argv[garg+1]));
  if(!(string(argv[garg]).compare(("board")))) argboard=string(argv[garg+1]);
  if(!(string(argv[garg]).compare(("proc")))) argproc=string(argv[garg+1]);
  if(!(string(argv[garg]).compare(("nobounds")))) c.checks=0;
  if(!(string(argv[garg]).compare(("canonize")))) c.canonize=1;
 }
 if(!c.buffer.length()) c.buffer=string(argv[argc-1]); //Code must be last arg if on cmd.
 if(argboard.length()) set_header_value(("board is"),argboard);
 if(argproc.length()) set_header_value(("proc is"),argproc);
 string ausercopy(c.buffer); //Process file insertions present in insertions 
 remove_comments(c.buffer,"/");
 //BAUD frost macro library is automatic
 static string bbuf=c.buffer;
 c.buffer=read_file(get_module_name("baud",".frost",0,1));  
 c.buffer.append(" "); c.buffer.append(bbuf);
 //FREELIB frost macro library is automatic(FREELIB and BAUD are independently versioned)
 static string bbuf2=c.buffer;
 c.buffer=read_file(get_module_name("freelib",".frost",0,1));  
 c.buffer.append(" "); c.buffer.append(bbuf2);
 while( c.buffer.find("insert")>=0 && c.buffer.find("insert")<c.buffer.length() )
 { 
  usercode2=c.buffer.substr(0,c.buffer.find("insert"));
  c.buffer=c.buffer.substr(c.buffer.find("insert"));
  c.buffer=c.buffer.substr(string("insert").length()); //eat "insert"
  whitespace(c.buffer);
  string to_inc_file;
  istringstream iiter(c.buffer);
  iiter>>to_inc_file;
  ifstream seeifexists(get_module_name(to_inc_file,".frost",0,0).c_str());
  string insertion;
  if(seeifexists.fail())
  {
   //Search system folder instead. Allows for reusable .frost code (other than
   //  "freelib" and "baud"
   insertion=read_file(get_module_name(to_inc_file,".frost",0,1));
  }else{
   insertion=read_file(get_module_name(to_inc_file,".frost",0,0));  
  }
  remove_comments(insertion,"/"); 
  if(is_definition(insertion))
  {
   //Force to end... means that frost programmer can group all frost library-related
   // "insert" directives at the top of the .frost file.
   usercode2.append(c.buffer.substr(to_inc_file.length()));
   usercode2.append("\n");     
   usercode2.append(insertion);     
  }else{  
   //Insert in place
   usercode2.append(insertion);
   usercode2.append(c.buffer.substr(to_inc_file.length()));   
  }
  c.buffer=usercode2;
 } 
 compile_time_language(c.buffer,c.funcs,macromap,macroorder,c.statics);
 int reserve1,reserve2;
 if(get_header_value("stack is").length())
 {
  istringstream iiter(get_header_value("stack is"));
  iiter>>reserve1;
 }
 else reserve1=80; //The optimal val for 16f690 and others
 if(get_header_value("altstack is").length())
 {
  istringstream iiter(get_header_value("altstack is"));
  iiter>>reserve2;
 }
 else reserve2=20; //The optimal val for 16f690 and others
 emit_inclusion(("hllinclude"),(".inc"),"","",target_s);
 target_s<<endl;
 insert_file(get_module_name(("config"),(".inc"),0,1),target_s);
 target_s<<endl;
 set<string>::iterator pstats=c.statics.begin();   
 while(pstats!=c.statics.end())                
 {
  emit_inclusion(("static"),(".inc"),pstats->c_str(),pstats->c_str(),target_s);
  ++pstats;  
 } 
 insert_file(get_module_name(("prefix"),(".inc"),0,1),target_s);
 whitespace(c.buffer);
 remove_comments(c.buffer,"/"); //Don't want to invoke macro names in comments
 ccloc=clock();
 expand_macros(c.buffer,macromap,macroorder,0); 
 dcloc=clock();
 cout<<"\nEXPANDED in "<<((float)(dcloc-ccloc))<<"ticks...";
 remove_comments(c.buffer,"/"); //Get rid of any comments introduced by macros
 ccloc=clock();
 canonizeintegers(c.buffer);//Allow things like .add[-1.parm[0]] (it adds space)
 dcloc=clock();
 cout<<"\nINTEGRATED in "<<((float)(dcloc-ccloc))<<" ticks...";
 c.text=c.buffer; 
 ofstream tout("o.tmp");
 tout<<c.buffer;
 tout.close();
 FILE * cotmp=fopen("o.tmp","r");
 yyset_in(cotmp);
 ccloc=clock();
 yyparse();
 dcloc=clock();
 cout<<"\nPARSED in "<<((float)(dcloc-ccloc))<<" ticks...\n";
 list_bottom_level_calls(c);
 libs=find_libs(c.funcs,c.checks); //Will be repeated later w/ smaller c.funcs list
 vector<string>::iterator plibs;
 ccloc=clock();
 compile_hloe(libs,c.thunks);
 dcloc=clock();
 cout<<"COMPILED in "<<((float)(dcloc-ccloc))<<" ticks...\n";
 list_function_thunks(c,ds_to_thunks);
 libs=find_libs(c.funcs,c.checks);
 build("target",make_file_s); //Output build script
 emit_inclusion(("make"),(".inc"),getenv("FROST"),
 get_header_value("proc is"),make_file_s);
 link(("target"),make_file_s);
 make_file_s<<" /o\"hloe.hex\" /M\"hloe.map\" /W\n";
 target_s.close();
 target_s.open("target.asm");
 insert_file("target.tmp",target_s); //Must end w/ newline if desired by maker of INC file!
 //TRANSLATE remaining D-CALLS in c.maincalls and c.eventcalls into THUNK-LEVEL LISTINGS
 list_task_thunks(c,ds_to_thunks);
 guards.insert("hllblss"); //Always guard the kernel; other libs can assume it.
 set<string>::iterator ssiter_out=c.eventcalls.begin(); //Make a GUARD wherever c.maincalls and
 while(ssiter_out!=c.eventcalls.end())                     //  c.eventcalls contain same thing.
 {
  if(!(ssiter_out->compare(""))) {++ssiter_out; continue;}
  set<string>::iterator ssiter=c.maincalls.begin(); 
  while(ssiter!=c.maincalls.end())
  {
   if(!(ssiter_out->compare(*ssiter++))) guards.insert(*ssiter_out);
  } 
  ++ssiter_out;
 }
 std::for_each(guards.begin(), guards.end(), guard); 
 emit_inclusion("defstack",".inc",reserve1,reserve2,inc_file_s);
 emit_inclusion("baselibs",".inc",get_header_value("proc is"),
 get_module_name(("kernel"),(".inc"),0,1).
 substr(0,get_module_name(("kernel"),(".inc"),0,1).length()-4),inc_file_s);
 if(c.multitask) 
 emit_inclusion("deftask",".inc","","",inc_file_s);
 emit_inclusion(("progendc"),(".inc"),"","",target_s);
 make_file_s.close();
 inc_file_s.close();
 //Add libraries to bottom of target.asm, for faster build
 plibs=libs.begin(); 
 while(plibs!=libs.end())                
 {
  insert_file((string(getenv("FROST"))+(*plibs++)+".asm").c_str(),target_s);
 }
 target_s<<endl<<" end"<<endl;
 target_s.close();
 ccloc=clock();
 //Post-processing step... get rid of any PUSH POP pairs
 pushpopoptimize();
 farcalloptimize();
 dcloc=clock();
 cout<<"OPTIMIZED in "<<((float)(dcloc-ccloc))<<" ticks...\n";
 ccloc=clock();
 tailrecursion();
 dcloc=clock();
 cout<<"RECURSED in "<<((float)(dcloc-ccloc))<<" ticks...\n";
 if(c.canonize)
 {
  ccloc=clock();
  //Post-processing step... standardize use of whitespace in target.asm
  canonicalspacing(); 
  dcloc=clock();
  cout<<"CANONIZED in "<<((float)(dcloc-ccloc))<<" ticks...\n";
 }
 system("chmod a+x ./make.bat");
 system("./make.bat");
} 
