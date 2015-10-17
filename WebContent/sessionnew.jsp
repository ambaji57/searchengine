<%@ page import="java.io.*,java.util.*,javax.xml.parsers.*, javax.xml.transform.*, javax.xml.transform.dom.*, javax.xml.transform.stream.*,org.w3c.dom.*;"%>
<%
   // Get session creation time.
   Date createTime = new Date(session.getCreationTime());
	String Ctime= createTime.toString();
   // Get last access time of this web page.
   Date lastAccessTime = new Date(session.getLastAccessedTime());
	String Ltime= lastAccessTime.toString();


   // Check if this is new comer on your web page.
   if (session.isNew()){
//		out.println(session.getId());
   } 
%>
<%		try{
		int count=0;
		File f;
			DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = builderFactory.newDocumentBuilder(); 
			DocumentBuilderFactory fact = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = fact.newDocumentBuilder();
			Document doc = docBuilder.newDocument(); 
			//out.println(config.getServletContext().getRealPath("/"));
 		 f=new File(config.getServletContext().getRealPath("/")+"tmp/"+session.getId()+".xml");
		  if(!f.exists()){
		  f.createNewFile();
			//out.println(session.getId());
			FileWriter fstream = new FileWriter(f);
 			 BufferedWriter outf = new BufferedWriter(fstream);
		 outf.write("<info><CreationTime>"+Ctime+"</CreationTime></info>");
 			 outf.close();
			count=1;
  		}
		else { count=1; }

		if(count ==1) {
			doc = docBuilder.parse(f);
			 Element root = doc.getDocumentElement();
			String sr = root.getNodeName(); 
			Element details = doc.createElement("details");
			root.appendChild(details);
			Element name = doc.createElement("searchword");
			//name.appendChild(doc.createTextNode(request.getParameter("index_text")));
			name.appendChild(doc.createTextNode(request.getParameter("query")));
 			details.appendChild(name);
			if(request.getParameter("morph")!= null){
			Element prati = doc.createElement("prawipaxikam");
			prati.appendChild(doc.createTextNode(request.getParameter("morph")));
			details.appendChild(prati);
			}
			if(request.getParameter("encoding") != null){
			Element script = doc.createElement("Encoding");
			script.appendChild(doc.createTextNode(request.getParameter("encoding")));
			details.appendChild(script);
			}
			if(request.getParameter("pada") != null){
				Element pada = doc.createElement("Pada");
				pada.appendChild(doc.createTextNode(request.getParameter("pada")));
				details.appendChild(pada);
			}
			Element lastAccTime = doc.createElement("LastAccessTime");
                        lastAccTime.appendChild(doc.createTextNode(Ltime));
                        details.appendChild(lastAccTime);
			

			//out.println(sr);
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
