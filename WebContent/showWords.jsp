<%@page import="com.sanskrit.searchengine.*,java.util.Map,java.util.HashMap" %>
<%@ page 
        language="java" 
        pageEncoding="utf-8"
        contentType="text/html; charset=utf-8" 
%>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body{ margin:0; padding:0;font-size:90%;font-family:Ubuntu;background:#f5f5f5;}
.main{ width:1000px; margin:auto; position:relative;background:#fff;border:1px solid #eee;}
td{padding:10px;background:#f4f4f4;} 
</style>
</head>
<body>
<div class="main">
<table align="center">	
<%
	Map<String,String> datamap = new ListOfFile().getListOfFile();
	out.println("<tr><td>Total Words</td><td>"+datamap.size()+"</td></tr>");
	for(String key : datamap.keySet()){
		out.println("<tr><td>"+key+"</td><td>"+datamap.get(key)+"</td></tr>");

	}
//	Iterator itr = datamap.keySet().iterator();
		
%>

</table>
</div>
</body>
</html>
