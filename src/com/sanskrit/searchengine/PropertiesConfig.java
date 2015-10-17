/**
 * 
 */
package com.sanskrit.searchengine;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @author Medamoni_Karunakar(kannaiah.chinni@gmail.com)
 *
 */
public class PropertiesConfig {
	private Properties prop ;
	
	public PropertiesConfig(){
		try {
			prop = new Properties();
			InputStream in = getClass().getResourceAsStream("/config.properties");
			prop.load(in);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public Properties getProperties(){
		return prop;
	}
	
	public static void main(String... args){
		new PropertiesConfig().getProperties();
	}

}
