
 int lang_code=9,ascii_code=0,ch;
 int unicode[] = {1,2,3,5,6,7,8,9,10,11,14,15,16,13,18,19,20,17,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,95,48,49,50,51,52,53,54,55,56,57,0,62,63,64,65,66,67,70,71,72,69,74,75,76,73,77,60,100,0,0,0,0,0,0,102,103,104,105,106,107,108,109,110,111};
chr [¡-ê]
%%
{chr}é    { ch=special_case(yytext[0]);
	    ch = 256*lang_code + ch;
            printf("&#%d;",ch); 
          }

{chr}     { ch = 256*lang_code + unicode[yytext[0]-'¡']; 
            printf("&#%d;",ch); 
          }

.         { printf("%c",yytext[0]); }
\n	  { printf("<br>");}

%%

 #include<stdio.h>
 #include<string.h>
 #include<ctype.h>

 main(int argc,char *argv) {  
    printf("<HTML><BODY>");
    yylex();
    printf("</BODY></HTML>");
 }

 int special_case(int ch)
 {
  if(ch=='¡')       ch-=81;
  else if(ch=='¦')  ch-=154;
//  else if(ch=='ê')  ch-=173;
  else if(ch=='ê')  ch=61;
  else if(ch=='ß') ch-=155;
  else if(ch=='³')  ch-=91;
  else if(ch=='´')  ch-=91;
  else if(ch=='µ')  ch-=91;
  else if(ch=='º')  ch-=95;
  else if(ch=='¿')  ch-=99;
  else if(ch=='À')  ch-=99;
  else if(ch=='É')  ch-=107;
  else if(ch=='ª')  ch-=74;
  else if(ch=='§')  ch-=70;
  else if(ch=='Û') ch-=121;
  else if(ch=='Ü') ch-=121;
  return ch; 
}
