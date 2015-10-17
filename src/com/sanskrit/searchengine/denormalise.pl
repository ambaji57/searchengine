#!/usr/bin/perl

while($in = <STDIN>){

$in =~ s/f([kKgGf])/M$1/g;
$in =~ s/F([cCjJF])/M$1/g;
$in =~ s/N([tTdDN])/M$1/g;
$in =~ s/n([wWxXn])/M$1/g;
$in =~ s/m([pPbBm])/M$1/g;
$in =~ s/m$/M/g;
$in =~ s/rww([aeiouAEIOUqQ])/rw$1/g;
$in =~ s/rw([aeiouAEIOUqQ])/rww$1/g;
$in =~ s/m(\b)/M$1/g;

print $in;
}
