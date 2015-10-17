#!/usr/bin/perl

while($in=<STDIN>)
{
$in=~ s{A}{aa}g;
$in=~ s{I}{ii}g;
$in=~ s{U}{uu}g;
$in=~ s{L}{\.l}g;

$in=~ s{E}{ai}g;
$in=~ s{O}{au}g;

$in=~ s{H}{\.h}g;
$in=~ s{q}{\.r}g;
$in=~ s{Q}{\.rr}g;
$in=~ s{L}{\.l}g;

$in=~ s{K}{kh}g;
$in=~ s{G}{gh}g;
$in=~ s{f}{f}g;

$in=~ s{C}{ch}g;
$in=~ s{J}{jh}g;
$in=~ s{F}{~n}g;

$in=~ s{t}{\.t}g;
$in=~ s{T}{\.th}g;
$in=~ s{d}{\.d}g;
$in=~ s{D}{\.dh}g;
$in=~ s{N}{\.n}g;

$in=~ s{M}{\.m}g;

$in=~ s{w}{t}g;
$in=~ s{W}{th}g;
$in=~ s{x}{d}g;
$in=~ s{X}{dh}g;

$in=~ s{P}{ph}g;
$in=~ s{B}{bh}g;

$in=~ s{S}{z}g;
$in=~ s{R}{\.s}g;

print $in;
}
