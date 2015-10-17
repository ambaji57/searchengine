#! /usr/bin/perl
$pid= $$;
$data=$ARGV[0];
open(TMP,">/tmp/input$pid") || "die cant open that file";
print  TMP $data;
close(TMP);
if($data=~/,and,/ || $data=~/,AND,/ || $data=~/,And,/){
	system("/usr/bin/perl -i -p -e \"s#,and,# #g;\" /tmp/input$pid");
	system("/usr/bin/perl -i -p -e \"s#,AND,# #g;\" /tmp/input$pid");
	system("/usr/bin/perl -i -p -e \"s#,And,# #g;\" /tmp/input$pid");
	&func();
	system("/usr/bin/perl -i -p -e \"s# # and #g;\" /tmp/input$pid");
	system("/usr/bin/perl -i -p -e \"s# #,#g;\" /tmp/input$pid");
}
if($data=~/,or,/ || $data=~/,OR,/ || $data=~/,Or,/){
        system("/usr/bin/perl -i -p -e \"s#,or,# #g;\" /tmp/input$pid");
        system("/usr/bin/perl -i -p -e \"s#,OR,# #g;\" /tmp/input$pid");
        system("/usr/bin/perl -i -p -e \"s#,Or,# #g;\" /tmp/input$pid");
        &func();
        system("/usr/bin/perl -i -p -e \"s# # or #g;\" /tmp/input$pid");
        system("/usr/bin/perl -i -p -e \"s# #,#g;\" /tmp/input$pid");
}
else{
        &func();
}
sub func(){
system("/usr/bin/perl -i -p -e \"s#,# #g;\" /tmp/input$pid");
system("/bin/cat /tmp/input$pid | /bin/sed -e '1,\$ s/ /\\n/g' >/tmp/in1$pid");
system("/usr/bin/sort /tmp/in1$pid | /usr/bin/sort -u > /tmp/input$pid");
system("/usr/bin/perl -i -p -e \"s#\n# #g;\" /tmp/input$pid");
system("/usr/bin/perl -i -p -e \"s# \\\$##g;\" /tmp/input$pid");
}
system("/bin/cat /tmp/input$pid");
system("rm -rf /tmp/input$pid /tmp/in1$pid");
