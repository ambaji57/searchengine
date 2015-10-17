#!/usr/bin/perl

while($in = <STDIN>){
print &SLP2WX($in);
}

sub SLP2WX {
 my($in) = @_;
 $in =~ s/w/1/g;
 $in =~ s/W/2/g;
 $in =~ s/q/3/g;
 $in =~ s/Q/4/g;
 $in =~ s/R/5/g;
 $in =~ s/Y/6/g;
 $in =~ s/N/7/g;
 $in =~ s/x/L/g;
 $in =~ s/t/w/g;
 $in =~ s/T/W/g;
 $in =~ s/d/x/g;
 $in =~ s/D/X/g;
 $in =~ s/f/q/g;
 $in =~ s/F/Q/g;
 $in =~ s/z/R/g;
 $in =~ s/1/t/g;
 $in =~ s/2/T/g;
 $in =~ s/3/d/g;
 $in =~ s/4/D/g;
 $in =~ s/5/N/g;
 $in =~ s/6/F/g;
 $in =~ s/7/f/g;
 $in =~ s/\|/lYh/g;
 $in =~ s/\~A/Az/g;
 return $in;
}
