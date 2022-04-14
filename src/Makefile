# NOTE1: You can use wildcards in dependencies and g++ command.
# NOTE2: main should depend on all headers and code files. (*.h and *.cpp if you have multiple files)
all: ../lexer

../lexer: lex.yy.c lex.yy.h Lexer.cpp
	g++ -o ../lexer -std=c++14 lex.yy.c Lexer.cpp

lex.yy.c lex.yy.h: scanner.l
	flex scanner.l

clean:
	rm ../lexer lex.yy.c lex.yy.h
