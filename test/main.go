package main

import (
	"bufio"
	"io/ioutil"
	"os"

	fss "github.com/laik/fsm_semantics"
)

func main() {
	br := bufio.NewReader(os.Stdin)
	content, err := ioutil.ReadAll(br)
	if err != nil {
		panic(err)
	}
	// flex + goyacc
	fss.Parse(fss.NewFssLexer(content))
}
