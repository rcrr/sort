%
% A library of sorting routines written using CWEB by Roberto Corradini
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
% the typeset manual. It is designed conforming to the CWEB system and
% has to be processed using cweave and ctangle programs, part of it.
% With the help of those two both the program and the manual will be generated.
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
Internet page \.{http://github.com/rcrr/sort}
contains current info about \.{SORT} and related topics.

\smallskip\noindent
The author may be contacted by email as \.{rob\_corradini@@yahoo.it}.

\bigskip\noindent
This printed document is the typeset manual generated from a set of \.{CWEB} source files.
The source files are first processed with the \.{cweave} program, and the resulting
\TeX\ files are then typset into this manual.
The same \.{CWEB} source files are also processed by \.{ctangle}, which prepares the \.{C}
program.
It is the intent of the author to license the software under the terms of the
GNU GPLv3, and the manual under the terms of GNU Free Documentation License
Version 1.3.

\bigskip\noindent
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled "GNU
Free Documentation License".

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
or visit the site \.{http://www.gnu.org/licenses/}.

\def\contentspagenumber{-1} \pageno=\contentspagenumber \advance\pageno by 1

@* Introduction.

The purpose of \.{sort} is to provide a pool of algorithm for sorting.

@c
@<Header files to include@>@/
@<The main program@>


@ We include header files \.{stdio.h} and \.{stdlib.h}.

@<Header files...@>=
#include <stdio.h>
#include <stdlib.h>


@ Now we come to the general layout of the |main| function. 

@<The main...@>=
int main (argc, argv)
    int argc; /* the number of arguments on the \UNIX/ command line */
    char **argv; /* the arguments themselves, an array of strings */
{
  @<Variables local to |main|@>;
  prog_name=argv[0];
  status = 0;
  @<Print message @>;
  exit(status);
}


@ Variables local to main are the return status |status|, and the program name |prog_name|.

@<Variables local to |main|@>=
const char *prog_name; /* Program name */
int status; /* Return status */

@ Prints the program message.

@<Print message@>=

printf("%s: hello sort man.\n", prog_name);


@* Index.
Here is a cross-reference table for \.{SORT}.
All sections in which an identifier is used are listed with that identifier,
except that reserved words are indexed only when they appear in format definitions,
and the appearances of identifiers in section names are not indexed.
Underlined entries correspond to where the identifier was declared.
Error messages and a few other things like ``ASCII code dependencies'' are indexed here too.
