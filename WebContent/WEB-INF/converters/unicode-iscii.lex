 char iscii[] = {' ','�','�','�',' ','�','�','�','�','�','�','�',' ','�'
 ,'�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�'
 ,'�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�'
 ,'�','�','�','�','�','�','�',' ',' ','�',' ','�','�','�','�','�','�'
 ,' ','�','�','�','�','�','�','�','�','�',' ',' ',' ',' ',' ',' ',' '
 ,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','�',' ',' ',' ',' ','�',' ','�','�'
 ,'�','�','�','�','�','�','�','�'};
 char ans[5];
 int bigend,littleend;

isciipage [	]
%x BE
%x LE 
%%
�� {BEGIN BE;}
�� {BEGIN LE;}

<BE>{isciipage}.   {uni_to_iscii(yytext[1],ans);printf("%s",ans);}
<BE>{isciipage}\n  {uni_to_iscii(yytext[1],ans);printf("%s",ans);}
<BE> .            {printf("%c",yytext[1]);}
<BE> \n           {printf("%c",yytext[1]);}

<LE>.{isciipage}   {uni_to_iscii(yytext[0],ans);printf("%s",ans);}
<LE>\n{isciipage}  {uni_to_iscii(yytext[0],ans);printf("%s",ans);}
<LE>.             {printf("%c",yytext[0]);}
<LE>\n            {printf("%c",yytext[0]);}
%%   

 #include<stdio.h>
 main()
 {
  int ch,ch1;
  yylex();
 }
 
 uni_to_iscii(int ch,char ch1[3])
 {
  ch1[1]=233;
  ch1[2]='\0';

  switch(ch)
  {     case 12: {ch1[0]=ch+154;break;}
        case 61: {ch1[0]=ch+173;break;} 
        case 68: {ch1[0]=ch+155;break;}
        case 80: {ch1[0]=ch+81;break;} 
        case 88: {ch1[0]=ch+91;break;} 
        case 89: {ch1[0]=ch+91;break;} 
        case 90: {ch1[0]=ch+90;break;} 
        case 91: {ch1[0]=ch+95;break;} 
        case 92: {ch1[0]=ch+99;break;} 
        case 93: {ch1[0]=ch+99;break;}
        case 94: {ch1[0]=ch+107;break;}
        case 96: {ch1[0]=ch+74;break;} 
        case 97: {ch1[0]=ch+70;break;}
        case 98: {ch1[0]=ch+121;break;}
        case 99: {ch1[0]=ch+121;break;}
        default: ch1[0]=iscii[ch];ch1[1]='\0';
   }
} 
