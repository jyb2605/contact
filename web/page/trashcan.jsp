<%@ page pageEncoding="utf-8" %>
<%@ include file="../../constant.jsp"%>
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






	<!--  About Section  -->
	<section class="about" id="about">
		<div class="container">
			<div class="row">



<br />

 <select id="search_type">
 <option value="name">이름</option>
 <option value="tell">연락처</option>
 <option value="group">그룹</option>
 </select>
 &nbsp;
 <input type="text" id="search_input"  value="">
	 &nbsp;
 <input type="submit" onclick="readInfo(1)" class="btn" value="검색">
</fieldset>


<table align="center" class="table table-hover table-responsive" border="0">
 <tr>
  <th width = "80" ><center><input type='checkbox' id="allCheck" onclick="allCheckNCancel()"></center></th>
  <th width = "100" ><center>이름</center></th>
  <th width = "200"><center>연락처</center></th>
  <th size = "20" ><center>관계</center></th>
  <th size = "20" ><center>삭제 시간</center></th>
 </tr>
<tbody id='trash_data'>

</tbody>
</table>
<div id="page_list" align="center"></div>
<input type="submit" class="btn" value="복구">
	<input type="submit" class="btn" value="삭제" onclick="removeItem()">

			</div>
		</div>


	</section>
	<!--  End About Section  -->




<%@ include file="../footer.jsp"%>


</body>
<script>
readInfo(1);
function readInfo(page) {
	var xmlhttp = new XMLHttpRequest();
	
	var search_type = document.getElementById('search_type').value;
	var search_input = document.getElementById('search_input').value;
	
	var url = "<%= domain %>/contact/api/trash/read.jsp?page=" + page + "&search_type=" + search_type + "&search_input=" + search_input;
	console.log(url);
	xmlhttp.onreadystatechange = function() {
		//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
			if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
				 //alert(JSON.parse(xmlhttp.responseText)["result"]);
				 console.log("readInfo() response");
				 console.log(xmlhttp.responseText);
				 var res = JSON.parse(xmlhttp.responseText);


				 var query="";
				 for(var item of res["result"]){
					// console.log(item["user_id"]);
					query+=" <tr>";
					query+="  <input type='hidden' name='item_idx' value='"+item["idx"]+"' />";
					query+="  <td align='center'><input type='checkbox' name='LID'></td>";
					query+="  <td align='center'><a href='#'>"+ item["friend_name"] +"</a></td>";
					query+="  <td align='center'><a href='#'>"+ item["friend_tell"] +"</a></td>";
					query+="  <td align='center'>"+ item["friend_relationship"] +"</td>";
					query+="  <td align='center'>"+  item["remove_time"] +"</td>";	
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
			
				 var trash_data = document.getElementById('trash_data');
				 trash_data.innerHTML = query;

				//  console.log(JSON.parse(xmlhttp.responseText));
			}
	};
	// xmlhttp.open("GET", url, true);
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
};


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
	var url = "<%= domain %>/contact/api/trash/delete.jsp?contact_id=" + request;
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
