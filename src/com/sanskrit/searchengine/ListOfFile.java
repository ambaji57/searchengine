/**
 * 
 */
package com.sanskrit.searchengine;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.FileInputStream;
import java.io.Reader;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.w3c.dom.NodeList;
import java.util.Map;
import java.util.HashMap;

/**
 * @author karunakar
 *
 */
public class ListOfFile {

	/**
	 * @param args
	 */
	DocumentBuilderFactory factory;
	DocumentBuilder builder;
	StringBuilder output = new StringBuilder();
	Map<String,String> datamap  = new HashMap<String,String>();
	public Map<String,String> getListOfFile(){
		//StringBuilder build = new StringBuilder();
		factory = DocumentBuilderFactory.newInstance();
		String[] desfiles = {"/var/lib/tomcat6/webapps/searchengine1/tmp","/var/lib/tomcat6/webapps/searchengine/tmp"};
		for(String desfile : desfiles){
			File[] filenames = new File(desfile).listFiles();
			for(File filename : filenames){
				if(filename.toString().endsWith(".xml") && !filename.toString().contains("counter.xml")){
					displayWord(filename);
				}
			}
		}
	//return build.toString();
	return datamap;
	}
	
	public void displayWord(File file){
		try{
			output = (new StringBuilder()).append(output.toString());
			builder = factory.newDocumentBuilder();
			InputStream inputStream= new FileInputStream(file);
	   	      	Reader reader = new InputStreamReader(inputStream,"UTF-8");
   		        InputSource is = new InputSource(reader);
			Document doc = builder.parse(is);
			doc.getDocumentElement().normalize();
			NodeList searchwords = doc.getElementsByTagName("searchword");
			NodeList encodings = doc.getElementsByTagName("Encoding");
			for(int i=0; i<searchwords.getLength();i++){
				if(datamap.get(searchwords.item(i).getTextContent()) == null){
					datamap.put(searchwords.item(i).getTextContent(),encodings.item(i).getTextContent());
				}
//				output = (new StringBuilder()).append(output.toString()).append("<tr><td>"+searchwords.item(i).getTextContent()+"</td>");
//				output.append("<td>"+encodings.item(i).getTextContent()+"</td></tr>");
			}
		}
		catch(ParserConfigurationException e){
			e.printStackTrace();
		}
		catch(SAXException e){
			e.printStackTrace();
		}
		catch(IOException e){
			e.printStackTrace();
		}
//	return output.toString();
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
			
			System.out.println(new ListOfFile().getListOfFile());
	}

}

