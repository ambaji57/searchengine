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
 char map[] = "zMHaAiIuUqVeEYVoOYkKgGfcCjJFtTdDNwWxXnYpPbBmyYrYlYYvSRsh AiIuUqVeEYVoOY_Z.";
SPECIAL_CATEGORY [���]
VOWEL_ALL [���������������]
VOWEL [�����������]
VOWEL_DRVD [��]
VOWEL_ENGL [��]
HALANT �
NUKTA �
DANDA �
VOWEL_MATRA_ALL [��������������]
VOWEL_MATRA [����������]
VOWEL_MATRA_DRVD [��]
VOWEL_MATRA_ENGL [��]
CONSONANT_SYLLABIC [���������������������������������]
CONSONANT_SYLLABIC_ADTNL [�����]
CONSONANT_SYLLABIC_ADTNL_1 [����]
CONSONANT_SYLLABIC_ADTNL_2 �
CONSONANT_SYLLABIC_nY �
CONSONANT_SYLLABIC_yY �
CONSONANT_SYLLABIC_rY �
CONSONANT_SYLLABIC_lY �
CONSONANT_SYLLABIC_lYY �
NUMBER [�-�]
ROM_WORD [A-Za-z0-9]+
%%
{ROM_WORD}				{
					printf("@");ECHO;
					}
{NUMBER}				{
					printf("%c", yytext[0]-193);
					}
{CONSONANT_SYLLABIC}			{
					printf("%ca",map[95 + yytext[0] ]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}		{
					printf("%cYa",map[95 + yytext[0]-1]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}		{
					printf("%cYYa",map[95 + yytext[0]-2]);
					}

{CONSONANT_SYLLABIC}{HALANT}		{
					printf("%c",map[95 + yytext[0] ]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{HALANT}	{
					printf("%cY",map[95 + yytext[0]-1]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{HALANT}	{
					printf("%cYY",map[95 + yytext[0]-2]);
					}

{CONSONANT_SYLLABIC}{VOWEL_MATRA}	{
					printf("%c%c",map[95 + yytext[0] ],map[95 + yytext[1] ]);
					}

{CONSONANT_SYLLABIC}{VOWEL_MATRA_DRVD}	{
					printf("%c%cV",map[95 + yytext[0] ],map[95 + yytext[1]+1]);
					}

{CONSONANT_SYLLABIC}{VOWEL_MATRA_ENGL}	{
					printf("%c%cY",map[95 + yytext[0] ],map[95 + yytext[1]-1]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{VOWEL_MATRA} {
					printf("%cY%c",map[95 + yytext[0]-1],map[95 + yytext[1] ]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{VOWEL_MATRA_DRVD} {
					printf("%cY%cV",map[95 + yytext[0]-1],map[95 + yytext[1]+1]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{VOWEL_MATRA_ENGL} {
					printf("%cY%cY",map[95 + yytext[0]-1],map[95 + yytext[1]-1]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{VOWEL_MATRA} {
					printf("%cYY%c",map[95 + yytext[0]-2],map[95 + yytext[1] ]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{VOWEL_MATRA_DRVD} {
					printf("%cYY%cV",map[95 + yytext[0]-2],map[95 + yytext[1]+1]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{VOWEL_MATRA_ENGL} {
					printf("%cYY%cY",map[95 + yytext[0]-2],map[95 + yytext[1]-1]);
					}

{VOWEL}					{
					printf("%c",map[95 + yytext[0] ]);
					}

{VOWEL_DRVD}				{
					printf("%cV",map[95 + yytext[0]+1]);
					}

{VOWEL_ENGL}				{
					printf("%cY",map[95 + yytext[0]-1]);
					}

{SPECIAL_CATEGORY}			{
					printf("%c",map[95 + yytext[0] ]);
					}

{VOWEL_MATRA}				{
					printf("%c",map[95 + yytext[0] ]);
					}

{VOWEL_MATRA_DRVD}			{
					printf("%cV",map[95 + yytext[0]+1]);
					}

{VOWEL_MATRA_ENGL}			{
					printf("%cY",map[95 + yytext[0]-1]);
					}

{HALANT}				{
					printf("%c",map[95 + yytext[0] ]);
					}

{NUKTA}					{
					printf("%c",map[95 + yytext[0] ]);
					}

{DANDA}{NUKTA}				{
					printf("Z");
					}

{CONSONANT_SYLLABIC}{NUKTA}		{
					printf("%cZa",map[95 + yytext[0] ]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{NUKTA}	{
					printf("%cYZa",map[95 + yytext[0]-1]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{NUKTA}	{
					printf("%cYYZa",map[95 + yytext[0]-2]);
					}

{CONSONANT_SYLLABIC}{NUKTA}{HALANT}	{
					printf("%cZ",map[95 + yytext[0] ]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{NUKTA}{HALANT} {
					printf("%cZY",map[95 + yytext[0]-1]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{NUKTA}{HALANT} {
					printf("%cZYY",map[95 + yytext[0]-2]);
					}

{CONSONANT_SYLLABIC}{NUKTA}{VOWEL_MATRA} {
					printf("%cZ%c",map[95 + yytext[0] ],map[95 + yytext[2] ]);
					}

{CONSONANT_SYLLABIC}{NUKTA}{VOWEL_MATRA_DRVD}	{
					printf("%cZ%cV",map[95 + yytext[0] ],map[95 + yytext[2]+1]);
					}

{CONSONANT_SYLLABIC}{NUKTA}{VOWEL_MATRA_ENGL}	{
					printf("%cZ%cY",map[95 + yytext[0] ],map[95 + yytext[2]-1]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{NUKTA}{VOWEL_MATRA} {
					printf("%cYZ%c",map[95 + yytext[0]-1],map[95 + yytext[2] ]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{NUKTA}{VOWEL_MATRA_DRVD} {
					printf("%cYZ%cV",map[95 + yytext[0]-1],map[95 + yytext[2]+1]);
					}

{CONSONANT_SYLLABIC_ADTNL_1}{NUKTA}{VOWEL_MATRA_ENGL} {
					printf("%cYZ%cY",map[95 + yytext[0]-1],map[95 + yytext[2]-1]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{NUKTA}{VOWEL_MATRA} {
					printf("%cYYZ%c",map[95 + yytext[0]-2],map[95 + yytext[2] ]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{NUKTA}{VOWEL_MATRA_DRVD} {
					printf("%cYYZ%cV",map[95 + yytext[0]-2],map[95 + yytext[2]+1]);
					}

{CONSONANT_SYLLABIC_ADTNL_2}{NUKTA}{VOWEL_MATRA_ENGL} {
					printf("%cYYZ%cY",map[95 + yytext[0]-2],map[95 + yytext[2]-1]);
					}

�{NUKTA}				{
					printf("Q");
					}

�{NUKTA}				{
					printf("Q");
					}

{CONSONANT_SYLLABIC}�{NUKTA}			{
					printf("%cQ",map[95 + yytext[0] ]);
					}

�{NUKTA}				{
					printf("L");
					}

�{NUKTA}				{
					printf("L");
					}

{CONSONANT_SYLLABIC}�{NUKTA}			{
					printf("%cL",map[95 + yytext[0] ]);
					}
