# NOTE1: You can use wildcards in dependencies and g++ command.
# NOTE2: main should depend on all headers and code files. (*.h and *.cpp if you have multiple files)
all: ../Lexer

../Lexer: lex.yy.c lex.yy.h Lexer.cpp
	g++ -o ../Lexer -std=c++14 lex.yy.c Lexer.cpp

lex.yy.c lex.yy.h: scanner.l
	flex scanner.l

clean:
	rm ../Lexer lex.yy.c lex.yy.h
