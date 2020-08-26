/* Copyright 2020 laik.lj@me.com. All rights reserved. */
/* Use of this source code is governed by a Apache */
/* license that can be found in the LICENSE file. */

enum
{
	ILLEGAL = 10000,
	EOL = 10001,

	IDENTIFIER = 100,
	NUMBER = 101,
	ID = 102,
	LIST = 103,
	VARIABLE = 104,
	TEXT = 106,
	DICT = 107,

	FLOW = 160, // FLOW $name
	FLOW_END = 162,	// END
	DECI = 163, // DECI $node
	STEP = 164, // STEP $node
	ACTION = 165,
	ARGS = 166,

	LPAREN = 301,	 // (
	RPAREN = 302,	 // )
	LSQUARE = 303,	 // [
	RSQUARE = 304,	 // ]
	LCURLY = 305,	 // {
	RCURLY = 306,	 // }
	ASSIGN = 307,	 // =
	SEMICOLON = 308, // ;
	OR = 309,		 // |
	AND = 310,		 // &
	TO = 311,		 // =>
	COMMA = 312,	 // ,
	COLON = 313,	 // :
	DEST = 314,		 // ->
};