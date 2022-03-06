all:../../pre.out

../../pre.out: lex.yy.c preprocess.l
	g++ -o ../../pre.out -std=c++14 lex.yy.c
	rm lex.yy.c

lex.yy.c: preprocess.l
	flex preprocess.l

clean:
	rm ../../pre.out lex.yy.c
