package com.sanskrit.searchengine;
import java.io.*;
import java.lang.*;
/**
 * @author karunakar(kannaiah.chinni@gmail.com)
 *
 */
public class MorphGen {

	public String morphgendata;
	public String originalString;
	public static String message = "";
	/*constructor for Handling Moph info or Gen info, 
		# its takes three arguments arg3 represents Morph/verb

	*/
	public MorphGen(String arg1,String arg2,String arg3,String path){
		
		String program;	
		originalString = arg1;
		System.out.println(arg1+" "+ arg2+" "+arg3+" "+ path);
	
		if(arg3.equals("Morph")){
			program = "/usr/bin/perl "+path+"/WEB-INF/classes/com/sanskrit/searchengine/pr1.pl "+path+" "+arg1+" "+arg2;
		}
		else{
			program = "/usr/bin/perl "+path+"/WEB-INF/classes/com/sanskrit/searchengine/gen_verb1.pl "+path+" "+arg1+" "+arg2;
		}
		
		//executing perl programs
		morphgendata = runPerlProgram(program).replaceAll("\t"," ").replaceAll("\\*","");
		if(morphgendata == null){ morphgendata = arg1;}
		
	}	




	public String runPerlProgram(String cmd) {
	
		String morphdata = "", result;	
		try{
			Runtime r=Runtime.getRuntime();
			Process pr=r.exec(cmd);
			BufferedReader br = new BufferedReader(new InputStreamReader(pr.getInputStream()));
			while((result=br.readLine())!=null){
				morphdata=morphdata+" "+result;
				message = "";
			}
			if((morphdata.indexOf("?"))!=-1 || (morphdata.indexOf("*") != -1)) {
				morphdata = originalString;
				message = "(This प्रातिपदिकम् does not exists in the Database)";
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		finally{
		// return	morphdata = originalString;
		}
	return morphdata;
	}

	public String getMorphGenData(){
		System.out.println(morphgendata);
		return morphgendata;
	}

	public static void main(String[] arg) {
		MorphGen f;
		if(arg[0].equals("Morph")){
				 f= new MorphGen("rAma","swrI",arg[0],"asdfasd");
		}
		else {
				 f= new MorphGen("अक्ष्1_अक्षूँ_भ्वादिः व्याप्तौ","कर्तरि",arg[0],"adfad");
		}
		
		

//		System.out.println("result "+f.getMorphGenData());

		//calling query converter

		QueryConverter qc = new QueryConverter(f.getMorphGenData(),"Wx-notation","adadsa");
		System.out.println(f.getMorphGenData()+","+MorphGen.message);
		System.out.println(qc.getFinalUTF8Query());

	}
}
