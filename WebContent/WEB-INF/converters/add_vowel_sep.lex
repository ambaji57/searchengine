VOWEL [aeiou]
WRD  [^ \t\n]+
%%
@{WRD}	printf("%s",yytext);
{VOWEL}{VOWEL}	printf("%c_%c",yytext[0],yytext[1]);
%%
