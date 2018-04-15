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


<script>
	

</script>


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

<section class="about" id="about">
		<div class="container">
			<div class="row">



<table align="center" class="table table-hover table-responsive" border="0">
 <tr>
  <th width = "80" ><center><input type='checkbox' id='allCheck' onclick="allCheckNCancel()"></center></th>
  <th width = "100" ><center>그룹</center></th>
  <th width = "200"><center>멤버</center></th>
  <th width = "200"><center>인원수</center></th>

 </tr>
<tbody id="contact_data">
</tbody>
</table>
<div id="page_list" align="center"></div><br>
<input type="submit" id="insert" class="btn" value="그룹추가">
<input type="submit" class="btn" value="그룹삭제" onclick="removeItem()">



<%@ include file="../footer.jsp"%>



<dialog open id="insertDialog">
  <form method="dialog">
    <section>


			<div style="display:inline-block;">
			<label>그룹 이름</label>
			</div>
			&nbsp;
			      <div style="display:inline-block;">
				<input type="text" id="group_name"/>

			</div>

    </section>
    <menu>
			      <button type="submit" id="i_confirm">추가</button>
      <button id="cancel" type="reset">취소</button>

    </menu>
  </form>
</dialog>


</body>
<script>
readInfo(1);
function readInfo(page) {
	var xmlhttp = new XMLHttpRequest();
	
	var url = "<%= domain %>/contact/api/group/read.jsp";

	xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
				 //alert(JSON.parse(xmlhttp.responseText)["result"]);
				 console.log("readInfo() response");
				 console.log(xmlhttp.responseText);
				 var res = JSON.parse(xmlhttp.responseText);


				 var query="";
				 for(var item of res["result"]){
					// console.log(item["user_id"]);
					query+=" <tr>";
					query+="  <input type='hidden' name='item_idx' value='"+item["idx"] +"' />";
					query+="  <td align='center'><input type='checkbox' name='LID'></td>";
					query+="  <td align='center'>"+ item["group_name"] +"</td>";
					query+="  <td align='center'>"+  item["friends_name"] +"</td>";
					query+="  <td align='center'>"+  item["members_cnt"] +" 명</td>";
					query+=" </tr>";
				 }
				var list_arr = "";

				if(res["start_page"]=="true"){
					console.log(res["start_page"]);
					list_arr += "<a href='#' onclick='readInfo(1)'>"+ " << "+"</a>";
					list_arr += "<a href='#'  onclick='readInfo(" + (Number(res["current_page"]) - 1) +")'>"+ " < "+"</a>";
				}
				var page = res["page_list"];
	
				for(var index = 0; index<page.length; index++){
					list_arr +="<a href='#'  onclick='readInfo(" +  page[index] +")'> " + (' ' + page[index] + ' ')  + "</a>";
				}

				if(res["end_page"]=="true"){
					console.log(res["end_page"]);
					list_arr += "<a href='#'  onclick='readInfo(" + (Number(res["current_page"]) + 1) +")'>"+ " > "+"</a>";
					list_arr += "<a href='#'  onclick='readInfo(" + (Number(res["total_page"])) +")'>" + ">>"+ "</a>";
				}

				document.getElementById('page_list').innerHTML = list_arr;	
			
				 var contact_data = document.getElementById('contact_data');
				 contact_data.innerHTML = query;

			}
	};
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
		var group_name = encodeURI(document.getElementById('group_name').value);

		

		var parmas = "user_id="+ "<%=user_id%>" +"&group_name="+group_name;

		var url = "<%= domain %>/contact/api/group/create.jsp";
		insertDialog.close();
		console.log(url + "?" + parmas );

		var xmlhttp = new XMLHttpRequest();

		xmlhttp.onreadystatechange = function() {
			//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
		    if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
		       //alert(JSON.parse(xmlhttp.responseText)["result"]);
					 console.log(xmlhttp.responseText);
					 readInfo(1);
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


function allCheckNCancel(){
	var checkBoxAll = document.getElementById("allCheck");
	var allCheckBox = document.getElementsByName("LID");
	if(checkBoxAll == null || checkBoxAll == undefined || allCheckBox == null || allCheckBox == undefined)
		return;
	for(var i = 0; i < allCheckBox.length; i++){
		if(checkBoxAll.checked)
			allCheckBox[i].checked = true;
		else
			allCheckBox[i].checked = false;
	}
}


function removeItem(){
				
	var allCheckBox = document.getElementsByName("LID");
	var allItemIndex = document.getElementsByName("item_idx");
	
	var request="";
	if(allCheckBox == null || allCheckBox == undefined)
		return;

	for(var i = 0; i < allCheckBox.length; i++){

		if(allCheckBox[i].checked){
		console.log(allItemIndex[i]);
			request += allItemIndex[i].value + ",";
		}
	}
	request=request.substring(0,request.length-1);
				
	var xmlhttp = new XMLHttpRequest();
	var url = "<%= domain %>/contact/api/group/delete.jsp?group_id=" + request;
//	console.log(url);
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
			console.log(xmlhttp.responseText);
			readInfo(1);
		}
	};
	xmlhttp.open("GET", url, true);
	xmlhttp.send();
	
}



</script>
</html>