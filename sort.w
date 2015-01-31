%
% A library of sorting routines written in ANSI C99.
% This work has been prepared using the CWEB system.
%
% sort.w
%
% This file is part of the sort program
% http://github.com/rcrr/sort
%
% Author Roberto Corradini mailto:rob_corradini@@yahoo.it
% Copyright 2015 Roberto Corradini. All rights reserved.
%
% This document is at the same time the source code for the program and
% the typeset manual. It is designed conforming to the CWEB system, by Donald Knuth
% and Silvio Levy, see the web page at http://www.literateprogramming.com/cweb_download.html.
% for further details.
% It has to be processed using CWEAVE and CTANGLE programs, that are part of CWEB.
% With the help of these two utilities, both the program and the manual are generated.
% It is the intent of the author to license the software under the terms of the
% GNU GPLv3, and the manual under the terms of GNU Free Documentation License
% Version 1.3.
%
% Software license
%
% This program is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by the
% Free Software Foundation; either version 3, or (at your option) any
% later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
%
% Manual license
%
% Permission is granted to copy, distribute and/or modify this document
% under the terms of the GNU Free Documentation License, Version 1.3
% or any later version published by the Free Software Foundation;
% with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
% A copy of the license is included in the section entitled "GNU
% Free Documentation License".
%

%
% Assignment operartor.
%
\let\K=\leftarrow

%
% This is the eplain file after removing ifpdf section.
%
\input eplain-cweb

%
% Defines A4 papersize.
%
\pdfpagewidth=210 true mm
\pdfpageheight=297 true mm

\font\authorfont=cmr12

\def\title{SORT: a library for sorting}
\def\topofcontents{\null\vfill
  \titletrue
  \centerline{\titlefont {\ttitlefont SORT} a library for sorting}
  \vskip 15pt
  \centerline{(Version 0.10)}
  \vfill}

\titletrue
\centerline{\titlefont {\ttitlefont SORT}: a library for sorting}
\vskip 18pt\centerline{(Version 0.10 --- January 2015)}
\vskip 24pt
\centerline{\authorfont Roberto Corradini}
\vfill

\noindent
\TeX\ is a trademark of the American Mathematical Society.

\bigskip\noindent
The printed and electronic form of this manual is copyright \copyright\ 2015
by Roberto Corradini. All rights reserved.

\smallskip\noindent
This software is copyright \copyright\ 2015
by Roberto Corradini. All rights reserved.

\bigskip\noindent
Internet page \pdfURL{http://github.com/rcrr/sort}{http://github.com/rcrr/sort}
contains current info about \.{SORT} and related topics.

\smallskip\noindent
The author may be contacted by email as \pdfURL{rob\_corradini@@yahoo.it}{mailto:rob_corradini@@yahoo.it}

\bigskip\noindent
This printed document is the typeset manual generated from a set of \.{CWEB} source files.
The source files are first processed with the \.{cweave} program, and the resulting
\TeX\ files are then typset into this manual.
The same \.{CWEB} source files are also processed by \.{ctangle}, which prepares the \CEE/
program.
It is the intent of the author to license the software under the terms of the
GNU GPLv3, and the manual under the terms of GNU Free Documentation License
Version 1.3.

\bigskip\noindent
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled ``GNU
Free Documentation License''.

\bigskip\noindent
This program is free software; you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation; either
version 3 of the License, or (at your option) any later version.
\smallskip\noindent
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
\smallskip\noindent
See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this program;
if not, write to:
\smallskip \settabs18\columns
\+&Free Software Foundation, Inc.\cr
\+&59 Temple Place - Suite 330\cr
\+&Boston, MA 02111-1307\cr
\+&UNITED STATES\cr
\smallskip\noindent
or visit the GNU site at \pdfURL{http://www.gnu.org/licenses/}{http://www.gnu.org/licenses/}

\def\contentspagenumber{-1} \pageno=\contentspagenumber \advance\pageno by 1

@s int64_t int
@s uint64_t int


@* Introduction.

The purpose of \.{SORT} is to provide a pool of algorithms for sorting.
The functions made available by this program are all in-memory algorithms,
this means that the data is never unloaded from the computer's random access
memory. This practice is generally referred as ``{\sl internal sorting\/}''.

A lot of effort has been devoted to study and research sorting procedures,
but a silver bullet has still to come.
Depending on the sorting data distribution, the patterns in the data,
the type and number of the records, the cost of comparing versus swapping,
the availability of extra space, and finally our tolerance to the risk
of unbound running time and memory consumption that might be caused by
unpredicted data distributions,
one choice can be more suitable than the others.

The algorithms here proposed are all based on ``{\sl element comparison}'':
{\sl \unorderedlist \leftskip=14mm
  \li Insertion-sort
  \li Binary-sort
  \li Heap-sort
  \li Smooth-sort
  \li Quick-sort
  \li Shell-sort
  \li Merge-sort
  \li Tim-sort
\endunorderedlist}

Depending on how the data to be sorted is organized we have to design the |swap|
and the |compare| functions. Here we make a simple assunption: The data element is
identified by a memory pointer, and the size of the element is constant.
At a first glance this may be perceived as a too strong constraint, but it isn't.

There are mainly three different approaches when we have to rearrange
records of information in a given order:
{\unorderedlist \leftskip=14mm
  \li Address table sorting that means moving the complete records around.
  \li Key-sorting that is carried out by preparing an auxiliary array of references and sort them.
  \li List sorting that is done organizing auxiliary references into a linked list.
\endunorderedlist}

Here we are leaving out the third one, embracing the second one,
and limiting the first to the special case of constant element's size.
Lists do not provide random access, that is mandatory for the
enumerated algorithms, and so are out of scope for this library.
Address table sorting is really appealing when there is no distinction
between the data that we want to sort and the key used for comparison.
A straightforward example is sorting raw data types like integers
or doubles.
Key-sorting on the other side moves around just a fixed length reference,
usually a computer memory pointer, and uses the data record, also known
as object, only for comparison. 



@* Function definitions and prototypes.

The standard \CEE/ library defines the |qsort| function as

|void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));|

This definition introduce also a second function definition, |compar|, as

|int (*compar)(const void *, const void *);|

This couple of functions are the core of the abstraction that we are adopting in order to
build the \.{SORT} library.

We start preparing the library header file by wrapping it with the standard
include guards that prevents the body of \.{sort.h} from being read more than once
in a given compilation.
Next we define two polimorphic function types, one for comparing and the other for sorting.
Finally we add all the function prototypes provided by the specific compare
function and the sort algorithms.
The header file \.{stdint.h} is included because some specific sorting functions
are dedicated to raw types defined by it.
Users of the \.{SORT} library should include the header file \.{sort.h}.

\bigskip\noindent
The function pointer |sort_utils_compare_function| has two parameters:

\begingroup
\def\]#1 {\smallskip\hangindent2\parindent \hangafter1 \indent #1 }

\]|a| a pointer to an element.

\]|b| a pointer to a second element.

\endgroup\smallskip\noindent

\bigskip\noindent
The function pointer |sort_utils_sort_function| has four parameters:

\begingroup
\def\]#1 {\smallskip\hangindent2\parindent \hangafter1 \indent #1 }

\]|a| a pointer to the first element of the array to be sorted.

\]|count| the number of elements in the |a| array.

\]|element_size| the number of bytes occupied by each element.

\]|cmp| a pointer to the compare function.

\endgroup\smallskip\noindent


@(sort.h@>=

@#
#ifndef SORT_UTILS_H
#define SORT_UTILS_H

@#
#include <stdint.h>

@#
typedef int
@[@] (*sort_utils_compare_function)
(
   const void *const a,
   const void *const b
);

@#
typedef void
@[@] (*sort_utils_sort_function)
(
   void *const a,
   const size_t count,
   const size_t element_size,
   const sort_utils_compare_function cmp
);

@#
@<Function prototypes for comparing@>


@#
#endif /* |SORT_UTILS_H| */



@* Compare functions.

The most common raw types like |double|, |int|, |int64_t|, and |uint64_t|, are
provided with prepared---ready to use---compare functions. This choice has been done
for the convenience of the user, for testing the algorithms, and also because
the \CEE/ compiler can make a better job in inlining the function
when it is in the same compilation unit of its client, the sorting algorithm.

@<Collection of compare functions@>=
@<Compare functions for |double| raw type@>@/
@<Compare functions for |int| raw type@>@/
@<Compare functions for 64 bits integer types@>



@ Compare function for |double| raw type.

The function |sort_utils_double_cmp| compares |double| values pointed by
|a| and |b|, it returns:
\smallskip
\settabs\+ \hfil 10mm & |+1| & when |a| is greater than |b| \cr
\+ & {\hfill |+1|} & \ when |a| is greater than |b| \cr
\+ & {\hfill  |0|} & \ when |a| is equal to |b| \cr
\+ & {\hfill |-1|} & \ when |a| is less then |b| \cr

Applying this criteria the sorting functions organize the data in ascending order.

@<Compare functions for |double| raw type@>=
int
sort_utils_double_cmp (a, b)
     const void *const a; /* a pointer to the first |double| */
     const void *const b; /* a pointer to the second |double| */
{
  const double *const x = (const double *const) a;
  const double *const y = (const double *const) b;
  return (*x > *y) - (*x < *y);
}

@ The declaration of the prototype for the function |sort_utils_double_cmp| is
added to the \.{sort.h} header file.

@<Function prototypes for comparing@>=
extern int
sort_utils_double_cmp (
 const void *const a,
 const void *const b);



@ Inverse compare function for |double| row type.

On the contrary---when a descending order is requested---the function
|sort_utils_double_icmp| compares |double|
values pointed by |a| and |b| in an opposite way, it returns:
\smallskip
\settabs\+ \hfil 10mm & |+1| & when |a| is greater than |b| \cr
\+ & {\hfill |-1|} & \ when |a| is greater than |b| \cr
\+ & {\hfill  |0|} & \ when |a| is equal to |b| \cr
\+ & {\hfill |+1|} & \ when |a| is less then |b| \cr

@<Compare functions for |double| raw type@>+=
int
sort_utils_double_icmp (a, b)
     const void *const a; /* a pointer to the first |double| */
     const void *const b; /* a pointer to the second |double| */
{
  const double *const x = (const double *const) a;
  const double *const y = (const double *const) b;
  return (*x < *y) - (*x > *y);
}

@ The declaration of the prototype for the function |sort_utils_double_icmp| is
then added to the \.{sort.h} header file.

@<Function prototypes for comparing@>=
extern int
sort_utils_double_icmp (
 const void *const a,
 const void *const b);



@ Compare functions for |int| raw type.

As like as we just saw for |double| pairs, we have similar compare functions
also for |int| values. The function |sort_utils_int_cmp| returns one |int| $\in \{ +1, 0, -1 \}$
depending on the relative order of values pointed by parameters |a| and |b|.

@<Compare functions for |int| raw type@>=
int
sort_utils_int_cmp (a, b)
     const void *const a; /* a pointer to the first |int| */
     const void *const b; /* a pointer to the second |int| */
{
  const int *const x = (const int *const) a;
  const int *const y = (const int *const) b;
  return (*x > *y) - (*x < *y);
}

int
sort_utils_int_icmp (a, b)
     const void *const a; /* a pointer to the first |int| */
     const void *const b; /* a pointer to the second |int| */
{
  const int *const x = (const int *const) a;
  const int *const y = (const int *const) b;
  return (*x < *y) - (*x > *y);
}

@ The declaration of the prototype for the functions |sort_utils_int_cmp| and
|sort_utils_int_icmp| are then added to the \.{sort.h} header file.

@<Function prototypes for comparing@>=
extern int
sort_utils_int_cmp (
 const void *const a,
 const void *const b);

extern int
sort_utils_int_icmp (
 const void *const a,
 const void *const b);



@ Compare functions for |int64_t| and |uint64_t| raw types.

Today computer CPU registers can be 64 bits long, so defining compare
functions for these types is in line with our times.

The definition of this four functions is following the same conventions
adopted for the just described ones.

@<Compare functions for 64 bits integer types@>=
int
sort_utils_uint64_t_cmp (a, b)
     const void *const a; /* a pointer to the first |uint64_t| */
     const void *const b; /* a pointer to the second |uint64_t| */
{
  const uint64_t *const x = (const uint64_t *const) a;
  const uint64_t *const y = (const uint64_t *const) b;
  return (*x > *y) - (*x < *y);
}

int
sort_utils_uint64_t_icmp (a, b)
     const void *const a; /* a pointer to the first |uint64_t| */
     const void *const b; /* a pointer to the second |uint64_t| */
{
  const uint64_t *const x = (const uint64_t *const) a;
  const uint64_t *const y = (const uint64_t *const) b;
  return (*x < *y) - (*x > *y);
}

int
sort_utils_int64_t_cmp (a, b)
     const void *const a; /* a pointer to the first |int64_t| */
     const void *const b; /* a pointer to the second |int64_t| */
{
  const int64_t *const x = (const int64_t *const) a;
  const int64_t *const y = (const int64_t *const) b;
  return (*x > *y) - (*x < *y);
}

int
sort_utils_int64_t_icmp (a, b)
     const void *const a; /* a pointer to the first |int64_t| */
     const void *const b; /* a pointer to the second |int64_t| */
{
  const int64_t *const x = (const int64_t *const) a;
  const int64_t *const y = (const int64_t *const) b;
  return (*x < *y) - (*x > *y);
}

@ And as we did for the other compare functions---we add the declaration of the prototype
for them to the \.{sort.h} header file.

@<Function prototypes for comparing@>=
extern int
sort_utils_uint64_t_cmp (
 const void *const a,
 const void *const b);

extern int
sort_utils_uint64_t_icmp (
 const void *const a,
 const void *const b);

extern int
sort_utils_int64_t_cmp (
 const void *const a,
 const void *const b);

extern int
sort_utils_int64_t_icmp (
 const void *const a,
 const void *const b);



@* The program.

This section has to be completely developed.
@c
@<Header files to include@>@/
@<The main program@>


@ We include header files \.{stdio.h} and \.{stdlib.h}.

@<Header files...@>=
#include <stdio.h>
#include <stdlib.h>
#include "sort.h"

@ Now we come to the general layout of the |main| function. 

@<The main...@>=
int
main (argc, argv)
     int argc; /* the number of arguments on the \UNIX/ command line */
     char **argv; /* the arguments themselves, an array of strings */
{
  @<Interactive short notice@>@/
  @<Variables local to |main|@>@/
  prog_name=argv[0];
  status = 0;
  @<Print message @>@/
  exit(status);
}



@ Variables local to main are the return status |status|, and the program name |prog_name|.

@<Variables local to |main|@>=
const char *prog_name; /* Program name */
int status; /* Return status */

@ Prints the program message.

@<Print message@>=

printf("%s: hello sort man.\n", prog_name);



@ Interactive short notice.

@<Interactive short notice@>=

printf("SORT Copyright (C) 2015 Roberto Corradini\n");
printf("This program comes with ABSOLUTELY NO WARRANTY.\n");
printf("This is free software, and you are welcome to redistribute it\n");
printf("under the conditions of the GNU GPL v3 license.\n");
printf("Consult the associated documentation for details.\n");
    
@* Index.
Here is a cross-reference table for \.{SORT}.
All sections in which an identifier is used are listed with that identifier,
except that reserved words are indexed only when they appear in format definitions,
and the appearances of identifiers in section names are not indexed.
Underlined entries correspond to where the identifier was declared.
Error messages and a few other things like ``ASCII code dependencies'' are indexed here too.
