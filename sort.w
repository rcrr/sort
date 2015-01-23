% An example of CWEB by Roberto Corradini
%
% sort.w
%
% This file is part of the sort program
% http://github.com/rcrr/sort
%
% Author Roberto Corradini mailto:rob_corradini@@yahoo.it
% Copyright 2015 Roberto Corradini. All rights reserved.
%
% License
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
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA
% or visit the site <http://www.gnu.org/licenses/>.
%

\datethis % print date on listing

@* The purpose of \.{sort} is to provide a pool of algorithm for sorting.

@c
@<Header files to include@>@/
@<The main program@>


@ We include header files \.{stdio.h} and  \.{stdlib.h}

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


@ Variables local to main are the return status |status|, and the program name |progname|.

@<Variables local to |main|@>=
const char *prog_name; /* Program name */
int status; /* Return status */

@

@<Print message@>=

printf("%s: hello sort-man.\n", prog_name);