#! /usr/bin/perl
$pid= $$;
$data=$ARGV[1];

$path =$ARGV[0];
open(TMP,">/tmp/input$pid") || "die cant open that file";
print  TMP $data;
	$cmd="/usr/bin/perl  $path/WEB-INF/classes/com/sanskrit/searchengine/get_std_spelling.pl";

$cmd1=" cat /tmp/input$pid | $cmd";
system($cmd1);
system("rm -rf /tmp/input$pid");
close(TMP);
