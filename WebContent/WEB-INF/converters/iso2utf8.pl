#!/usr/bin/perl

use Encode qw( from_to is_utf8 );

while($in = <STDIN>){
from_to($in, "iso-8859-1", "utf8");
print $in;
}
