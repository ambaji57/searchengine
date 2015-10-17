package com.sanskrit.searchengine;
import java.io.*;
import java.lang.*;
import java.util.*;

public class PerlConvert {
	
	String path = "/var/lib/tomcat6/webapps";

public String convert(String data,String data1){
	String sampledata="",result="";
//	System.out.println(data);
	System.out.println(data1);
	try {
	Runtime r= Runtime.getRuntime();
	String cmd="/usr/bin/perl "+path+"/searchengine/WEB-INF/classes/com/sanskrit/searchengine/convert.pl  "+data+" "+data1;
	Process pr=r.exec(cmd);
                BufferedReader br = new BufferedReader(new InputStreamReader(pr.getInputStream()));
                while((result=br.readLine())!=null){
                sampledata=result;
                }

	}
	catch (Exception e) {

	}
		return sampledata;
}
public static void main(String[] arg) {

	PerlConvert p= new PerlConvert();
	System.out.println(p.convert(arg[0],arg[1]));


}
}
