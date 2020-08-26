/* Copyright 2020 laik.lj@me.com. All rights reserved. */
/* Use of this source code is governed by a Apache */
/* license that can be found in the LICENSE file. */

%option noyywrap
%option caseless

%{
#include "token.h"
int cur_line = 1;
void yyerror(const char *msg);
void unrecognized_char(char c);
%}


%%
"FLOW"                               { return FLOW; }
"FLOW_END"                           { return FLOW_END; }
"DECI"                               { return DECI; }
"STEP"                               { return STEP; }
"ACTION"                             { return ACTION; }
"ARGS"                               { return ARGS; }

"->"   { return DEST; }
"("    { return LPAREN; }
")"    { return RPAREN; }
"["    { return LSQUARE; }
"]"    { return RSQUARE; }
"{"    { return LCURLY; }
"}"    { return RCURLY; }
"=>"   { return TO; }
"="    { return ASSIGN; }
";"    { return SEMICOLON; }
"|"    { return OR; }
"&"    { return AND; }
":"    { return COLON; }
","    { return COMMA; }

[0-9]+                                 { return NUMBER; }
\[.*\]                                 { return LIST; }
\{([a-z_A-Z0-9]*\:[a-z_A-Z0-9]*\,)+*\} {return DICT; }
\$[A-Z]*                               { return VARIABLE; }
\"([^\"]*)\"                           { return TEXT; }
[_a-z_A-Z_][_a-z_A-Z_0-9_]*            { return TEXT; }


\n     { cur_line++; return EOL; }
[ \t]  { /* ignore whitespace */ }
.      { unrecognized_char(yytext[0]); return ILLEGAL; }

%%

void unrecognized_char(char c) {
    char buf[32] = "Unrecognized character: ?";
    buf[24] = c;
    yyerror(buf);
}

void yyerror(const char *msg) {
    printf("Error at line %d:\n\t%s\n", cur_line, msg);
    exit(1);
}