package com.sanskrit.searchengine;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.lang.String;
import java.util.*;
import java.io.*;
import com.sanskrit.searchengine.*;
public class Grep {
	//private String pattern; 
	public static void main(String[] args) {
		Grep ws = new Grep();
//		QueryConverter qcon = new QueryConverter();
//		Scanner scan = new Scanner(System.in);
//		System.out.println("Enter any word");
//		String inpu = scan.nextLine();	
//		System.out.println(inpu);
		//System.out.println(ws.grep("files_new/WX/Gretil/2_epic/ramayana/ram_03au.html"," rAma rAmAByAm rAmAByAM rAmaH rAmAH rAmam rAmaM rAmAn rAmANAm rAmANAM rAmasya rAmAw/rAmAx rAmAya rAmayoH rAme rAmeByaH rAmEH rAmeNa rAmeRu rAmO").replaceAll(" "," "));//		i
//		System.out.println(ws.grep("Sktlib/mbh18_page5.html","BArawa BArawAByAm BArawAByAM BArawaH BArawAH BArawam BArawaM BArawAn BArawAnAm BArawAnAM BArawasya BArawAw BArawAya BArawayoH BArawe BAraweByaH BArawEH BArawena BAraweRu BArawO"));//		i
//System.out.println(ws.grep("Gretil/4_rellit/vaisn/dhyggs_u.html",inpu.trim()));
	}

	public String grep(String url,String input) {
		String filepath = "/home/sanskrit/karunakara/searchengine-desktop1/";
		String fileurl = filepath+url;
		//System.out.println(fileurl);
		String line="", line1="",word1="",out="";
		if(input.contains("\"")){
			input=input.replaceAll("\"","").replaceAll(" ","SPACE");
		}
		LineNumberReader lReader;
		
		int count=0;
		try {
			StringTokenizer stk= new StringTokenizer(input," ");
			while(stk.hasMoreTokens()){
				String word=stk.nextToken();
				if(word.contains("SPACE")){
                                       word=word.replace("SPACE"," ");
//					System.out.println("kannaiahchinni"+word);
                                }
				String[] commands = new String[]{"grep","-w3", word, fileurl};

                                commands = new String[]{"grep","-w3",word, fileurl};
                                  Process child = Runtime.getRuntime().exec(commands);

				BufferedReader br = new BufferedReader(new InputStreamReader(child.getInputStream()));
				while((line=br.readLine())!=null){
						line1=line;
						out+= addSpanTag(line1,word)+"<@br/>";
				}
			}
		}
		catch(Exception e){
			System.out.println(e);
		}
	return out; 
}
	public String addSpanTag(String sample,String inputData){
			if(inputData.contains("SPACE")){
				inputData=inputData.replace("SPACE","[\\W]+");
			}
			Pattern pattern= Pattern.compile(inputData);
			Matcher matcher= pattern.matcher(sample);
			if(matcher.find()){
			String tmp=sample.substring(matcher.start(),matcher.end());
			Pattern p1 = Pattern.compile("\\b"+tmp+"\\b");
                        Matcher m1 = p1.matcher(sample);
			tmp="<@span @style=\"@background:@yellow;\">"+tmp+"</@span>";
                        sample = m1.replaceAll(tmp);
			}
			if(sample != ""){
	//			sample = qcon.convertAny2UTF8(sample.replaceAll("[ \t]","_"),"Devanagari");
			}
		return sample;
	}	
}
