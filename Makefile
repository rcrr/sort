#
#  Makefile
#
#  This file is part of the sort program
#  http://github.com/rcrr/sort
#
#  Copyright (c) 2015 Roberto Corradini. All rights reserved.
#
#  This program is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; either version 3, or (at your option) any
#  later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA
#  or visit the site <http://www.gnu.org/licenses/>.
#



all: sort_test sort.pdf

sort.c sort_test.c: sort.w Makefile
	ctangle sort

sort.o: sort.c
	gcc -std=c99 -pedantic-errors -Wall -g -O3 -c sort.c -o sort.o

sort_test.o: sort_test.c
	gcc -std=c99 -pedantic-errors -Wall -g -O3 -c sort_test.c -o sort_test.o

sort_test: sort_test.o sort.o
	gcc sort_test.o sort.o -o sort_test

sort.tex: sort.w Makefile
	cweave sort

sort.pdf: sort.tex
	pdftex sort

clean:
	rm -f sort.c sort_test.c sort.h sort.o sort_test.o sort_test sort.tex sort.pdf sort.idx sort.toc sort.log sort.scn
