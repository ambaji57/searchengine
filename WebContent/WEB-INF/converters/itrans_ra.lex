/*
Please see 
http://www.aczoom.com/itrans/#itransencoding

ITRANS 5.3 Encoding for Devanagari
(Hindi/Marathi/Sanskrit) 

This section describes the ITRANS encoding, for
Devanagari. This is the basic encoding used for all
Indic language scripts. Consult the individual
language manuals in the ITRANS archive
(ITRANS/doc/*.itx files, also available for online
browsing) for exact details on every language
supported by ITRANS. 

Vowels (dependent and independent):
-------
a     aa / A       i      ii / I       u     uu / U 
RRi / R^i    RRI / R^I    LLi / L^i    LLI / L^I
e     ai     o     au     aM    aH

Consonants:
----------- 
k     kh     g     gh     ~N
ch    Ch     j     jh     ~n
T     Th     D     Dh     N
t     th     d     dh     n
p     ph     b     bh     m
y     r      l     v / w
sh    Sh     s     h      L
x / kSh     GY / j~n / dny     shr
R (for marathi half-RA)
L / ld (marathi LLA)
Y (bengali)

Consonants with a nukta (dot) under them (mainly for
Urdu devanagari):
-----------------------------------------
k  with a dot:      q
kh with a dot:      K
g  with a dot:      G
j  with a dot:      z / J
p  with a dot:      f
D  with a dot:      .D
Dh with a dot:      .Dh

Specials/Accents:
-----------------
Anusvara:       .n / M / .m  (dot on top of previous
consonant/vowel)
Avagraha:       .a    (`S' like symbol basically to
replace a after o)
Ardhachandra:   .c    (for vowel sound as in english
words `cat' or `talk')
Chandra-Bindu:  .N    (chandra-bindu on top of
previous letter)
Halant:		.h    (to get half-form of the consonant - no
vowel - virama)
Visarga:        H     (visarga - looks like a colon
character)
Om:		OM, AUM (Om symbol)


[As shown, many codes have multiple choices, example
"RRi / R^i" implies you
 can use either "RRi" or "R^i"]
*/
%x ASCII
%%
OM {printf("°È");}
AUM {printf("°È");}
a\.c	{printf("EY");}
aa\.c	{printf("OY");}
aa {printf("A");}
ii {printf("I");}
uu {printf("U");}
RRi {printf("q");}
R^i {printf("q");}
RRI	{printf("aﬂÈ");}	/* Dirty soln; Q & L mapping should be xfered to ra_d8 */
R^I	{printf("aﬂÈ");}	/* Dirty soln; Q & L mapping should be xfered to ra_d8 */
LLi	{printf("a€È");}
L^i	{printf("a€È");}
LLI {printf("?");}
L^I {printf("?");}
ai {printf("E");}
au {printf("O");}
\.n {printf("M");}
\.m {printf("M");}
\.N {printf("z");}
\.a {printf("ÍÈ");}
kh {printf("K");}
gh {printf("G");}
~N {printf("f");}
N^ {printf("f");} /* For 4.0 compatibility */
ch {printf("c");}
Ch {printf("C");}
Chh {printf("C");} /* For 4.0 compatibility */
jh {printf("J");}
~n {printf("F");}
JN {printf("F");} /* For 4.0 compatibility */
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
\^r {printf("r");} /* CHECK */
\.r {printf("r");} /* CHECK */
v {printf("v");}
w {printf("v");}
sh {printf("S");}
shh {printf("R");} /* For 4.0 compatibility */
Sh {printf("R");}
L {printf("lY");}
ld {printf("lY");}
ksh {printf("kR");} /* For 4.0 compatibility */
x {printf("kR");}
GY {printf("jF");} /* For 4.0 compatibility */
j~n {printf("jF");}
dny {printf("jF");}
shr {printf("Sr");}
R {printf("rY");}
q {printf("kZ");}
K {printf("KZ");}
G {printf("gZ");}
z {printf("jZ");}
f {printf("PZ");}
\.D {printf("dZ");}
\.Dh {printf("DZ");}
##	{BEGIN ASCII;}
<ASCII>##	{BEGIN 0;}
<ASCII>[a-zA-Z]*	{printf("@%s",yytext);}
%%
