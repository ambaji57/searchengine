<%@ page import="java.io.*,java.util.*,javax.xml.parsers.*, javax.xml.transform.*, javax.xml.transform.dom.*, javax.xml.transform.stream.*,org.w3c.dom.*;"%>
<%
		try{
		int count=0;
		File f;
			String rootpath = config.getServletContext().getRealPath("/"); 
			//out.println(rootpath);
 		 f=new File(rootpath+"tmp/counter.xml");
		  if(!f.exists()){
		  f.createNewFile();
			FileWriter fstream = new FileWriter(f);
 			 BufferedWriter outf = new BufferedWriter(fstream);
		 outf.write("<counter></counter>");
 			 outf.close();
			count=1;
  		}
		else { count=1;}
		if(count ==1 ) {
			DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = builderFactory.newDocumentBuilder(); 
			DocumentBuilderFactory fact = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = fact.newDocumentBuilder();
			Document doc = docBuilder.newDocument(); 
			doc = docBuilder.parse(f);
			 Element root = doc.getDocumentElement();
			String sr = root.getNodeName(); 
			Element details = doc.createElement("IpAddress");
			details.appendChild(doc.createTextNode(request.getRemoteAddr()));
			root.appendChild(details);
			 Element time = doc.createElement("Time");
                        time.appendChild(doc.createTextNode(new java.util.Date().toString()));
                        root.appendChild(time);
			TransformerFactory factory = TransformerFactory.newInstance();
			  Transformer transformer = factory.newTransformer();

  transformer.setOutputProperty(OutputKeys.INDENT, "yes");
  transformer.setOutputProperty(OutputKeys.METHOD,"xml");
  // transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "3");


  // create string from xml tree
  StringWriter sw = new StringWriter();
  StreamResult result = new StreamResult(sw);
  DOMSource source = new DOMSource(doc);
  transformer.transform(source, result);

  String xmlString = sw.toString();


//  File file = new File("./war/ds/newxml.xml");
BufferedWriter  bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f)));
  bw.write(xmlString);


  bw.flush();
  bw.close();


		
		}}
		catch(Exception e){
			out.println(e);
		}

%>
