

all: sort sort.pdf

sort.c: sort.w
	ctangle sort

sort.o: sort.c
	gcc -std=c99 -pedantic-errors -Wall -g -O3 -c sort.c -o sort.o

sort: sort.o
	gcc sort.o -o sort

sort.tex: sort.w
	cweave sort

sort.pdf: sort.tex
	pdftex sort

clean:
	rm -f sort.c sort.o sort sort.tex sort.pdf sort.idx sort.toc sort.log sort.scn
