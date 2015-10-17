#!/usr/bin/perl

while($in=<STDIN>) {
print &velthuis2kyoto($in);
}

sub velthuis2kyoto{
my($in) = @_;
$in=~ s/aa/A/g;
$in=~s/ii/I/g;
$in=~s/uu/U/g;
$in=~s/\.rr/RR/g;
$in=~s/\.r/R/g;
$in=~s/\.II/IRR/g;
$in=~s/\.I/IR/g;
$in=~s/\.m/M/g;
$in=~s/"m/M/g;
$in=~s/\.h/H/g;
$in=~s/\"n/G/g;
$in=~s/~n/J/g;
$in=~s/\.t/T/g;
$in=~s/\.th/Th/g;
$in=~s/\.d/D/g;
$in=~s/\.dh/Dh/g;
$in=~s/\.n/N/g;
$in=~s/\"s/z/g;
$in=~s/\.s/S/g;
$in;
}
1;
