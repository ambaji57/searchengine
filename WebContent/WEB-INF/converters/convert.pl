sub convert{
        my($encoding,$pid,$word) = @_;

	open(TMP,">/tmp/wor.$pid") || die "Can't open /tmp/wor.$pid for writing";
        print TMP $word,"\n";
        close(TMP);

            if($encoding eq "Unicode") 
	    {
              system("/var/lib/tomcat6/webapps/searchengine1/WEB-INF/classes/searchengine/converters/utf82iscii.pl < /tmp/wor.$pid > /tmp/word.$pid");
              system("/var/lib/tomcat6/webapps/searchengine1/WEB-INF/classes/searchengine/converters/ir_skt < /tmp/word.$pid >/tmp/word1.$pid");
           } 
            open(TMP,"</tmp/word1.$pid") || die "Can't open word1.$pid for reading; exiting";
            $word = <TMP>;
            close(TMP);
            system ("rm /tmp/wor.$pid /tmp/word.$pid /tmp/word1.$pid");
         
return $word; 
}
1;
