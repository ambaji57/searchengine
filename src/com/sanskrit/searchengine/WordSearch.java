/**
 * 
 */
package com.sanskrit.searchengine;

/**
 * @author karunakar(kannaiah.chinni@gmail.com)
	Getting sample data and add span tag to text for display;
	gerpText method run the grep command and get lines which has contains exact word.
 *
 */

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.lang.String;
import java.util.*;


public class WordSearch {
	private String pattern;
	public QueryConverter qconverter = new QueryConverter();
	public String filepath;// = "/home/sanskrit/karunakara/searchengine-desktop1/";
	private Properties prop;
	public static void main(String[] args) throws IOException {
		WordSearch ws = new WordSearch();
				System.out.println(ws.grepText("files_new/WX/Sktlib/mbh18_page5.html","BArawa BArawAByAm BArawAByAM BArawaH BArawAH BArawam BArawaM BArawAn BArawAnAm BArawAnAM BArawasya BArawAw BArawAya BArawayoH BArawe BAraweByaH BArawEH BArawena BAraweRu BArawO"));
	}
	
	public WordSearch(){
		prop = new PropertiesConfig().getProperties();
		filepath = prop.getProperty("searchengine.indexpath");
	}

	public String grepText(String url,String input) throws IOException{
			String filedata = "";
			String input1 = input;
			if(input.contains("\"")){	
				input = input.replaceAll("\"","");
				//	System.out.println("input value to grepText"+input);
			}
			else{
				input = input.replaceAll("\\*", "[a-zA-Z]\\*").replaceAll("\\?","[a-zA-Z]").replaceAll("(and|And|AND|or|Or|OR| )","|").replaceAll("SPACE"," ").replaceAll("\"","");
			}
			//System.out.println(input);
			String cmd = "grep -P -w3 "+input+" "+filepath+url;
			Process pr = Runtime.getRuntime().exec(cmd);
			BufferedReader breader = new BufferedReader(new InputStreamReader(pr.getInputStream()));
			String line;
			while((line = breader.readLine())!= null){
				
				filedata += "@NEWLINE_"+addSpanTag(line, input1);
				//System.exit(0);
			}

		return filedata;
	}
	
	
	
	public String addSpanTag(String sample,String inputData){
	
			int count = 0;
		if(inputData.contains("\"")){
			inputData=inputData.replace(" ","[\\W]+").replaceAll("\"",""); count = 1;
		}
		else {
			inputData = inputData.replaceAll("\\*", "[a-zA-Z]\\*").replaceAll("\\?","[a-zA-Z]").replaceAll("(and|And|AND|or|Or|OR| )"," | ").replaceAll("SPACE"," ").replaceAll("\"","");

		}
		//	System.out.println(inputData);
		if(count == 1){
			
			Pattern pattern= Pattern.compile("\\b"+inputData+"\\b");
			Matcher matcher= pattern.matcher(sample);
			if(matcher.find()){
				String tmp=sample.substring(matcher.start(),matcher.end());
				//		Pattern p1 = Pattern.compile("\\b"+tmp+"\\b");
               		//	Matcher m1 = p1.matcher(sample);
				String tmp1="<@span @style=\"@background:@yellow;\">"+tmp+"</@span>";
                		sample = sample.replaceAll("\\b"+tmp+"\\b",tmp1);
                		//System.out.println("adsfasdf"+sample);
			}
		}
		else{
		StringTokenizer stk = new StringTokenizer(inputData.replaceAll("\\|",""));
		while(stk.hasMoreTokens()){
				
			Pattern pattern= Pattern.compile("\\b"+stk.nextToken().trim()+"\\b");
			Matcher matcher= pattern.matcher(sample);
			if(matcher.find()){
				String tmp=sample.substring(matcher.start(),matcher.end());
				//		Pattern p1 = Pattern.compile("\\b"+tmp+"\\b");
               		//	Matcher m1 = p1.matcher(sample);
				String tmp1="<@span @style=\"@background:@yellow;\">"+tmp+"</@span>";
                		sample = sample.replaceAll("\\b"+tmp+"\\b",tmp1);
                		//System.out.println("adsfasdf"+sample);
			}
			
		}
		}
	return sample.replaceAll("\\*","_");
}	
	
	public String search(String url,String input) {
		String urldata = input;
		input = input.trim();	
		File fileurl = new File(filepath+url.trim());
		String[] names = url.split("/");
		if(input.contains("\"") && !input.contains("and") && !input.contains("And") && !input.contains("AND") && !input.contains("or") && !input.contains("Or") && !input.contains("OR")){
			input = input.replaceAll("([ ]+)","SPACE");
	//		input = input.replaceAll(" ","SPACE");
			input = input.replaceAll("\"","");
		}
		//urldata = input;
		if(input.contains("+")){
			String tmp = "";
              		 String[] str1=input.split(" ");
              		 for(int ind=0;ind<str1.length;ind++){
                       		 if(str1[ind].contains("+")){
                               		 tmp += str1[ind];
                       		 }
               		 }
               		 tmp=tmp.replaceFirst("\\+","");
               		 tmp=tmp.replace("+"," ");
			input = tmp;
		}
		
		LineNumberReader lReader;
			String output = "";
		try {
					lReader = new LineNumberReader(new FileReader(fileurl));
					String data = "";
					int count = 0;
					int occurrance = 0;
					int firstOccurranceLnNo = 0;
					output = "";
			
					while ((data = lReader.readLine()) != null) {
			    	        data=data.replaceAll("_"," _ ");
			    	        StringTokenizer stk= new StringTokenizer(input.toString());
			    	        while(stk.hasMoreTokens()) {
                        	        String sword=stk.nextToken();
                        	        if(sword.contains("SPACE")){
                        	      	        sword=sword.replace("SPACE","[\\W]+");
                        	        }
                        	        if(!sword.equals("and") && !sword.equals("AND") && !sword.equals("or") && !sword.equals("OR") && !sword.equals("And") && !sword.equals("Or") ) {
                        	        	String cinput = sword.replaceAll("\\*", "[a-zA-Z]*").replaceAll("\\?","[a-zA-Z]");
                        	        	pattern = "\\b" + cinput + "\\b|^"+ cinput + "\\b";		
                        	        	count+=findCount(data);
				
                        	        	if(occurrance == 0 && count > 0 ){
                        	        		Pattern p = Pattern.compile(pattern);
                        	        		Matcher m = p.matcher(data);
                        	        		if(m.find()){
                        	        			String temp = data.substring(m.start(), m.end());
                        	        			data = data.replaceAll("(<)+","<");
                        	        			data = data.replaceAll("(>)+",">");
                        	        			temp = temp.replaceAll("\\+","\\\\+");
                        	        			Pattern p1 = Pattern.compile("\\b"+temp+"\\b");
	                                            Matcher m1 = p1.matcher(data);
	                                            temp = "<@span @style=\"@background:@yellow\">"+temp+"</@span>";	
	                                            data = m1.replaceAll(temp);
	                                            firstOccurranceLnNo = lReader.getLineNumber();
	                                            output = output+data;
                        	        		}
                        	        		occurrance++;
                        	        	}
                        	        }
			    	        }
			    	        if(firstOccurranceLnNo > 0){
			    	        	break;
			    	        }
				
					}
					if(count==0){
					}
					else{
						//output = output.replaceAll("\t"," ").replaceAll(" ","_").replaceAll("\\*","");
						return qconverter.convertAny2UTF8(output.replaceAll("\t"," ").replaceAll(" ","_").replaceAll("\\*",""),"Devanagari").replaceAll("_"," ")+"<br/><span style=\"color:#489CDF;\"/><a href=\"result.jsp?filename="+url+"&query="+urldata.replaceAll("\"","&quot;")+"\">"+names[names.length-1]+"</a></span>";
						//return output+"<< Total Occurrences : "+count+">>";
					}			
			} catch (IOException e) {
			// TODO Auto-generated catch block
				output = e.toString();
			}
		
		return output;
		
	}
	
	public int findCount(String s){
		Pattern p = Pattern.compile(pattern);
		Matcher m = p.matcher(s);
		int c = 0;
		while (m.find()) {
			c++;
	//	System.out.println("h"+s.substring(m.start(), m.end())+"h");
		}
		
		return c;
	}
}
