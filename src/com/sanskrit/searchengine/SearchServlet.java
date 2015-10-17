/**
 * 
 */
package com.sanskrit.searchengine;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.logging. Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * @author karunakar(kannaiah.chinni@gmail.com)
 *
 */
public class SearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	Logger logger = Logger.getLogger("SearchServelt.java");
	 String rootPath;
	//handling request from page using get method
	protected void doGet(HttpServletRequest request , HttpServletResponse response) throws UnsupportedEncodingException{
		try {
			doSearchProcess(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//handling requests from page using post method
	protected void doPost(HttpServletRequest request , HttpServletResponse response) throws UnsupportedEncodingException{
		try {
			doSearchProcess(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// search query in index.
	protected void doSearchProcess(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, Exception {
		
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		rootPath = request.getRealPath("/");
		
		HttpSession session = request.getSession(true);
		
		//getting parameter values alogn with url
		
		String userquery = request.getParameter("query");
		String pagenumber = request.getParameter("pagenumber");
		String source = request.getParameter("source");
		String morph = request.getParameter("morph");
		String verb = request.getParameter("verb");
		String pada = request.getParameter("pada");
		String list = request.getParameter("list");
		String vb = request.getParameter("vb");
		String prayoga = request.getParameter("prayoga");
		String st = request.getParameter("start");
		String encoding = request.getParameter("encoding");
		PrintWriter out = response.getWriter();
		String errorMessage = "";
		//replacing continous spaces in querystring
		String regex = "([ ]+)";
		userquery = userquery.replaceAll(regex," ");	
		int page_num = 1;
		int start = 0;
		//comparing start value
		if(st != null){
			 start = Integer.parseInt(st);
			page_num = start+1;
		}
		SearchResult srchResult = (SearchResult) session.getAttribute("searchobject");
		QueryConverter qconverter = (QueryConverter) session.getAttribute("convertobject");
		MorphGen morphgen = (MorphGen) session.getAttribute("morphgenobject");
		if(!(srchResult!=null && pagenumber!=null)){
			logger.info("kannaiah executing here");

			//checking morph option is enabled or not
			if(morph == null && verb == null){
				logger.info("before Query Converter "+ userquery);
			 	qconverter = new QueryConverter(userquery,encoding,rootPath);
			
			}
			else if(morph != null){
			 	qconverter = new QueryConverter(userquery,encoding,rootPath);
			 	logger.info("Morph != null "+ qconverter.getNQuery());
				morphgen = new MorphGen(qconverter.getNQuery(),list,"Morph",rootPath);
				logger.info("Morph gen data "+ morphgen.getMorphGenData());
				     qconverter = new QueryConverter(morphgen.getMorphGenData(),"Wx-notation",rootPath);
				     errorMessage = MorphGen.message;
			}
			else if(verb != null){
				morphgen = new MorphGen(vb,prayoga,"verb",rootPath);
				qconverter = new QueryConverter(morphgen.getMorphGenData(),"Wx-notation",rootPath);
			}
			logger.info(" Final Wxquery "+qconverter.getFinalWxQuery());
			//getting result doucments from index , passing querystring in wx-notation and index name to SearchResult class constructor.
			 srchResult = new SearchResult(qconverter.getFinalWxQuery(),source);
			session.setAttribute("uquery",userquery);
			session.setAttribute("searchobject",srchResult);
			session.setAttribute("convertobject",qconverter);

		page_num = 1;
		}
		else{
		 page_num = Integer.parseInt(pagenumber);
		}
		ArrayList paths = srchResult.getFilePaths();
		out.println(paths);
		out.println("<html>");
       	 	out.println("<head>"+
		"<!-- Karunakar (kannaiah.chinni@gmail.com) -->");
        	out.println("<title>sanskrit Searchengine gavesika(गवेषिका)</title>");
        	out.println("<style type = 'text/css'>.url{color:green; font-size:12pt}" +
        		"body , html {margin:0;padding:0;}"+
				"#resultdiv a:visited{color:#F02311;}"+
				"#feedbackdiv {display:none;background:#fff;width:50%;}	textarea {width:100%;}		.close{top:-35px;margin-right:-10px;position:relative;color:#fff;float:right;font-size:30px;background:#333;border-radius:50px;cursor:pointer;padding:6px;}"+
				"#page"+page_num+"{color:red;background:red;padding:1px;border-radius:3px;} #num{font-size:15px;}"+	
				"</style>");
             out.println(" <script type=\"text/javascript\" src=\"js/jquery.tools.min.js\"></script> "+
             		" <script type=\"text/javascript\" src=\"js/validation.js\"></script> "+
			"<link rel=\"stylesheet\" href=\"css/style.css\"/>"+
        	" <script type=\"text/javascript\">"+
        		"$(document).ready(function(){"+
        		"$('#prayoga').val('"+prayoga+"');"+
        			"$('#list').val('"+list+"');");
        			if(source != null && !source.equals("null")){
        			out.println("$('#source').val('"+source+"');");
        			}
        			if(encoding != null && !encoding.equals("null")){
        			out.println("$('#encoding').val('"+encoding+"');");
        			}
        			if(vb != null && !vb.equals("null")){
        			out.println("$('#vb').val('"+vb+"');");
        			}
        			if(verb != null && !verb.equals("null")){
        				out.println("$('#verb').attr('checked',true);$(\"#XAwu\").show();$(\"#XAwu1\").show();$(\"#searchbox\").hide();$(\"#searchbox1\").hide();");
        			}
        			if(morph != null && !morph.equals("null")){
        				out.println("$('#morph').attr('checked',true);");
        				errorMessage = MorphGen.message;
        			}
        			if(pada != null && !pada.equals("null")){
        				out.println("$('#pada').attr('checked',true);");
        			}
        		out.println( "});"+
         		"function valid(str){"+
         			"var check = [\"morph\",\"verb\",\"pada\"];"+
         		"	for(var i = 0;i< check.length;i++){"+
         		"		if(str == check[i]){}"+
         		"		else{ $(\"#\"+check[i]+\"\").attr('checked',false);}}"+
         		"	if($(\"#verb\").is(':checked')){ $(\"#morph\").attr('checked',false);$(\"#pada\").attr('checked',false);$(\"#XAwu\").show();$(\"#XAwu1\").show();$(\"#searchbox\").hide();$(\"#searchbox1\").hide(); $('#query').val(\"\");}"+
				"	else{ $(\"#XAwu\").hide();$(\"#XAwu1\").hide();$(\"#searchbox\").show();$(\"#searchbox1\").show(); }		}"+
				"$(function(){"+
			"$(\"#feed\").click(function(){"+
                               " $(\"#feedbackdiv\").overlay().load();"+
                        "});"+
                                "$(\"#feedbackdiv\").overlay({top:100 ,mask: {color:'#999',loadSpeed:500,opacity:0.6},SendOnClick: false,});"+

		"});"+
				"</script>");
        	out.println("</head>");
        	out.println("<body>");
        	request.getRequestDispatcher("/header.jsp").include(request,response);
		request.getRequestDispatcher("/sessionnew.jsp").include(request,response);
        	out.println( "<div class=\"main\"><form method =\"get\" action= \"/searchengine/search.do\" onsubmit=\"return validation()\">");
        	out.println("<table>");
        	out.println("<tr>");
        	out.println("<td rowspan=\"2\">");
        	out.println("<label align=\"left\" width=\"100\" alt=\"logo\" style=\"font-size:40px;color:#B40404;\">Gaveṣikā</label></td>");
        	out.println("<td>Source&nbsp;&nbsp;<select id=\"source\" name=\"source\"><option value=\"gretil\">GRETIL</option><option value=\"mahbht\">Mahabharat-Bori</option><option value=\"oliver\">DCS</option><option value=\"sktlib\">Sanskrit Library</option><option value=\"uohyd\">UoHyd</option><option value=\"shmt\">SHMT</option><option value=\"sarit\">SARIT</option><option value=\"all\">All</option>");
        	out.println("<td> <input id=\"morph\" type=\"checkbox\" onclick=\"valid('morph');\" value=\"Morph\" name=\"morph\">प्रातिपदिकम् &nbsp;<select name=\"list\" id=\"list\"><option value=\"puM\">पुंलिङ्गम्</option><option value=\"swrI\">स्त्रीलिङ्गम्</option><option value=\"napuM\">नपुंसकलिङ्गम्</option><option value=\"a\">लिङ्त्रये</option></select>&nbsp;&nbsp;<input id=\"pada\" type=\"checkbox\" onclick=\"valid('pada');\" value=\"pada\" name=\"pada\">पदम् &nbsp;&nbsp;<input id=\"verb\" type=\"checkbox\" onclick=\"valid('verb');\" value=\"verb\" name=\"verb\">धातु: </td></tr>");
        	out.println("<tr><td id=\"searchbox\"><select name=\"encoding\" id=\"encoding\"><option value=\"Wx-notation\">WX-notation</option><option value=\"Unicode\">Unicode-Devanagari</option><option value=\"SLP\">SLP1</option><option value=\"Itrans\">Itrans</option><option value=\"Velthuis\">Velthuis</option><option value=\"Roman\">Unicode Roman Diacritic</option></select></td>");
		String querytext =(String)session.getAttribute("uquery");
         	out.println("<td id=\"searchbox1\"> <input value=\""+ querytext.replaceAll("\"","&quot;")+"\" type=\"text\" name= \"query\" size=\"40\" id=\"query\"></td>");
         	request.getRequestDispatcher("/option.jsp").include(request,response);
          	out.println("<td><input type=\"submit\" value=\"search\"></td></tr></table></form>");
         	out.println("</div>");
		if(errorMessage.equals("")){
		out.println("<div id=\"results\"><table><tr><td>");
         	out.println("<div id=\"totaldocs\">Total docs found &nbsp;&nbsp;"+srchResult.getTotalDocs()+"&nbsp;&nbsp;in &nbsp;"+srchResult.timeTaken()+"ms <span id=\"error\">"+errorMessage+"</span></div></td></tr>");
		int range;
		WordSearch wsearch = new WordSearch();
		if(srchResult.getTotalDocs() > 0){
			if(srchResult.getTotalDocs() > ((page_num-1)*10+10))
			{ range = 10;}
			else {range= (srchResult.getTotalDocs()-(page_num-1)*10);} 
			for(int i=(page_num-1)*10; i < (page_num-1)*10+range; i++){
				String filename = paths.get(i).toString().trim();
				//out.println("<tr><td>"+filename+"</td></tr>");
	
				out.println("<tr><td><div id=\"resultdiv\">"+wsearch.search(filename,qconverter.getFinalWxQuery())+"</div></td></tr>");
		
			}
			out.println("</table><center><div id=\"number\"><table><tr>");

			int total; int count;
			if(srchResult.getTotalDocs() > ((start+10)*10)){
				total = start+10; count = 1;
			 }
			else {
			total = srchResult.getTotalDocs()%10; count = 0;
			if(total > 10){total= total+10;}else{total =(srchResult.getTotalDocs()/10)+1;}
			
			}
//code for handling next and previous links

			if(start > 0){ out.println("<td><a href=\"search.do?query="+querytext.replaceAll("\"","&quot;")+"&start="+(start-10)+"&pagenumber="+(start-10+1)+"&vb="+vb+"&prayoga="+prayoga+"&encoding="+encoding+"&source="+source+"&list="+list+"&verb="+verb+"&morph="+morph+"&pada="+pada+"\"><span><</span></a></td>");
			}
			for(int i=start+1;i <= total; i++){
				out.println("<td id=\"page"+i+"\"><span><a id=\"page"+i+"\" href=\"search.do?query="+querytext.replaceAll("\"","&quot;")+"&pagenumber="+(i)+"&start="+start+"&vb="+vb+"&prayoga="+prayoga+"&encoding="+encoding+"&source="+source+"&list="+list+"&verb="+verb+"&morph="+morph+"&pada="+pada+"&id="+i+"\">"+i+"</span></a></td>");
		}
			if(count > 0){out.println("<td><a href=\"search.do?query="+querytext.replaceAll("\"","&quot;")+"&start="+(start+10)+"&pagenumber="+(start+10+1)+"&vb="+vb+"&prayoga="+prayoga+"&encoding="+encoding+"&source="+source+"&list="+list+"&verb="+verb+"&morph="+morph+"&pada="+pada+"\"><span>></span></a></td>");}
			out.println("</tr></table></div></div><br/><div id=\"lastinfo\"><center>Department of Sanskrit Studies, Univeristy of Hyderabad</center></div><br/><div id=\"feedbackdiv\"><label name=\"close\" value=\"close\" class=\"close\">X</label><center><p style=\"font-size:14px;\">Your feedback is important to us for improving the system further.You may alternately write to Amba Kulkarni (ambapradeep@gmail.com) or Karunakar (kannaiah.chinni@gmail.com).</p><table><tr><td>Feedback Text</td></tr><tr><td><textarea cols=\"60\" rows=\"10\" name=\"feedbacktxt\" value=\"\" Placeholder=\"Enter ur feedback\" id=\"feedbackfield\"></textarea></td></tr><tr><td><input type=\"submit\" value=\"Submit\" name=\"submit\" onclick=\"feedback()\"/></td></tr></table></center></div><body></html>");	
		
		}
	}//checking errormessage block
	else{
		out.println("<div id=\"results\"><span id=\"error\">"+errorMessage+"</span></div>");
	}
		
	}

}

