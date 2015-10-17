#!/usr/bin/perl

while($in=<STDIN>)
{
$in=~ s{A}{ā}g;
$in=~ s{I}{ī}g;
$in=~ s{U}{ū}g;
#$in=~ s{L}{\.l}g;

$in=~ s{E}{ai}g;
$in=~ s{O}{au}g;

$in=~ s{H}{ḥ}g;
$in=~ s{q}{ṛ}g;
#$in=~ s{Q}{\.rr}g;
#$in=~ s{L}{\.l}g;

$in=~ s{K}{kh}g;
$in=~ s{G}{gh}g;
$in=~ s{f}{ṅ}g;

$in=~ s{C}{ch}g;
$in=~ s{J}{jh}g;
$in=~ s{F}{ñ}g;

$in=~ s{t}{ṭ}g;
$in=~ s{T}{ṭh}g;
$in=~ s{d}{ḍ}g;
$in=~ s{D}{ḍh}g;
$in=~ s{N}{ṇ}g;

$in=~ s{M}{ṃ}g;

$in=~ s{w}{t}g;
$in=~ s{W}{th}g;
$in=~ s{x}{d}g;
$in=~ s{X}{dh}g;

$in=~ s{P}{ph}g;
$in=~ s{B}{bh}g;

$in=~ s{S}{ś}g;
$in=~ s{R}{ṣ}g;

print $in;
}
