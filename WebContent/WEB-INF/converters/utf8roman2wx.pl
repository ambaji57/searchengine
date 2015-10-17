#!/usr/bin/perl

while($in=<STDIN>)
{
$in=~ s{ā}{A}g;
$in=~ s{ī}{I}g;
$in=~ s{ū}{U}g;

$in=~ s{ai}{E}g;
$in=~ s{au}{O}g;

$in=~ s{ḥ}{H}g;
$in=~ s{ṛ}{q}g;

$in=~ s{kh}{K}g;
$in=~ s{gh}{G}g;
$in=~ s{ṅ}{f}g;

$in=~ s{ch}{C}g;
$in=~ s{jh}{J}g;
$in=~ s{ñ}{F}g;

$in=~ s{ṭh}{T}g;
$in=~ s{ṭ}{t}g;
$in=~ s{ḍh}{D}g;
$in=~ s{ḍ}{d}g;
$in=~ s{ṇ}{N}g;

$in=~ s{ṃ}{M}g;

$in=~ s{th}{W}g;
$in=~ s{t}{w}g;
$in=~ s{dh}{X}g;
$in=~ s{d}{x}g;

$in=~ s{ph}{P}g;
$in=~ s{bh}{B}g;

$in=~ s{ś}{S}g;
$in=~ s{ṣ}{R}g;

print $in;
}
