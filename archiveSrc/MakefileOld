# NOTE1: You can use wildcards in dependencies and g++ command.
# NOTE2: main should depend on all headers and code files. (*.h and *.cpp if you have multiple files)
all: ../parser

../parser: parser.tab.c lex.yy.c main.cc
	g++ -o ../parser -std=c++14 parser.tab.c lex.yy.c main.cc

parser.tab.c parser.tab.h: parser.y
	bison -d -t -v parser.y

lex.yy.c: scanner.l
	flex scanner.l

clean:
	rm ../parser lex.yy.c parser.tab.c parser.tab.h parser.output
