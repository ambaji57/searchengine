package com.sanskrit.searchengine;

import java.io.BufferedReader;
import java.io.InputStreamReader;
/**
 * @author karunakar(kannaiah.chinni@gmail.com)
convert user query into wx-notation and utf8 notation
 *
 */


public class QueryConverter{

	String utf8query; // storing utf8 query
	String wxquery; //storing wx notation query
	String query; // storing actual query
	Runtime rtime;
	String nquery;
	String dquery;
	String finalwxquery;
	String finalutfquery;
	String rootPath = ""; 
	String program  = null;

	public QueryConverter(){

	}
	public QueryConverter(String query,String encode,String path){
	
		this.query = query;
		this.rootPath = path;
		System.out.println(path);
		this.program =  "/usr/bin/perl "+rootPath+"/WEB-INF/classes/com/sanskrit/searchengine/convert.pl "+rootPath;
		
				if(encode.equals("Wx-notation")){ 
					wxquery = formatQuery(query);
				}
				else{
					query = formatQuery(query);
					wxquery = convertAny2Wx(query,encode);
				}
				if(encode.equals("Unicode")){
					utf8query = query;
				}
				else{
					utf8query = convertAny2UTF8(wxquery,"Devanagari");
				}
				if(!wxquery.contains("SPACE")){ 
//|| !wxquery.contains("*") || !wxquery.contains("?")){	
					nquery = normalizeQuery(wxquery);
					dquery = denormalizeQuery(nquery);
					finalwxquery = sortQuery(nquery+","+dquery);
					finalwxquery = finalwxquery.replaceAll(" ",",");
					finalutfquery = convertAny2UTF8(finalwxquery,"Devanagari");
				
					//replaceing , with space and @ with nothing
					finalwxquery = finalwxquery.replaceAll("(@|,SPACE,|SPACE)","");
					finalwxquery = finalwxquery.replaceAll(","," ");
					finalwxquery = finalwxquery.replaceAll("@","");
					finalutfquery = finalutfquery.replaceAll(","," ");
					finalutfquery = finalutfquery.replaceAll("@","");
					finalutfquery = finalutfquery.replaceAll("SPACE","");
					
					
				}
				else{
					finalwxquery = wxquery.replaceAll("(@|,SPACE,|SPACE)","");
					finalwxquery = finalwxquery.replaceAll("(,SPACE,|,,)"," ");
					finalutfquery = utf8query.replaceAll("@","");
					finalutfquery = finalutfquery.replaceAll(",SPACE,"," ");
				}
				
				
	}

	public String convertAny2Wx(String cquery,String encode){
		return runPerlProgram(program+" "+cquery+" "+encode);
	}

	public String convertAny2UTF8(String cquery,String encode){
		return runPerlProgram(program+" "+cquery+" "+encode);
	}
	public String getWxQuery(){
		return wxquery;
	}
	public String getUTF8Query(){
		return utf8query;
	}
	public String getFinalWxQuery(){
		return finalwxquery;
	}
	public String getFinalUTF8Query(){
		return finalutfquery;
	}
	public String getNQuery(){
		return nquery;
	}
	public String getDQuery(){
		return dquery;
	}

	//executing perl programs using Runtime and Process class

	public  String runPerlProgram(String cmdname){
		String result,convertedtext="";
		try{
			rtime = Runtime.getRuntime();
			Process pr = rtime.exec(cmdname);
			BufferedReader breader = new BufferedReader(new InputStreamReader(pr.getInputStream()));
			while((result = breader.readLine())!= null){
				convertedtext = result;
			}
		}
		catch(Exception e){ System.out.println(e);
		}
	return convertedtext;
	}

	public String formatQuery(String query){
		String querystring = query;

		if(querystring.contains(" ") && (!querystring.contains("and"))&& (!querystring.contains("AND"))&& (!querystring.contains("And"))&& (!querystring.contains("or"))&& (!querystring.contains("OR"))&& (!querystring.contains("Or")) && (!querystring.contains("+"))  ){
               		 querystring=querystring.replace(" ",",@SPACE,");
        	}
		else {
			querystring = querystring.replaceAll("or","@or");
			querystring = querystring.replaceAll("Or","@Or");
			querystring = querystring.replaceAll("and","@and");
			querystring = querystring.replaceAll("OR","@OR");
			querystring = querystring.replaceAll("And","@And");
			querystring = querystring.replaceAll("AND","@AND");
			querystring = querystring.replace(" ",",");
		}
		return querystring;	
	}

	//normalizing denormalizing usery input query

	// converting aMga to afga

	public String  normalizeQuery(String query){
			String cmd = "/usr/bin/perl "+rootPath+"/WEB-INF/classes/com/sanskrit/searchengine/normalize.pl "+ rootPath+" "+query;
			return runPerlProgram(cmd);
	}
	
	// converting afga to aMga

	public String denormalizeQuery(String query){
			String cmd1 ="/usr/bin/perl "+rootPath+"/WEB-INF/classes/com/sanskrit/searchengine/normalize1.pl "+rootPath+" "+query;

	return runPerlProgram(cmd1);		
	}
	public String sortQuery(String query){
		String cmd ="/usr/bin/perl "+rootPath+"/WEB-INF/classes/com/sanskrit/searchengine/sortstring.pl "+ rootPath+" "+query;
		return runPerlProgram(cmd);
	}
	
	public static void main(String[] args){
	String data = "रामः";
//		String data = "afga and gacCawi";
		QueryConverter qconverter = new QueryConverter(data,"Unicode","/home/praveen/karunakar/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/searchengine/");
		System.out.println(qconverter.getWxQuery());
		System.out.println(qconverter.getUTF8Query());
		System.out.println("noramlized "+qconverter.getNQuery());
		System.out.println("denoarmalized"+qconverter.getDQuery());
		System.out.println("noarmalized final wx query"+qconverter.getFinalWxQuery());
		System.out.println("noarmalized final utf query"+qconverter.getFinalUTF8Query());

	}



}
