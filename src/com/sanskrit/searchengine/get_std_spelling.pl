#!/usr/bin/perl


while($in = <STDIN>){
$in =~ s/M([kKgGf])/f$1/g;
$in =~ s/M([cCjJF])/F$1/g;
$in =~ s/M([tTdDN])/N$1/g;
$in =~ s/M([wWxXn])/n$1/g;
$in =~ s/M([pPbBm])/m$1/g;
$in =~ s/M$/m/g;
#$in =~ s/x$/w/g; THIS IS A WRONG RULE.
$in =~ s/rww([aeiouAEIOUqQ])/rw$1/g;
$in =~ s/M(\b)/m$1/g;

print $in;

}
