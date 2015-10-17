#!/usr/bin/perl

while($in = <STDIN>){
print &WX2SLP($in);
}

sub WX2SLP {
 my($in) = @_;

 $in =~ s/t/1/g;
 $in =~ s/T/2/g;
 $in =~ s/d/3/g;
 $in =~ s/D/4/g;
 $in =~ s/N/5/g;
 $in =~ s/F/6/g;
 $in =~ s/f/7/g;

 $in =~ s/L/x/g;
 $in =~ s/w/t/g;
 $in =~ s/W/T/g;
 $in =~ s/x/d/g;
 $in =~ s/X/D/g;
 $in =~ s/q/f/g;
 $in =~ s/Q/F/g;
 $in =~ s/R/z/g;

 $in =~ s/1/w/g;
 $in =~ s/2/W/g;
 $in =~ s/3/q/g;
 $in =~ s/4/Q/g;
 $in =~ s/5/R/g;
 $in =~ s/6/Y/g;
 $in =~ s/7/N/g;

 $in =~ s/lYh/\|/g;
 $in =~ s/Az/\~A/g;
 return $in;
}
