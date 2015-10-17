<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="searchengine.*"%>
<%@page import="java.lang.*"%>
<%@ page import = "java.net.*,javax.servlet.*, javax.servlet.http.*, java.io.*, org.apache.lucene.analysis.*, org.apache.lucene.analysis.standard.*, org.apache.lucene.document.*, org.apache.lucene.index.*, org.apache.lucene.store.*, org.apache.lucene.search.*, org.apache.lucene.queryParser.*, java.net.URLEncoder, org.apache.lucene.util.* ,java.util.regex.Matcher, java.util.regex.Pattern ,java.util.*,javax.xml.parsers.*, javax.xml.transform.*, javax.xml.transform.dom.*, javax.xml.transform.stream.*, org.w3c.dom.Element"%>
<html>
<head>
<%--<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">--%>
<title>Sanskrit Search Engine</title>
<link rel="stylesheet" type="text/css" href="index.css"/>
<!--        Script by hscripts.com          -->
<!--        copyright of HIOX INDIA         -->


<!-- more scripts @ http://www.hscripts.com -->

<script type="text/javascript">
function showResults(params,text,path,fname,file){
document.forms['story'][0].value=text;
document.forms['story'][1].value=path;
document.forms['story'][2].value=fname;
document.forms['story'].action = "result.jsp?file="+file;
document.forms['story'].submit();
}
</script>
<style type="text/css">
#link{
color:white;
}
a:visited{
color:blue;
}
</style>
</head>
<body>
<script type="text/javascript" src="wz_tooltip.js"></script>
<div id="loadingDiv">
Please Wait...
</div>

<%  out.flush();
long time;
for (time = 0; time < 1000000000; time++) {

}
%>
<script>  
document.getElementById("loadingDiv").style.display="none";  
</script>
<div style="margin-left:10px;">

<%@include file="sessionnew.jsp"%>
<%
   boolean error = false;
String source_index=request.getParameter("source");
  String index_name="/home/sanskrit/karunakara/searchengine-desktop/"+source_index;
   Query query=null;
   Searcher searcher=null;
   int start_index=0;
   int max_pages=10;
   TopDocs hits= null;
   String querystring=null;
   String start_value="0";
   String max_result=null;
   int thispage=0;
   String lang=request.getParameter("listbox");
   String gender=request.getParameter("list");
   String prayoga=request.getParameter("prayoga");
   String vb=request.getParameter("vb");
   String tcount="";	
   	String sel="",sample="",sel1="",nstring="",sorted="",dstring="",out2="";
	String spaceword="",tmp="";
	String linenum="";
	String[] sam1,str1;
	String passvalue="";
	long stime=0,etime=0,dtime=0;
	int t=0,count=0; // this variable using  for numbering for result in a page;
  try {
  
      IndexReader reader= IndexReader.open(FSDirectory.open(new File(index_name)),true);
       searcher = new IndexSearcher(reader);
      }
   catch(Exception e) {
   %>
  <p> Error occured while reading index of files </p>
  <%  error= true;
    }
  %>
 <%
         if(error == true)
        {
 %>
     <p>hey  u did  a mistake please correct it</P>
  <%
   }
   else {
          querystring= request.getParameter("index_text");
	  passvalue=querystring;

		querystring=querystring.replace("\"","&quot;");
		if(querystring.startsWith(" ")){
		querystring=querystring.replaceFirst(" ","");
		}
	try {
		start_value=request.getParameter("startat");
		start_index=Integer.parseInt(start_value);
	    }
	catch(Exception e) {
	}
		if(querystring.contains(" ") && (!querystring.contains("and"))&& (!querystring.contains("AND"))&& (!querystring.contains("And"))&& (!querystring.contains("or"))&& (!querystring.contains("OR"))&& (!querystring.contains("Or")) && (!querystring.contains("+"))  ){
		querystring=querystring.replace(" ","SPACE");
	}
		querystring=querystring.replace("&quot;","\"");
		perlconvert p= new perlconvert();
	if(lang.equals("Unicode"))   // here am added some code for convertion
		{
			querystring=querystring.replace(" ","_");
			querystring=p.convert(querystring,"Unicode");
			querystring=querystring.replace("_"," ");
		}
		if(lang.equals("Velthuis")){
			querystring=querystring.replace(" ","_");
			querystring=p.convert(querystring,"Velthuis");
			querystring=querystring.replace("_"," ");
		}
		if(lang.equals("SLP")) {
			querystring=querystring.replace(" ","_");
			querystring=p.convert(querystring,"SLP");
			querystring=querystring.replace("_"," ");
			
		}
		if(lang.equals("itrans")){
			querystring=querystring.replace(" ","_");
			querystring=p.convert(querystring,"Itrans");
			querystring=querystring.replace("_"," ");
		}
		if(lang.equals("Roman")){
			querystring=querystring.replace(" ","_");
			querystring=p.convert(querystring,"Roman");
			querystring=querystring.replace("_"," ");
		}
		querystring=querystring.replace("@","");

		String select[] = request.getParameterValues("morph");
		if (select != null && select.length != 0) { //check for selection of checkboxs
		for (int i = 0; i < select.length; i++) {
		sel=select[i];
		sel=sel.trim();
		if(sel.equals("")) {
		}
		}
		}
		else {
		} 
		if(sel.equals("Morph")){   //checking for selection is morph or not
		normalize n=new normalize();
                nstring=n.Normalize(querystring);
		find ff= new find();
		querystring=ff.Find(nstring,gender);
		if(querystring==null || querystring.equals("") || !querystring.contains(" ")){
		querystring="";
		}
		}
		else if(sel.equals("verb")){
		gen g= new gen();
		querystring=g.Gen(vb,prayoga);
		}
		else if(querystring.contains("SPACE")){
		spaceword=querystring;
		querystring=querystring.replace("SPACE"," ");
		}
		else{
		nstring=querystring;	
                nstring=nstring.replaceAll(" ",",");
                normalize n=new normalize();
                nstring=n.Normalize(nstring);
                        if(nstring == querystring || nstring.equals(querystring)){
                        denormalize dn=new denormalize();
                        dstring=dn.DeNormalize(nstring);
                        }
                        else{
                        normalize nn=new normalize();
                        dstring=nn.Normalize(nstring);
                        }
                        out2=querystring+","+dstring;
               		out2=out2.replaceAll(" ",",");
			SortQuery sort= new SortQuery();
			sorted=sort.sortquery(out2);
			querystring=sorted.replaceAll(","," ");
               	}
	
          Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT);
          try {
                QueryParser qp = new QueryParser("contents", analyzer);
		if(sel.equals("Morph")) { //if morph is selected 
                query= qp.parse(querystring);
		tcount=querystring;
		}
		else if(sel.equals("verb")) { //if morph is selected 
                query= qp.parse(querystring);
		tcount=querystring;
		}
		else if(!spaceword.equals("")){
                query= qp.parse(querystring);
		tcount=spaceword;
		}
		else {    // if not selected
                query= qp.parse(querystring);
		tcount=querystring;
		}
              }
          catch (ParseException e){
%>
  <p>प्रातिपदिकम् does not exists in the Database </p>
<%
 error= true;
 } 
     }
 if(error== false  && searcher != null)
 {
   thispage = max_pages;

   hits= searcher.search(query, max_pages+start_index);
   if(hits.totalHits ==0) {
%>
<p> Sorry no relevant information found</p>
<p> please modify your search options</p>
<%
}
}
if(error == false && searcher != null) {
if(tcount.contains("*")){
        tcount=tcount.replace("*","[a-zA-Z]*");
        }
if(tcount.contains("?")){
        tcount=tcount.replace("?","[a-zA-Z]");
}
if(tcount.contains("and") ||tcount.contains("And") ||tcount.contains("AND") ||tcount.contains("or") ||tcount.contains("Or") ||tcount.contains("OR") ||tcount.contains("+")){
	tcount=tcount.replace("and","");
	tcount=tcount.replace("And","");
	tcount=tcount.replace("AND","");
	tcount=tcount.replace("or","");
	tcount=tcount.replace("Or","");
	tcount=tcount.replace("OR","");
	tcount=tcount.replace("+","");
}
	tcount=tcount.replace("\"","");
%>
<p>
<font>String Found in <%=hits.totalHits%> Files</font></p>
<table cellpadding="3" style="margin-left:55px;">
<%
  if((start_index+max_pages) > hits.totalHits)
   thispage= hits.totalHits-start_index;
for(int i= start_index; i<(thispage+ start_index); i++) {
	t=i;
%>
  <tr>
<%
  Document doc=  searcher.doc(hits.scoreDocs[i].doc);
  String doctitle= doc.get("title");
  String url = doc.get("path");
//  String suburl = url.substring(46);
  String fileinfo[]=url.split("/");
  int len=fileinfo.length;
  WordSearch fr = new WordSearch();
   spaceword=spaceword.replace("\"","");
if(sel.equals("Morph")){
   sample = fr.search(url,querystring);
		
	}
else if(sel.equals("verb")){
   sample = fr.search(url,querystring);
	
}
else if(!spaceword.equals("")){
	sample = fr.search(url,spaceword);
        }
else {
        if(querystring.contains("+")){
		str1=querystring.split(" ");
		for(int ind=0;ind<str1.length;ind++){
			if(str1[ind].contains("+")){
				tmp += str1[ind];
			}
		}
		tmp=tmp.replaceFirst("\\+","");
		tmp=tmp.replace("+"," ");
		sample = fr.search(url,tmp);
		tmp="";
	}
	else{
	sample = fr.search(url,querystring);
	}
}
if(sample.equals("")){

}
else{
sam1=sample.split("/%");
count=count+1;
sample=sam1[0];
	FileExtension fe= new FileExtension();
         String type=fe.findtype(url);
        if(!type.equals(".xml") && !type.equals(".html")) {
	}
	else {
try {
              String output="";
                                sample=sample.replaceAll("b>","@b>");
                                sample=sample.replaceAll("i>","@i>");
                                sample=sample.replaceAll("<BR>","");
                                sample=sample.replaceAll(" ","\\$");
                                sample=sample.replaceAll("\t","\\$");
                                perlconvert p= new perlconvert();
                                sample=p.convert(sample,"Devanagari");
                                sample=sample.replaceAll("\\$"," ");
                                output=output+sample+" ";
sample=output;
//matcher=patten.matcher(sample);
//sample=matcher.replaceAll(linenum);
  }
catch(Exception e) {
}
}
  sample=sample.replace("%","<br/>");
  sample=sample.replace("spanstart ","<span style=\"background-color:yellow;\">");
  sample=sample.replace(" end ","</span>");
t=t+1;
%>
<td>&nbsp;&nbsp;<%=sample %>
<%@include file="totalcount.jsp" %>
<%
for(int l=0;l<sam1.length-1;l++){
%>
        <%=sam1[l+1]%>
<%
}
%>

<% if(type.equals(".html")){
%>
&nbsp;&nbsp;From File: <%=fileinfo[len-1]%>
<%--<a href="result.jsp?path1=<%=suburl%>&text=<%=word%>" target="_blank"><u>More.....</u></a></br></br>
<form name="story" id="story" action="result.jsp?a=<%=fileinfo[len-1]%>" method="post" target="_blank">--%>
<form name="story" id="story" action="" method="post" target="_blank">
        <a href="#result.jsp?file=<%=fileinfo[len-1]%>" onclick="showResults(this,'<%=tcount%>','<%=url%>','<%=fileinfo[len-1]%>','<%=fileinfo[len-1]%>')"><u>More....</u></a>
        <input type=hidden name="text" id="text" value="<%=tcount%>"/>
        <input type=hidden name="path1" id="path1" value="<%=url%>"/>
        <input type=hidden name="fname" id="fname" value="<%=fileinfo[len-1]%>"/>
        <input type=hidden name="file" id="file" value="<%=fileinfo[len-1]%>"/>
</form>
<%}else{%>
<%
}
}
}
%>
</td>
</tr>
<tr>
<%
etime=System.currentTimeMillis();
dtime=etime-stime;
out.println("<br/>"+dtime+" "+"millisec");
}
try {
if(start_index>=10)
{
if(sel.equals("verb")){ querystring="";}

String prevurl="main.jsp?index_text="+URLEncoder.encode(passvalue)+"&amp;maxresults="+max_pages +"&amp;startat="+(start_index-10)+"&listbox="+lang+"&list="+gender+"&morph="+sel+"&source="+source_index+"&prayoga="+prayoga+"&vb="+vb;
%>
<td>
<a href="<%=prevurl%>">---Previous</a></td>
<%
}
//if((start_index+max_pages)<= count)
if(count == 0 ){
}
else if (count >=1 && count <9){

}

else if((start_index+max_pages)< hits.totalHits)
{
if(sel.equals("verb")){ querystring="";}
String moreurl= "main.jsp?index_text="+URLEncoder.encode(passvalue)+"&maxresults=" + max_pages +
                                       "&startat=" + (start_index + max_pages)+"&listbox="+lang+"&list="+gender+"&morph="+sel+"&source="+source_index+"&prayoga="+prayoga+"&vb="+vb;
%>
<td><a href="<%=moreurl%>">Next---</a></td>
</tr>
<%
}
}
catch(Exception e) {
}
%>

</table>
</div>
</body>
</html>
