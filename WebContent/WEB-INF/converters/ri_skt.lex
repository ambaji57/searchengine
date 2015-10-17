/*
##############################################################################
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later
#  version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

##############################################################################
*/
 char map[]="01234567890123456789012345678901234567890123456789012345678901234�˹�⼶�ܻ�L����Q�վ�V��Y�      �ʸ�᷵�ۺ��������׽����͡ ";
NUKTA Z
OPERATOR_V V
OPERATOR_Y Y
SPECIAL_CATEGORY [zMH]
VOWEL_A a
VOWEL_Q Q
VOWEL_L L
VOWEL_REMAINING [AiIuUqeEoO]
CONSONANT [kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSRsh]
ROM_WORD [A-Za-z0-9]+
%x CONS 
%%
@{ROM_WORD}				{printf("%s",yytext+1);}

{CONSONANT}				{
					printf("%c",map[yytext[0] ]);BEGIN CONS;
					}

z{NUKTA}				{
					printf("��");
					}
\.					{
					printf("�");
					}
\.{NUKTA}				{
					printf("��");
					}
{NUKTA}					{
					printf("��");
					}
<CONS>I{NUKTA}				{
					printf("��");
					BEGIN INITIAL;
					}

<CONS>{NUKTA}				{
					printf("���");
					BEGIN INITIAL;
					}

<CONS>{VOWEL_A}				{BEGIN INITIAL;}

<CONS>{VOWEL_Q}				{
					printf("��");
					BEGIN INITIAL;
					}

<CONS>{VOWEL_L}				{
					printf("��");
					BEGIN INITIAL;
					}

<CONS>{VOWEL_REMAINING}			{
					printf("%c",map[yytext[0] ]);
					BEGIN INITIAL;
					}

<CONS>{VOWEL_REMAINING}{OPERATOR_V}+ 	{
					printf("%c",map[yytext[0] ]-yyleng+1);
					BEGIN INITIAL;
					}

<CONS>{VOWEL_REMAINING}{OPERATOR_Y}+ 	{
					printf("%c",map[yytext[0] ]+yyleng-1);
					BEGIN INITIAL;
					}

<CONS>{CONSONANT}			{
					printf("�%c",map[yytext[0] ]);
					}

<CONS>{CONSONANT}{OPERATOR_V}+		{
					printf("�%c",map[yytext[0] ]-yyleng+1);
					}

<CONS>{CONSONANT}{OPERATOR_Y}+		{
					printf("�%c",map[yytext[0] ]+yyleng-1);
					}

<CONS>(.|\n)				{
					printf("�%c",yytext[0]);
					BEGIN INITIAL;
					}

{VOWEL_REMAINING}			{
					printf("%c",map[yytext[0] ]-53);
					}

{VOWEL_A}				{
					printf("%c",map[yytext[0] ]);
					}

{VOWEL_Q}				{
					printf("��");
					}

{VOWEL_L}				{
					printf("��");
					}
{SPECIAL_CATEGORY}			{
					printf("%c",map[yytext[0] ]);
					}

{CONSONANT}{OPERATOR_V}+		{
					printf("%c",map[yytext[0] ]-yyleng+1);
					BEGIN CONS;
					}

{CONSONANT}{OPERATOR_Y}+		{
					printf("%c",map[yytext[0] ]+yyleng-1);
					BEGIN CONS;
					}

{VOWEL_REMAINING}{OPERATOR_V}+		{
					printf("%c",map[yytext[0] ]-53-yyleng+1);
					}

{VOWEL_REMAINING}{OPERATOR_Y}+		{
					printf("%c",map[yytext[0] ]-53+yyleng-1);
					}


{VOWEL_A}{OPERATOR_V}+			{
					printf("%c",map[yytext[0] ]-yyleng+1);
					}

{VOWEL_A}{OPERATOR_Y}+			{
					printf("%c",map[yytext[0] ]+yyleng-1);
					}
\.Y					{
					printf("��");
					}

