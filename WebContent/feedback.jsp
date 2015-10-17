<%@page import="java.io.* , java.util.Date" %>
<%
try{
String feedbacktext = request.getParameter("feedback");
File file = new File(config.getServletContext().getRealPath("/")+"tmp/feedback.txt");
if(!file.exists()){
	file.createNewFile();
}
else{
}
		Date date = new Date();
		FileWriter fo = new FileWriter(file, true);
		fo.write(feedbacktext+"\n");
		fo.write(date.toString()+"\n\n");
		fo.flush();
		fo.close();
}
catch(Exception e){
out.println(e.toString());
}


out.println("Thanks for ur comment");
%>
