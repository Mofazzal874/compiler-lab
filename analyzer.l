%{
#include <stdio.h>
#include <stdlib.h>

int keyword_count = 0;
int identifier_count = 0;
int number_count = 0;

%}

DIGIT       [0-9]+
ID          [a-zA-Z_][a-zA-Z0-9_]*

%%

\"[^\"]*\"                    { /* ignore strings in quotes */ }

"appoint"                     { keyword_count++; }
"identical"                   { keyword_count++; }
"add"                         { keyword_count++; }
"subtract"                    { keyword_count++; }
"divide"                      { keyword_count++; }
"multiply"                    { keyword_count++; }
"power"                       { keyword_count++; }
"is greater than"             { keyword_count++; }
"is less than"                { keyword_count++; }
"is greater than or equal"    { keyword_count++; }
"is less than or equal"       { keyword_count++; }
"not identical"               { keyword_count++; }
"when"                        { keyword_count++; }
"otherwise"                   { keyword_count++; }
"or otherwise"                { keyword_count++; }
"show"                        { keyword_count++; }
"button"                      { keyword_count++; }
"cease"                       { keyword_count++; }
"standby"                     { keyword_count++; }
"endless"                     { keyword_count++; }
"let"                         { keyword_count++; }
"fallback"                    { keyword_count++; }
"sweep"                       { keyword_count++; }
"case"                        { keyword_count++; }  

"=="                          { keyword_count++; }
"+"                           { keyword_count++; }
"-"                           { keyword_count++; }
"/"                           { keyword_count++; }
"*"                           { keyword_count++; }
"\*\*"                        { keyword_count++; }    
">"                           { keyword_count++; }
"<"                           { keyword_count++; }
">="                          { keyword_count++; }
"<="                          { keyword_count++; }
"!="                          { keyword_count++; }

{DIGIT}                       { number_count++; }

{ID}                          { identifier_count++; }

[ \t\n]+                      { /* skip whitespace */ }
.                             { /* ignore any other character */ }

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <inputfile>\n", argv[0]);
        return 1;
    }

    FILE *input = fopen(argv[1], "r");
    if (!input) {
        perror("fopen");
        return 1;
    }
    yyin = input;

    yylex();

    fclose(input);

    FILE *output = fopen("output.txt", "w");
    if (!output) {
        perror("fopen");
        return 1;
    }

    fprintf(output, "Keywords: %d\n", keyword_count);
    fprintf(output, "Identifiers: %d\n", identifier_count);
    fprintf(output, "Numbers: %d\n", number_count);

    fclose(output);
    return 0;
}

int yywrap() {
    return 1;
}