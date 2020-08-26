/* Copyright 2020 laik.lj@me.com. All rights reserved. */
/* Use of this source code is governed by a Apache */
/* license that can be found in the LICENSE file. */

/* simplest version of calculator */

%{
package main

//import "github.com/laik/echoer/pkg/fsm"
//import "github.com/laik/echoer/pkg/resource"


var (
    print = __yyfmt__.Print
    printf = __yyfmt__.Printf
)
%}

%union {
  Flow string `json:"flow_name"`
  Steps []string `json:"steps"`
  Actions map[string]interface{} `json:"actions"` // action["step_name"]map["action_name"]interfaec{} args==list/map
  IsEnd bool `json:"is_end"`
  err error
}

%start ROOT
%token ILLEGAL
%token EOL
%token IDENTIFIER
%token NUMBER
%token ID
%token LIST
%token VARIABLE
%token TEXT
%token FLOW
%token FLOW_END
%token STEP
%token ACTION
%token ARGS
%token LPAREN
%token RPAREN
%token LSQUARE
%token RSQUARE
%token LCURLY
%token RCURLY
%token ASSIGN
%token SEMICOLON
%token OR
%token AND
%token TO
%token COMMA
%token COLON
%token DEST
%token DECI
%token DICT

%%
ROOT : ROOT flow_expr    { print($2); }
     |  /* empty */ {/* empty */}
     ;

flow_expr
     : FLOW TEXT step_expr FLOW_END { $$ = $2; }
     ;

step_expr
     : STEP TEXT action_expr TO return_expr SEMICOLON // step A $action_expr => $return_expr ;
      {
	 printf("step name = %s\n",$2);
      }
     | DECI TEXT action_expr TO return_expr SEMICOLON // deci A $action_expr => $return_expr ;
     {
	printf("deci name = %s\n",$2);
     }
     ;

action_expr
     : ACTION ASSIGN TEXT COMMA ARGS ASSIGN LIST
      {
         printf("action = %s args = \n",$2,$7);
      }
     | ACTION ASSIGN TEXT COMMA ARGS ASSIGN DICT
     {
     	printf("action = %s args = \n",$2,$7);
     }
     ;

return_expr
     : LPAREN return_content_expr RPAREN
     {
     	printf(" return_content_expr = %s", $2);
     }
     ;

return_content_expr
     : TEXT DEST LIST
     {
     	printf(" state = %s dest %v ", $1, $3);
     }
     | TEXT DEST TEXT
     {
	printf(" state = %s dest %v ", $1, $3);
     }
     | OR return_content_expr { $$ = $2; }
     ;

%%
