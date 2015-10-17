<%@page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <Title> Sanskrit SearcheEngine(गवेषिका) Gaveṣikā </Title>
        <script type="text/javascript" src="js/jquery.tools.min.js"></script>
        <script type="text/javascript" src="js/validation.js"></script>
         <script type="text/javascript">
         	function valid(str){
         			var check = ["morph","verb","pada"];
         			for(var i = 0;i< check.length;i++){
         				if(str == check[i]){}
         				else{ $("#"+check[i]+"").attr('checked',false);}
         			}
         			if($("#verb").is(':checked')){ $("#morph").attr('checked',false);$("#pada").attr('checked',false);$("#XAwu").show();$("#searchbox").hide();$("#query").val("");}
					else{ $("#XAwu").hide();$("#searchbox").show(); }					
				
		}
		$(function(){
                        $("#feed").click(function(){
                                $("#feedbackdiv").overlay().load();
                        });
                                $("#feedbackdiv").overlay({top:100 ,mask: {color:'#999',loadSpeed:500,opacity:0.6},SendOnClick: false,});

                });

         </script>
        <style type="text/css">
        	#logo {font-size:80px;color:#B40404;}
        	body, html {margin:0;padding:0;min-height:600px;font-size:16px;}
        	input[type="text"], select {padding:5px;border:1px solid #929292;background:#fff;}
        	input[type="submit"]{padding:5px;width:200px;border:1px solid #489CDF;background:#489CDF;color:#fff;font-size:20px;}
        	#head {width:;border:3px solid #0A0A0A;height:25px;position:relative;margin:auto;background:linear-gradient(#252525,#0A0A0A) repeat scroll 0 0 transparent;background:#0A0A0A;}
        	#head ul,li,a{list-style-type:none;display:inline;padding:7px;text-decoration:none;}#Depat {float:left;} #tools {float:right;}
        	#head a{padding:3px;color:#999;font-family: "Segoe UI","Segoe UI Web Regular","Segoe UI Symbol","Helvetica Neue","BBAlpha Sans","S60 Sans",Arial,"sans-serif";font-size:18px;} #head a:hover{color:#fff;}
		#wrapper{position:relative;margin:auto;width:1000px;}
		 #feedbackdiv {display:none;background:#fff;width:50%;border-radius:2px;}
                textarea {width:100%;}
                .close{top:-35px;margin-right:-10px;position:relative;color:#fff;float:right;font-size:30px;background:#333;border-radius:50px;cursor:pointer;padding:6px;}
        </style>
        </head>
<body>
<%-- <%@include file="counter.jsp"%> --%>
<%@include file="header.jsp"%><br/>
<div id="wrapper">
<center>
<div id="w1">   
 <form method ="get" action= "/searchengine/search.do" onsubmit="return validation()">
<table >
    <tr><td colspan="4" align="center"><label id="logo" width="350" height="130" alt="गवेषिका" title="sanskrit search engine">गवेषिका</label><span>(Sanskrit Search Engine)</span>
    </td></tr>
    <tr><td>Source &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id="source" name="source">
<option value="gretil">GRETIL</option>
<option value="mahbht">Mahabharat-Bori</option>
<option value="oliver">DCS</option>
<option value="sktlib">Sanskrit Library</option>
<option value="uohyd">UoHyd</option>
<option value="shmt">SHMT</option>
<%--<option value="sarit">SARIT</option>--%>
<option value="all">All</option>
</select></td><td> <input id="morph" type="checkbox" onclick="valid('morph');" value="Morph" name="morph">प्रातिपदिकम् &nbsp;<select name="list"><option value="puM">पुंलिङ्गम्</option><option value="swrI">स्त्रीलिङ्गम्</option><option value="napuM">नपुंसकलिङ्गम्</option><option value="a">लिङ्त्रये</option></select>&nbsp;&nbsp;<input id="pada" type="checkbox" onclick="valid('pada');" value="pada" name="pada">पदम् &nbsp;&nbsp;<input id="verb" type="checkbox" onclick="valid('verb');" value="verb" name="verb">
धातु: </td></tr>

     <tr id="searchbox"><td>Encoding&nbsp;&nbsp;<select name="encoding" id="encoding"><option value="Wx-notation">WX-notation</option><option value="Unicode">Unicode-Devanagari</option><option value="SLP">SLP1</option><option value="Itrans">Itrans</option><option value="Velthuis">Velthuis</option><option value="Roman">Unicode Roman Diacritic</option></select></td><td align="center">
            <input type="text" name= "query" size="50" id="query" placeholder="Enter Word to Search" >
         </td></tr>
         <tr id="XAwu" style="display:none;"><%@include file="option.jsp" %></tr><tr>
<td  colspan="4" align="center">
       
         <input type="submit" value=Search>
       </td>
</tr>
</table>
</form></div></center>
</div>
	<div id="feedbackdiv">
                 <label name="close" value="close" class="close">X</label>
                <center>
		<p style="font-size:14px;">Your feedback is important to us for improving the system further.
You may alternately write to Amba Kulkarni (ambapradeep@gmail.com) or Karunakar (kannaiah.chinni@gmail.com).</p>
                <table><tr><td>Feedback Text</td></tr>
                <tr><td><textarea cols="60" rows="10" name="feedbacktxt" value="" Placeholder="Enter ur feedback" id="feedbackfield"></textarea></td></tr>
                <tr><td><input type="submit" value="Submit" name="submit" onclick="feedback()"/></td></tr>
                </table>
                </center>
        </div>

    </body>
</html>
