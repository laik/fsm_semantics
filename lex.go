// Copyright 2020 <laik.lj@me.com>. All rights reserved.
// Use of this source code is governed by a Apache
// license that can be found in the LICENSE file.

package main

//#include "token.h"
//#include "fss.lex.h"
import "C"

import (
	"errors"
	"fmt"
	"log"
)

var _ fssLexer = (*fssLex)(nil)

type fssLex struct {
	yylineno int
	yytext   string
	lastErr  error
}

func NewFssLexer(data []byte) *fssLex {
	p := new(fssLex)
	C.yy_scan_bytes(
		(*C.char)(C.CBytes(data)),
		C.yy_size_t(len(data)),
	)
	return p
}

// The parser calls this method to get each new token. This
// implementation returns operators and NUM.
func (p *fssLex) Lex(yylval *fssSymType) int {
	p.lastErr = nil

	var ntoken = C.yylex()

	p.yylineno = int(C.yylineno)
	p.yytext = C.GoString(C.yytext)

	//var lastStep string
	//var lastAction string

	switch ntoken {
	//case C.IDENTIFIER: //IDENTIFIER = 100,
	//case C.NUMBER: //NUMBER = 101,
	//	//yylval.Value, _ = strconv.Atoi(p.yytext)
	//	//return NUMBER
	//case C.FLOW: //FLOW = 160, // FLOW $name
	//	yylval.Flow = p.yytext
	//	return FLOW
	//case C.FLOW_END: //FLOW_END = 162,	// END
	//	yylval.IsEnd = true
	//	return FLOW_END
	//case C.STEP:
	//	yylval.Steps = append(yylval.Steps, p.yytext)
	//	lastStep = p.yytext
	//	return STEP
	//case C.DECI:
	//	yylval.Steps = append(yylval.Steps, p.yytext)
	//	lastStep = p.yytext
	//	return STEP
	//case C.ACTION:
	//	if yylval.Actions == nil {
	//		yylval.Actions = make(map[string]interface{})
	//	}
	//	if yylval.Actions[p.yytext] == nil {
	//		yylval.Actions[p.yytext] = make(map[string]interface{})
	//	}
	//	lastAction = p.yytext
	//	return ACTION
	//case C.ARGS:
	//	yylval.Actions[lastAction] = nil //? list to slice [] , dict to map
	//	return ACTION

	case C.ILLEGAL:
		yylval.err = errors.New(fmt.Sprintf("lex: ILLEGAL token, yytext = %q, yylineno = %d", p.yytext, p.yylineno))
		return ILLEGAL

		//LIST = 103,
		//VARIABLE = 104,
		//RETURN = 105,
		//TEXT = 106,

		//DECI = 163, // DECI $node
		//STEP = 164, // STEP $node
		//ACTION = 165,
		//ARGS = 166,
		//
		//LPAREN = 301,	 // (
		//RPAREN = 302,	 // )
		//LSQUARE = 303,	 // [
		//RSQUARE = 304,	 // ]
		//LCURLY = 305,	 // {
		//RCURLY = 306,	 // }
		//ASSIGN = 307,	 // =
		//SEMICOLON = 308, // ;
		//OR = 309,		 // |
		//AND = 310,		 // &
		//TO = 311,		 // =>
		//COMMA = 312,	 // ,
		//COLON = 313,	 // :
		//DEST = 314,		 // ->
	}

	//_, _ = lastStep, lastAction

	return 0 // eof
}

// The parser calls this method on a parse error.
func (p *fssLex) Error(s string) {
	p.lastErr = errors.New("yacc: " + s)
	if err := p.lastErr; err != nil {
		log.Println(err)
	}
}
