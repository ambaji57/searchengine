#!/usr/bin/perl

while($in=<STDIN>) {
print &huet2wx($in);
}

sub huet2wx{
my($in) = @_;
$in=~ s/\.r/q/g;
$in=~ s/\.R/Q/g;
$in=~ s/\.l/L/g;
$in=~ s/kh/K/g;
$in=~ s/gh/G/g;
$in=~ s/\"n/f/g;
$in=~ s/f/f/g;
$in=~ s/ch/C/g;
$in=~ s/jh/J/g;
$in=~ s/\~n/F/g;
$in=~ s/\.th/12/g;
$in=~ s/\.t/11/g;
$in=~ s/\.T/12/g;
$in=~ s/\.dh/14/g;
$in=~ s/\.d/13/g;
$in=~ s/\.D/14/g;
$in=~ s/th/W/g;
$in=~ s/t/w/g;
$in=~ s/T/W/g;
$in=~ s/dh/X/g;
$in=~ s/d/x/g;
$in=~ s/D/X/g;
$in=~ s/\.n/N/g;
$in=~ s/ph/P/g;
$in=~ s/bh/B/g;
#$in=~ s/\'s/S/g;
$in=~ s/\"s/S/g;
$in=~ s/z/S/g;
$in=~ s/\.s/R/g;
$in=~ s/\.m/M/g;
$in=~ s/\.h/H/g;
$in=~ s/aa/A/g;
$in=~ s/ii/I/g;
$in=~ s/uu/U/g;
$in=~ s/ai/E/g;
$in=~ s/au/O/g;
$in =~ s/11/t/g;
$in =~ s/12/T/g;
$in =~ s/13/d/g;
$in =~ s/14/D/g;
$in;
}
1;
