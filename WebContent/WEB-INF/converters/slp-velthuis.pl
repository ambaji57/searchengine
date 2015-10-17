#! /usr/bin/perl  

while($in=<STDIN>) {
$in=~s{Y}{~n}g;
$in=~s{A}{aa}g;
$in=~s{w}{.t}g;
$in=~s{W}{.th}g;
$in=~s{I}{ii}g;
$in=~s{q}{.d}g;
$in=~s{Q}{.dh}g;
$in=~s{U}{uu}g;
$in=~s{R}{.n}g;
$in=~s{f}{.r}g;
$in=~s{F}{.rr}g;
$in=~s{T}{th}g;
$in=~s{x}{.l}g;
$in=~s{D}{dh}g;
$in=~s{E}{ai}g;
$in=~s{O}{au}g;
$in=~s{P}{ph}g;
$in=~s{M}{.m}g;
$in=~s{~}{"m}g;
$in=~s{B}{bh}g;
$in=~s{H}{.h}g;
$in=~s{K}{kh}g;
$in=~s{G}{gh}g;
$in=~s{N}{f}g;
$in=~s{S}{z}g;
$in=~s{z}{.s}g;
$in=~s{C}{ch}g;
$in=~s{J}{jh}g;
}
