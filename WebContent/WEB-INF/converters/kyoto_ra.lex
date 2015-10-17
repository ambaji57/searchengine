/*
Specials/Accents:
-----------------
Avagraha:       .a    (`S' like symbol basically to replace a after o)
Ardhachandra:   .c    (for vowel sound as in english words `cat' or `talk')
Halant:         .h    (to get half-form of the consonant - no vowel - virama)
Om:             OM, AUM (Om symbol)

A few new codes are now also accepted: 
	^r (== .r == hindi-half-ra). 

Consonants with a nukta (dot) under them (mainly for Urdu devanagari):
-----------------------------------------

*****************************

The ITRANS 4.0 transliteration scheme is

vowels(svara):  a A i I u U R e E o O aM aH L^i L^I
consonents(vya.njana):
  k kh g gh G ch chh j jh J T Th D Dh N t th d dh n p ph b bh m
  y r l v z S s h L(Marathi) ksh(x) GY(Hindi)
  q K G z f .D .Dh are the letters k, kh, g, j, ph, D, Dh with nuktaas for 
Urdu.
Both .n and M produce anusvaara, .a avagraha, .h haLa.nta (leg break), H 
visarga
Only a dot . or a vertical line | produce a da.nDa . 
\. produces just a dot (puurNaviraama).  
a.c and aa.c produce ardhachandra as in cat and talk.
The vowels need to be added after each consonent, unless one wants 
joDaakshara.  
No other letters (upper or lower cases) are allowed.
Enclose english text in two sets of ## signs (before and after the text.

Kyoto-Harvard scheme is almost same as itrans.
The only difference is
      ITRANS                     Harvard-kyoto            
1) sh - (shambhu) -          z - (zambhu)
2) ~N - (sha~Nkara)          G - (zaGkara)
3) ~n - (sa~njaya)           J - (saJjaya)
4) Sh - (ShaNmukha)          S - (SaNmukha)
5) R^i - (R^iNam)            R - (RNam)
 and for long vowels in ITRANS there is option  like - aa = A
but in Harvard-kyoto its only the upper-case i.e., the long vowels are A I U 
*****************************
*/
%x ASCII
%%
OM {printf("ก้");}
AUM {printf("ก้");}
a\.c	{printf("EY");}
R {printf("q");}
L^i	{printf("aÛ้");}
L^I {printf("?");}
kh {printf("K");}
gh {printf("G");}
G {printf("f");}
ch {printf("c");}
Ch {printf("C");}
chh {printf("C");} 
jh {printf("J");}
J {printf("F");}
T {printf("t");}
Th {printf("T");}
D {printf("d");}
Dh {printf("D");}
t {printf("w");}
th {printf("W");}
d {printf("x");}
dh {printf("X");}
ph {printf("P");}
bh {printf("B");}
\^r {printf("r");}
\.r {printf("r");}
w {printf("v");}
z {printf("S");}
S {printf("R");}
L {printf("lY");}
ld {printf("lY");}
kS {printf("kR");}
x {printf("kR");}
GY {printf("jF");}
j~n {printf("jF");}
dny {printf("jF");}
zr {printf("Sr");}
q {printf("kZ");}
K {printf("KZ");}
f {printf("PZ");}
\.D {printf("dZ");}
\.Dh {printf("DZ");}
\.a {printf(".Z");}
##	{BEGIN ASCII;}
<ASCII>##	{BEGIN 0;}
<ASCII>[a-zA-Z]*	{printf("@%s",yytext);}
%%
