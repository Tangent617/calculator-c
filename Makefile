CFLAGS = -g

all: calculator calculator_self

calculator: calculator_lex.o calculator_yacc.o expr.o main.o
	gcc $(CFLAGS) -o $@ calculator_lex.o calculator_yacc.o expr.o main.o

calculator_self: myflex.o calculator_yacc_self.o expr.o main_self.o
	gcc $(CFLAGS) -o $@ myflex.o calculator_yacc_self.o expr.o main_self.o

myflex.o: myflex.c myflex.h
	gcc -DLEX_SELF $(CFLAGS) -c -o myflex.o myflex.c

expr.o: expr.c expr.h
	gcc $(CFLAGS) -c -o expr.o expr.c

calculator_lex.o: calculator_lex.c calculator_yacc.h
	gcc $(CFLAGS) -c -o calculator_lex.o calculator_lex.c

calculator_lex.c alculator_lex.h: calculator.l
	flex -o calculator_lex.c --header-file=calculator_lex.h calculator.l

calculator_yacc.o: calculator_yacc.c calculator_yacc.h calculator_lex.h
	gcc $(CFLAGS) -c -o calculator_yacc.o calculator_yacc.c

calculator_yacc_self.o: calculator_yacc.c calculator_yacc.h calculator_lex.h
	gcc -DLEX_SELF $(CFLAGS) -c -o calculator_yacc_self.o calculator_yacc.c

calculator_yacc.c calculator_yacc.h: calculator.y
	bison -d -o calculator_yacc.c calculator.y

main.o: main.c calculator_yacc.h calculator_lex.h
	gcc $(CFLAGS) -c -o main.o main.c

main_self.o: main.c calculator_yacc.h myflex.h
	gcc -DLEX_SELF $(CFLAGS) -c -o main_self.o main.c

tmpclean:
	rm -rf *.o

clean:
	rm -rf *.o
	rm -rf *.dSYM
	rm -f calculator_lex.c calculator_lex.h
	rm -f calculator_yacc.c calculator_yacc.h
	rm -f calculator calculator_self

zip:
	tar --exclude *.tar.* -cvf calculator.tar *
	gzip -f calculator.tar
