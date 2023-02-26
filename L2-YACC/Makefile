compile:
	@lex lex.l
	@yacc -d parse.y -Wno
	@gcc -g y.tab.c lex.yy.c -ll
	@rm lex.yy.c y.tab.c y.tab.h
	@./a.out<test.c>out.txt

generate:
	@lex lex.l
	@yacc -d parse.y -Wno
	@gcc -g y.tab.c lex.yy.c -ll

FPATH = test.c
run:
	@./a.out<$(FPATH)>out.txt
	@cat out.txt

CPATH = test.c
EPATH = testerr.c
test:
		@./a.out<$(CPATH)>test_out.txt
		@./a.out<$(EPATH)>testerr_out.txt

clean:
	@rm lex.yy.c y.tab.c y.tab.h a.out test_out.txt testerr_out.txt
