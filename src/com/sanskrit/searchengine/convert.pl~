#! /usr/bin/perl
$pid= $$;
#$path="/var/lib/tomcat6/webapps";
open(TMP,">/tmp/input$pid") || "die cant open that file";
for($i=1;$i<$#ARGV;$i++){
	print  TMP "$ARGV[$i] ";
}
$path=$ARGV[0];
$notation=$ARGV[$#ARGV];
if($notation eq "Unicode") {
	$cmd=" /bin/sh $path/WEB-INF/converters/utf82wx.sh";
}
elsif($notation eq "Itrans") {
	$cmd=" $path/WEB-INF/converters/itrans_ra.out | $path/searchengine/WEB-INF/converters/rm__between_vowels.out";
}
elsif($notation eq "SLP"){
	$cmd="/usr/bin/perl  $path/WEB-INF/converters/slp2wx.pl";


}
elsif($notation eq "Roman"){
	$cmd=" $path/WEB-INF/converters/utf8roman2wx.pl";

}
elsif($notation eq "Devanagari"){
	$cmd="/bin/sh  $path/searchengine/WEB-INF/converters/wx2utf8.sh";

}
elsif($notation eq "Velthuis"){
	$cmd="/usr/bin/perl  $path/searchengine/WEB-INF/converters/velthuis-wx.pl";

}


$cmd1="/bin/cat /tmp/input$pid | $cmd";
system($cmd1);
#system("rm -rf /tmp/input$pid");
close(TMP);
