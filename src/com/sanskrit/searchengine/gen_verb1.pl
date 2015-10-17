#!/usr/bin/perl -w
$path=$ARGV[0];
require "$path/WEB-INF/classes/com/sanskrit/searchengine/converters/convert.pl";

package main;
use CGI qw/:standard/;
use CGI::Carp qw(fatalsToBrowser);

@lakAra = ("lat","lit","lut","lqt","lot","laf","viXilif","ASIrlif","luf","lqf");
@person = ("pra","ma","u");

$rt = $ARGV[0];
 #$mng = $ARGV[1];
 $prygH = $ARGV[2];
 $pid = $$;

# $rt =~s/@/ /g;

 $rt_XAwu_gaNa = &convert("Unicode",$pid,$rt);
 chomp($rt_XAwu_gaNa);
 $rt_XAwu_gaNa =~ s/@//g;

 $prayogaH = &convert("Unicode",$pid,$prygH);
 chomp($prayogaH);
   $LTPROC_IN = "";
   $LTPROC_IN1 = "";
   $str = "";
   $str1 = "";

    ($rt,$XAwu,$gaNa,$mean) = split(/_/,$rt_XAwu_gaNa);
          for($l=0;$l<10;$l++){
            $lakAra = $lakAra[$l];
             for($per=0;$per<3;$per++){
             $person = $person[$per];
               for($num=1;$num<4;$num++){
                    $str = "$rt<prayogaH:$prayogaH><lakAraH:$lakAra><puruRaH:$person><vacanam:$num><paxI:parasmEpaxI><XAwuH:$XAwu><gaNaH:$gaNa><level:1>";
                   $LTPROC_IN .=  $str."\n";
                } # number
            } #person
         } #lakAra

   $str = "echo '".$LTPROC_IN."' | /usr/bin/lt-proc -ct $path/WEB-INF/classes/com/sanskrit/searchengine/skt_gen.bin |pr -3 -a -t -J | /bin/sed '1,\$ s/\t/\\n/g'| /bin/sed '1,\$ s/?//g'| /bin/sed '1,\$ s/\\//\\n/g' >/tmp/out1$pid";

       for($l=0;$l<10;$l++){
             $lakAra = $lakAra[$l];
             for($per=0;$per<3;$per++){
                $person = $person[$per];
                for($num=1;$num<4;$num++){
                    $str1 = "$rt<prayogaH:$prayogaH><lakAraH:$lakAra><puruRaH:$person><vacanam:$num><paxI:AwmanepaxI><XAwuH:$XAwu><gaNaH:$gaNa><level:1>";
                   $LTPROC_IN1 .=  $str1."\n";
                } # number
            } #person
         } #lakAra
$str1 = "echo '".$LTPROC_IN1."' | /usr/bin/lt-proc -ct $path/WEB-INF/classes/com/sanskrit/searchengine/skt_gen.bin | pr -3 -a -t -J | /bin/sed '1,\$ s/\t/\\n/g'| /bin/sed '1,\$ s/?//g'| /bin/sed '1,\$ s/\\//\\n/g' > /tmp/out2$pid";

  system($str);
  system($str1);
system("/bin/cat /tmp/out1$pid /tmp/out2$pid | /bin/sed '/^\$/d' |/usr/bin/sort |/usr/bin/sort -u >/tmp/final$pid ;/bin/cat /tmp/final$pid");
system("rm /tmp/out1$pid /tmp/out2$pid /tmp/final$pid");
