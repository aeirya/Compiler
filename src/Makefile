# NOTE1: You can use wildcards in dependencies and g++ command.
# NOTE2: main should depend on all headers and code files. (*.h and *.cpp if you have multiple files)
all: ../parser ../lexer

../parser: parser.tab.c lex.yy.c lex.yy.h main.cc
	g++ -o ../parser -std=c++14 parser.tab.c lex.yy.c main.cc

# ../lexer: lex.yy.c lex.yy.h Lexer.cpp
# 	g++ -o ../lexer -std=c++14 lex.yy.c Lexer.cpp

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c lex.yy.h: scanner.l
	flex scanner.l
	cp lex.yy.c lex.yy.h

clean:
	rm ../lexer ../parser lex.yy.c lex.yy.h parser.tab.c parser.tab.h
