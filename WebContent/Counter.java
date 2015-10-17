/**
 * 
 */
//package com.karunakar.collection.examples;

import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.net.InetAddress;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;



/**
 * @author karunakar
 *
 */
public class Counter {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		 DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
         DocumentBuilder docBuilder;
		try {
			docBuilder = docBuilderFactory.newDocumentBuilder();
			Document doc = docBuilder.parse (new File("/var/lib/tomcat6/webapps/searchengine/tmp/counter.xml"));
			Document doc1 = docBuilder.parse (new File("/var/lib/tomcat6/webapps/searchengine1/tmp/counter.xml"));
			Document doc2 = docBuilder.parse (new File("/var/lib/tomcat6/webapps/searchengine/counter.xml"));
			doc.getDocumentElement ().normalize ();
			doc1.getDocumentElement ().normalize ();
			doc2.getDocumentElement ().normalize ();


	         NodeList listOfPersons = doc.getElementsByTagName("IpAddress");
		 NodeList listOfTags = doc1.getElementsByTagName("IpAddress");
		 NodeList listOfTags1 = doc2.getElementsByTagName("IpAddress");
		System.out.println(listOfPersons.getLength()+listOfTags.getLength()+listOfTags1.getLength());
	        /* for(int i =0;i<listOfPersons.getLength();i++){
			InetAddress addr = InetAddress.getByName(listOfPersons.item(i).getTextContent());
	        	 System.out.println(addr.getHostName());
	         }*/

		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch(Exception e){
			e.printStackTrace();
		}
         
         // normalize text representation
         
         



	}

}

