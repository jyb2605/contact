<%@ page pageEncoding="utf-8" %>
<%@ include file="../../constant.jsp" %>
<!DOCTYPE html>
<html lang="en-us">
<head>
	<!--  App Title  -->
	<title>그룹</title>
	<!--  App Description  -->
	<meta name="description" content="Capture is a free bootstrap v3.3.2 app landing page perfect to present you IOS, android or windows application in an elegant way."/>
	<meta charset="utf-8">
	<meta name="author" content="pixelhint.com">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />

	<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="../css/owl.transitions.css"/>
	<link rel="stylesheet" type="text/css" href="../css/owl.carousel.css"/>
	<link rel="stylesheet" type="text/css" href="../css/animate.css"/>
	<link rel="stylesheet" type="text/css" href="../css/main.css"/>


</head>
<body>

	<% String user_id = (String)session.getAttribute("user_id");
	if(user_id == null){
			%>
				<%@ include file="../header.jsp"%>
			<%
	}else{
		%>
			<%@ include file="../header_logined.jsp"%>
		<%
	}
%>

<div id='data'>

</div>





<section class="about" id="about">
		<div class="container">
			<div class="row">




<%@ include file="../footer.jsp"%>

</body>
<script>

function create(name){

var xmlhttp = new XMLHttpRequest();

	var url = "<%= domain %>/contact/api/contact/create_by_timeline.jsp?user_name=" + name;
	console.log(url );
	xmlhttp.onreadystatechange = function() {
		//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
			if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
				 //alert(JSON.parse(xmlhttp.responseText)["result"]);
				 console.log(xmlhttp.responseText);
	remove(name);
				//  console.log(JSON.parse(xmlhttp.responseText));
			}
	};
	// xmlhttp.open("GET", url, true);
	xmlhttp.open("GET",url,true);
	xmlhttp.send();

};



function remove(name){


	var xmlhttp = new XMLHttpRequest();

	var url = "<%= domain %>/contact/api/timeline/remove.jsp?user_name=" + name;	
	console.log(url );
	xmlhttp.onreadystatechange = function() {
		//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
			if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
				 //alert(JSON.parse(xmlhttp.responseText)["result"]);
				 console.log(xmlhttp.responseText);
//				remove(name);
readInfo(1);
				//  console.log(JSON.parse(xmlhttp.responseText));
			}
	};
	// xmlhttp.open("GET", url, true);
	xmlhttp.open("GET",url,true);
	xmlhttp.send();

};


readInfo(1);
function readInfo(page) {
	var xmlhttp = new XMLHttpRequest();

	var url = "<%= domain %>/contact/api/timeline/read.jsp";
	console.log(url );
	xmlhttp.onreadystatechange = function() {
		//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
			if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
				 //alert(JSON.parse(xmlhttp.responseText)["result"]);
				 console.log(xmlhttp.responseText);
				 var res = JSON.parse(xmlhttp.responseText);
				var query="";
				for(var index = 0; index<res.length; index++){
					var name = res[index]["user_name"];
					query+='<div  height="200px" style=" border-style: solid; border-color: #45B278;  border-width: 2px;  margin-top: 30px; margin-bottom: 30px; margin-right: 300px; margin-left: 300px;">';										query+='<span width="300px">';
					query+='	<div width="180px"	style=" margin-top: 30px; margin-bottom: 30px; margin-right: 50px; margin-left: 50px">이름 : '+res[index]["user_name"]+'</div>';
					query+='	<div width="180px"	style=" margin-top: 30px; margin-bottom: 30px; margin-right: 50px; margin-left: 50px">전화번호 : '+res[index]["user_tell"]+'</div>';
					query+='	<div width="180px"	style=" margin-top: 30px; margin-bottom: 30px; margin-right: 50px; margin-left: 50px">추가한 날짜 : '+res[index]["created_time"]+'</div>';
					query+='</span>';		
					query+='<input type="button" style="margin-bottom: 30px; margin-left: 50px;" value="추가" class="btn"  onclick="create(\''+name+'\')" />';		
					query+='<input type="button"  style="margin-bottom: 30px; margin-left: 20px;" value="삭제" class="btn"  onclick="remove(\''+name+'\')"/>';					
					query+='</div>';					

				}			
				document.getElementById('data').innerHTML = query;	
			
				//  console.log(JSON.parse(xmlhttp.responseText));
			}
	};
	// xmlhttp.open("GET", url, true);
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
};

</script>
</html>