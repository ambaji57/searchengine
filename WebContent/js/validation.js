function validation(){
	
	if($("#query").val() == "" && $("#verb").is(':checked')){ }
	else if($("#query").val() == ""){
		alert("Please Enter any Text to Search or Select XAwu");$("#query").focus();
		return false;
	}
	else if($("#pada").is(':checked') || $("#morph").is(':checked')){}
	else{
		alert(" Please Select either प्रातिपदिकम्   or पदम्"); 
		return false;
	 }
	
	
	var str = $("#query").val();

	//condition for checking metacharacters at index of 0th position

	if(str[0] == "*" || str[0] == "?"){
		alert("Dont Use * or ? as a Frist Character in Query");
		return false;
	}
	//condition for find and And AND or Or OR and  only pada should be selected otherwise show alert message
	
	if((str.indexOf("and") > -1) || (str.indexOf("AND") > -1) || (str.indexOf("or") > -1) || (str.indexOf("OR") > -1) || (str.indexOf("And") > -1) || (str.indexOf("Or") > -1) || (str.indexOf("+") > -1)){
		if($("#morph").is(':checked')){	
			alert("Please Enter Single Word for प्रातिपदिकम्"); return false;
		}
	}
	
	//checking for literal string 	
	
	if($("#query").val() != ""){	
	
		for(var i=0;i<str.length-1;i++){
                        if(str[i]==" " &&  (str.indexOf("and") <= -1) && (str.indexOf("AND") <= -1) && (str.indexOf("or") <= -1) && (str.indexOf("OR") <= -1) && (str.indexOf("And") <= -1) && (str.indexOf("Or") <= -1)&& (str.indexOf("+") <= -1) && (str[0]!="\"" || str[str.length-1]!="\"")){
                                alert("Add quotes to search for literal string \""+str+"\"");
                                return false;
        	            }
	    }
	}

	//condition for find string has * and ?. if it has, only pada should be selected 

	if(((str.indexOf("\*") > -1) || (str.indexOf("\?") > -1)) && $("#morph").is(':checked')){
		alert("Please uncheck प्रातिपदिकम् and Select पदम्" );
		return false;
	}
	
	//condition for find literal string example "rAma sIwA" only pada should be selected otherwise show alert message
	
	if(str[0] == "\"" && str[str.length-1] == "\"" && $("#morph").is(':checked')){
		alert("Please uncheck प्रातिपदिकम् and Select पदम्" );
		return false;
	}
	
	var inputlang = $("#encoding").val();
	var data = $("#query").val();
	var reg=/[aAiIuUqQlLeEoOMHzkKgGfcCjJFtTdDNwWxXnpPbBmyrlvSRsh \*\.\?\-\_\!\^\,\+\"]/;
	/*var reguni=/[अआइईउऊएऐओऔंःकखगघङचछजझञटठडढणतथदधनपफबभमयरलवशषसहृ ऽ।॥?.]/;*/
	
	var reguni=/[अआइईउऊऋॠऌएऐओऔअंअःकखगघङचछजझञटठडढणतथदधनपफबभमयरलवशषसह ्ािीुूृॄॢेैोौंः  -_?.\*,!+/|।॥ऽ\"andANDorOR]/;
        var regitrans=/[AaiuURiLIeoMH.Nkgh~NcChjnThDtdpbmyrlvsS \?\-\_\.\,\!\*\^\+\" andANDorOR]/;
	var regslp=/[aAiIuUfFlxeEoOMHkKgGNcCqQjJwWQRtTdDnpPbBmyYrlvSzsh \.\?\*\+\" andANDorOR]/;
        var regvel=/[aiurlefomhkgncjtdpbvysz \~\"\?\-\_\.\,\!\*\+\" andANDorOR]/;
	var regkh=/[aAiIuUlReaoMHkghGcjJTDNtdnpbmyrlvzSs \.\?\*\+\" andANDorOR]/;
	var regrom=/[aāiīuūṛleaioauṃḥ?khgṅcjñṭḍṇtdnpbmyrlvśṣs \?\-\_\.\,\!\+\*\" andANDorOR]/;
			
		if(inputlang=="Unicode"){//<![CDATA[
			for(var i=0;i<data.length;i++){
			   if(reguni.test(data[i])){
			   } else {
				alert("please check encoding notation and input text notation");
				return false;
			}

		    }	
		}
		else if(inputlang=="itrans"){
			for(var i=0;i<data.length;i++){
				if(regitrans.test(data[i])){
				}
				else {
					alert("please check encoding notation and input text notation");
					return false;
				}
			}
			
		}
		else if(inputlang=="SLP"){
			for(var i=0;i<data.length;i++){
                                if(regslp.test(data[i])){
                                }
                                else {
                                	alert("please check encoding notation and input text notation");
                                        return false;
                                }
                        }
      		}

		else if(inputlang=="Roman"){
                        for(var i=0;i<data.length;i++){
                                if(regrom.test(data[i])){
                                }
                                else {	
                                	alert("please check encoding notation and input text notation");
                                        return false;
                                }
                        }
      
                }		

		else if(inputlang=="KH"){
                        for(var i=0;i<data.length;i++){
                                if(regkh.test(data[i])){
                                }
                                else {
                                	alert("please check encoding notation and input text notation");
                                        return false;
                                }
                        }
      
                }

		else if(inputlang=="Velthuis"){
                        for(var i=0;i<data.length;i++){
                                if(regvel.test(data[i])){
                                }
                                else {
                                	alert("please check encoding notation and input text notation");
                                        return false;
                                }
                        }
      
                }

		else if(inputlang=="Wx-notation"){
                        for(var i=0;i<data.length;i++){
                                if(reg.test(data[i])){
                                }
                                else {
                                	alert("please check encoding notation and input text notation");
                                        return false;
                                }
                        }
                       
                }
		
return true;
}

function feedback(){
        var ftext = $("#feedbackfield").val();
        $.post("feedback.jsp",{"feedback":ftext},function(result){
                alert(result);
		$("#feedbackfield").val("");
        });

}

