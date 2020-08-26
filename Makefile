CC = gcc
OUT = tcc
OBJ = fss.yy.o token.o
SCANNER = fss.l
PARSER = fss.y

default_lex:
	#lex -c --header-file=fss.lex.h -o fss.lex.c fss.l
	flex --prefix=yy --header-file=fss.lex.h -o fss.lex.c fss.l

go: default_lex
	goyacc -o fss.y.go -p "fss" fss.y

test_lex: default_lex
	gcc scanner.c fss.lex.c -o scanner && ./scanner < example/upper_example.fss && ./scanner < example/lower_example.fss && rm -f scanner

go_test: go_clean go
	go run *.go < example/lower_example.fss

go_clean:
	rm -f fss.y.go fss.lex.h fss.lex.c

build: yacc $(OUT)

run: $(OUT)
	./$(OUT) < example/lower_example.fss > test.asm

clean:
	rm -f *.o fss.yy.c fss.yy.c y.output $(OUT)

$(OUT): $(OBJ)
	$(CC) -o $(OUT) $(OBJ)

fss.yy.c: $(SCANNER) fss.yy.c
	flex $<

fss.yy.c: $(PARSER)
	bison -vdty $<