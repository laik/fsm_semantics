package main

import (
	"bufio"
	"io/ioutil"
	"os"
)

func main() {
	br := bufio.NewReader(os.Stdin)
	content, err := ioutil.ReadAll(br)
	if err != nil {
		panic(err)
	}
	// flex + goyacc
	Parse(NewFssLexer(content))
}
