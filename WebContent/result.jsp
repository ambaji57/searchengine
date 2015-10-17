<%@page import="java.lang.*,javax.servlet.*,javax.servlet.http.*,java.io.*,java.util.*,java.util.regex.Matcher, java.util.regex.Pattern ,com.sanskrit.searchengine.*"%>
<html>
<head>
<title>Sanskrit Search Engine (Gavesika)</title>
<style type="text/css">
	.out {
		font-size:17px;
	}
</style>
<style type="text/css">
#main{ width:1000px;position:relative;margin:auto; text-align:justify;line-height:1.8em;}
a{
color:white;
}
body {
margin:0;
padding:0;
}
body{
font-size:17px;
}
#head {width:;border:3px solid #0A0A0A;height:25px;position:relative;margin:auto;background:linear-gradient(#252525,#0A0A0A) repeat scroll 0 0 transparent;background:#0A0A0A;}
        	#head ul,li{list-style-type:none;display:inline;padding:7px;text-decoration:none;color:#fff;}#Depat {float:left;} #tools {float:right;}
        	#head a{padding:3px; color:#999;} #logo{font-size:50px;color:#B40404;} #logodiv{background:#e5e5e5;} #logodiv td{padding:10px;} #head a:hover{color:#fff;}
#head ul li a{list-style-type:none;display:inline;padding:17px 2px;text-decoration:none;color:#999;font-family: "Segoe UI","Segoe UI Web Regular","Segoe UI Symbol","Helvetica Neue","BBAlpha Sans","S60 Sans",Arial,"sans-serif"; font-size:18px;}
</style>
</head>
<body>
<%@ page 
	language="java" 
	pageEncoding="utf-8"
	contentType="text/html; charset=utf-8" 
%>
<%@include file="header.jsp"%>

<div id="logodiv"><table >
    <tr><td colspan="4" align="center"><label id="logo" width="350" height="130" alt="गवेषिका" title="sanskrit search engine">गवेषिका</label><span>(Sanskrit Search Engine)</span>
    </td>
<% 
			String filename = request.getParameter("filename");
			String query =  request.getParameter("query");
			QueryConverter qconverter = (QueryConverter)session.getAttribute("convertobject");
			String line = "";
			query = query.replaceAll(",@SPACE,"," ");
			String file_path = "/home/sanskrit/karunakara/searchengine-desktop1/";
			
%>

<td><p>From file:&nbsp;<%=filename.replaceAll("files_new/WX/","")%></p></td></tr>
</table></div>
<div id="main">

<%
			if(qconverter == null){
				 qconverter = new QueryConverter();
			}
			Grep wsearch = new Grep();
			String datalist1 = wsearch.grep(filename,query);
			 datalist1 = datalist1.replaceAll(file_path+filename,"");
			 datalist1 = datalist1.replaceAll("\t"," ").replaceAll("\n","@NEWLINE");
//			out.println(datalist1);
					out.println(qconverter.convertAny2UTF8(datalist1.replaceAll(" "," "),"Devanagari").replaceAll("_"," ").replaceAll("--","<br/><br/>").replaceAll("NEWLINE","<br/>"));
	%>
</div><%--closing of div main--%>
</body>
</html>

