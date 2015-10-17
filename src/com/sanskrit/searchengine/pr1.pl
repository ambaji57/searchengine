#!/usr/bin/perl
$path=$ARGV[0];
$rt=$ARGV[1];
chomp $rt;
$gen=$ARGV[2];
chomp $gen;
$pid=$$;
$LTPROC_IN = "";
print $path;
print $rt;
print $gen;
#print "kannaiahchinni";
	if($gen eq "puM"){
			&male();
			&normalize();
			system("/bin/cat /tmp/out$pid");
                       system("rm -rf /tmp/gen$pid /tmp/out$pid /tmp/din$pid /tmp/dout$pid");
			}
	elsif($gen eq "napuM"){
			&neutral();
			&normalize();
			system("/bin/cat /tmp/out$pid");
                        system("rm -rf /tmp/gen$pid /tmp/out$pid /tmp/din$pid /tmp/dout$pid");
			}	
	elsif($gen eq "swrI"){
			&female();
			&normalize();
			system("/bin/cat /tmp/out$pid");
                        system("rm -rf /tmp/gen$pid /tmp/out$pid /tmp/din$pid /tmp/dout$pid");
			}
	elsif($gen eq "a"){
			&male();
			&neutral();
			&female();
			system("/usr/bin/sort -u /tmp/gen$pid | /bin/sed '1,\$ s/?//g' >/tmp/tmp$pid");
			system("/bin/mv /tmp/tmp$pid /tmp/gen$pid");
			&normalize();
			system("/bin/cat /tmp/out$pid");
                        system("rm -rf /tmp/gen$pid /tmp/out$pid /tmp/din$pid /tmp/dout$pid");
		}
#system("rm -rf /tmp/in* /tmp/gen* /tmp/din* /tmp/dout* /tmp/out*");
sub male(){
for($vib=1;$vib<9;$vib++){
                        for($num=1;$num<4;$num++){
                            $str = "$rt<vargaH:nA><lifgam:puM><viBakwiH:$vib><vacanam:$num><level:1>";
                         $LTPROC_IN .=  $str."\n";
                                }
                        }
                        $str = "/bin/echo '".$LTPROC_IN."' | /usr/bin/lt-proc -c $path/WEB-INF/classes/com/sanskrit/searchengine/skt_gen.bin | sed '1,\$s/^[^/]\\+\\///' | sed '1,\$s/\$\$//' | /usr/bin/pr -3 -a -t >/tmp/gen$pid";
	
system($str);

}

sub neutral(){
for($vib=1;$vib<9;$vib++){
        		        for($num=1;$num<4;$num++){
	                    $str = "$rt<vargaH:nA><lifgam:napuM><viBakwiH:$vib><vacanam:$num><level:1>";
        	         $LTPROC_IN .=  $str."\n";
				}
			}
                        $str = "/bin/echo '".$LTPROC_IN."' | /usr/bin/lt-proc -c $path/WEB-INF/classes/com/sanskrit/searchengine/skt_gen.bin | sed '1,\$s/^[^/]\\+\\///' | sed '1,\$s/\$\$//' | /usr/bin/pr -3 -a -t >/tmp/gen$pid";
system($str);
}

sub female(){
for($vib=1;$vib<9;$vib++){
        		        for($num=1;$num<4;$num++){
	                    $str = "$rt<vargaH:nA><lifgam:swrI><viBakwiH:$vib><vacanam:$num><level:1>";
        	         $LTPROC_IN .=  $str."\n";
   				}
			}
                        $str = "/bin/echo '".$LTPROC_IN."' | /usr/bin/lt-proc -c $path/WEB-INF/classes/com/sanskrit/searchengine/skt_gen.bin | sed '1,\$s/^[^/]\\+\\///' | sed '1,\$s/\$\$//' | /usr/bin/pr -3 -a -t >/tmp/gen$pid";
system($str);
}

sub normalize(){
system("/bin/cat /tmp/gen$pid | /bin/sed '1,\$ s/\t\t\t/\\n/g'| /bin/sed '1,\$ s/\t\t/\\n/g' >/tmp/din$pid");
                        system(" /usr/bin/perl $path/WEB-INF/classes/com/sanskrit/searchengine/denormalise.pl </tmp/din$pid >/tmp/dout$pid");
                        system("/bin/cat /tmp/din$pid /tmp/dout$pid | /bin/sed '\:a\;N\;\$\!ba\;s/\\n\\n/\\n/g'| /bin/sed '/^\$/d' |/usr/bin/sort |/usr/bin/sort -u >/tmp/out$pid ");
}

