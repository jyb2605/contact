<%@ page pageEncoding="utf-8" %>
<%@ include file="../../constant.jsp" %>
<%  session.invalidate();  %>
<!DOCTYPE html>
<html lang="en-us">
<head>
	<!--  App Title  -->
	<title>주소록</title>
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

				<%@ include file="../header.jsp"%>








	<!--  About Section  -->
	<section class="about" id="about">
		<div class="container">
			<div class="row">

<fieldset class="srch" >

<%@ include file="../footer.jsp"%>


</body>

<script>
<%
	request.setCharacterEncoding("UTF-8");
	String rs = request.getParameter("result");
//	out.println(rs);
	if(rs!=null && rs.equals("fail")){
		out.println(
			"alert(\"입력하신 계정정보가 존재하지 않습니다.\");"
		);
	}
%>



readInfo();
function readInfo() {
	var xmlhttp = new XMLHttpRequest();
	var url = "<%= domain %>/contact/api/contact/read.jsp";
	console.log("readInfo() 진입");
	xmlhttp.onreadystatechange = function() {
		//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
			if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
				 //alert(JSON.parse(xmlhttp.responseText)["result"]);
				 console.log("readInfo() response");
				 var res = JSON.parse(xmlhttp.responseText);
				 var query="";
				 for(var item of res){
					// console.log(item["user_id"]);
					query+=" <tr>";
					query+="  <td align='center'><input type='checkbox' name='check'></td>";
					query+="  <td align='center'><a href='#'>"+ item["friend_name"] +"</a></td>";
					query+="  <td align='center'><a href='#'>"+ item["friend_tell"] +"</a></td>";
					query+="  <td align='center'>"+ item["friend_relationship"] +"</td>";
					query+="  <td align='center'>"+  item["friend_group"] +"</td>";
					query+=" </tr>";
				 }
				 var contact_data = document.getElementById('contact_data');
				 contact_data.innerHTML = query;
				//  console.log(JSON.parse(xmlhttp.responseText));
			}
	};
	// xmlhttp.open("GET", url, true);
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
};


(function() {
  var insertButton = document.getElementById('insert');
  var cancelButton = document.getElementById('cancel');
  var insertDialog = document.getElementById('insertDialog');
	var i_confirmButton = document.getElementById('i_confirm');


  insertDialog.close();
  // Update button opens a modal dialog
  insertButton.addEventListener('click', function() {
    insertDialog.showModal();
  });

	i_confirmButton.addEventListener('click', function() {
		var i_name = encodeURI(document.getElementById('i_name').value);
		var i_tell = document.getElementById('i_tell').value;
		var i_relation_ship = encodeURI(document.getElementById('i_relation_ship').value);
		var i_group = encodeURI(document.getElementById('i_group').value);

		var parmas = "user_id="+"test"+"&i_name="+i_name+"&i_tell="+i_tell+"&i_relation_ship="+i_relation_ship+"&i_group="+i_group;
		//console.log(parmas);
		var url = "<%= domain %>/contact/api/contact/create.jsp";
		insertDialog.close();


		var xmlhttp = new XMLHttpRequest();

		xmlhttp.onreadystatechange = function() {
			//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
		    if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
		       //alert(JSON.parse(xmlhttp.responseText)["result"]);
					 console.log(xmlhttp.responseText);
					 readInfo();
		    }
		};
		// xmlhttp.open("GET", url, true);
		xmlhttp.open("POST",url,true);
		xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xmlhttp.send(parmas);
  });

  // Form cancel button closes the dialog box
  cancelButton.addEventListener('click', function() {
    insertDialog.close();
  });
})();


</script>
</html>
