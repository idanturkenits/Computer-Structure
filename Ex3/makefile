a.out: main.o run_main.o func_select.o pstring.o
	gcc -g -o a.out main.o run_main.o func_select.o pstring.o

main.o: main.c pstring.h
	gcc -g -c -o main.o main.c

run_main.o: run_main-test.c pstring.h
	gcc -g -c -o run_main.o run_main-test.c
	
func_select.o: func_select.s pstring.h
	gcc -g -c -o func_select.o func_select.s -no-pie

pstring.o: pstring.s
	gcc -g -c -o pstring.o pstring.s -no-pie

clean:
	rm -f *.o a.out
