% sort: An example of CWEB by Roberto Corradini

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