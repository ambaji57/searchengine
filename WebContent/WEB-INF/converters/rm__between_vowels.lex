VOWEL [�������騩������]
MAWRA [�����������]
%%
{VOWEL}_/{VOWEL}	{ printf("%c",yytext[0]);}
{MAWRA}_/{VOWEL}	{ printf("%c",yytext[0]);}
%%
