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
//	user_id = "test";
//out.println(user_id );
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

<fieldset class="srch" >

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


<br />


<table align="center" class="table table-hover table-responsive" border="0">
 <tr>
  <th width = "80" ><center><input type='checkbox' id='allCheck' name='check' onClick="allCheckNCancel()"></center></th>
  <th width = "100" ><center>이름</center></th>
  <th width = "200"><center>연락처</center></th>
  <th size = "20" ><center>관계</center></th>
  <th size = "20" ><center>그룹</center></th>
 </tr>
<tbody id="contact_data">

</tbody>

</table>
<div id="page_list" align="center"></div>
<!-- Simple pop-up dialog box, containing a form -->
<dialog open id="insertDialog">
  <form method="dialog">
    <section>


			<div style="display:inline-block;">
			<label>이름 </label>
			<br /><br />
			<label>전화번호 </label>
			<br /><br />
			<label>관계 </label>
			<br /><br />
			<label>그룹 </label>
			</div>
      <div style="display:inline-block;">
				<input type="text" id="i_name"/>
				<br /><br />
				<input type="text" id="i_tell"/>
				<br /><br />
				<input type="text" id="i_relation_ship"/>
				<br /><br />
	      <select id="group_data">

	      </select>
			</div>

    </section>
    <menu>
			      <button type="submit" id="i_confirm">추가</button>
      <button id="cancel" type="reset">취소</button>

    </menu>
  </form>
</dialog>

<dialog open id="updateDialog">
  <form method="dialog">
    <section>


			<div style="display:inline-block;">
			<label>이름 </label>
			<br /><br />
			<label>전화번호 </label>
			<br /><br />
			<label>관계 </label>
			<br /><br />
			<label>그룹 </label>
			</div>
      <div style="display:inline-block;">
				<input type="hidden" id="u_idx" />
				<input type="text" id="u_name" disabled/>
				<br /><br />
				<input type="text" id="u_tell" disabled/>
				<br /><br />
				<input type="text" id="u_relation_ship"/>
				<br /><br />
	      <select id="u_group_data">

	      </select>
			</div>

    </section>
    <menu>
			      <button type="submit" id="u_confirm">수정</button>
			      <button id="u_cancel" type="reset">취소</button>

    </menu>
  </form>
</dialog>



<input type="submit" id="insert" class="btn" value="추가">
	  <input type="submit" class="btn" value="수정" id="update">
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
	
	var url = "<%= domain %>/contact/api/contact/read.jsp?page=" + page + "&search_type=" + search_type + "&search_input=" + search_input;
	console.log("readInfo() 진입");
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
					query+="<input type='hidden' name='item_idx' value='" + item["idx"]  +"' />";
					query+="  <td align='center'><input type='checkbox' name='LID'></td>";
					query+="  <td align='center'><a href='#' name='friend_name' >"+ item["friend_name"] +"</a></td>";
					query+="  <td align='center'><a href='#' name='friend_tell'   >"+ item["friend_tell"] +"</a></td>";
					query+="  <td align='center' name='friend_relationship'  >"+ item["friend_relationship"] +"</td>";
					query+="  <td align='center' name='friend_group_name'  >"+  item["friend_group_name"] +"</td>";
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
					if(page[index] != Number(res["current_page"])){
						list_arr +="<a href='#'  onclick='readInfo(" +  page[index] +")'> " + (' ' + page[index] + ' ')  + "</a>";
					}
					else{
						console.log(page[index]);
						list_arr +=" " +  (' ' + page[index] + ' ')  + " ";
					}				
				}

				

				if(res["end_page"]=="true"){
					console.log(res["end_page"]);
					list_arr += "<a href='#'  onclick='readInfo(" + (Number(res["current_page"]) + 1) +")'>"+ " > "+"</a>";
					list_arr += "<a href='#'  onclick='readInfo(" + (Number(res["total_page"])) +")'>" + ">>"+ "</a>";
				}

				document.getElementById('page_list').innerHTML = list_arr;	
			
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
  var updateButton = document.getElementById('update');
  var cancelButton = document.getElementById('cancel');
  var u_cancelButton = document.getElementById('u_cancel');
  var insertDialog = document.getElementById('insertDialog');
  var updateDialog = document.getElementById('updateDialog');
  var i_confirmButton = document.getElementById('i_confirm');
  var u_confirmButton = document.getElementById('u_confirm');




















  updateDialog.close();
  insertDialog.close();
  // Update button opens a modal dialog
  updateButton.addEventListener('click', function() {





	var allCheckBox = document.getElementsByName("LID");
	var allItemIndex = document.getElementsByName("item_idx");
	


		var item_idx= document.getElementsByName('item_idx');
		var friend_name = document.getElementsByName('friend_name');
		var friend_tell = document.getElementsByName('friend_tell');
		var friend_relationship= document.getElementsByName('friend_relationship');
		var friend_group_name= document.getElementsByName('friend_group_name');


	var request="";
	if(allCheckBox == null || allCheckBox == undefined)
		return;
	
	var cnt=0;
	var index=0;
	for(var i = 0; i < allCheckBox.length; i++){
		if(allCheckBox[i].checked){
			cnt++;
			index = i;
			console.log(item_idx[i].value);
			console.log(friend_name[i].innerHTML);
			console.log(friend_tell[i].innerHTML);
			console.log(friend_relationship[i].innerHTML);
			console.log(friend_group_name[i].innerHTML);
		}
	}
	if(cnt!=1 ){
		alert("체크박스를 한 개 체크해주세요.");
		return;
	}
	

document.getElementById('u_name').value = friend_name[index].innerHTML;
document.getElementById('u_tell').value = friend_tell[index].innerHTML;
document.getElementById('u_relation_ship').value = friend_relationship[index].innerHTML;
document.getElementById('u_idx').value = item_idx[index].value;

document.getElementById('u_name').innerHTML = friend_name[index].innerHTML;
document.getElementById('u_tell').innerHTML = friend_tell[index].innerHTML;
document.getElementById('u_relation_ship').innerHTML = friend_relationship[index].innerHTML;
document.getElementById('u_idx').innerHTML = item_idx[index].value;






    updateDialog.showModal();


		






















  });
  insertButton.addEventListener('click', function() {
    insertDialog.showModal();
  });

	i_confirmButton.addEventListener('click', function() {
		var i_name = encodeURI(document.getElementById('i_name').value);
		var i_tell = document.getElementById('i_tell').value;
		var i_relation_ship = encodeURI(document.getElementById('i_relation_ship').value);

		var i_group = JSON.parse(document.getElementById('group_data').value);

		var i_group_id = encodeURI(i_group["group_id"]);
		var i_group_name = encodeURI(i_group["group_name"]);
		//console.log(document.getElementById('i_group_id').value);
		//console.log(document.getElementById('i_group_id').innerHTML);

		var result = "";

		if(i_name == "" || i_tell=="" || i_relation_ship==""){
			result = "fail";
		}

		if(result != "fail"){
			alert("정상적으로 추가되었습니다.");
		}
		else{
			alert("정보가 정확하지 않습니다.");
		}

		var parmas = "user_id="+ "<%=user_id%>" +"&i_name="+i_name+"&i_tell="+i_tell+"&i_relation_ship="+i_relation_ship+"&i_group_id="+i_group_id + "&i_group_name="+i_group_name;

		var url = "<%= domain %>/contact/api/contact/create.jsp";
		insertDialog.close();
		console.log(url + "?" + parmas );

		var xmlhttp = new XMLHttpRequest();

		xmlhttp.onreadystatechange = function() {
			//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
		    if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
		       //alert(JSON.parse(xmlhttp.responseText)["result"]);
					 console.log(xmlhttp.responseText);
					 readInfo(1);
					setTimeLine();
		    }
		};
		// xmlhttp.open("GET", url, true);
		xmlhttp.open("POST",url,true);
		xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xmlhttp.send(parmas);
  });


	u_confirmButton.addEventListener('click', function() {
		var u_name = encodeURI(document.getElementById('u_name').value);
		var u_tell = document.getElementById('u_tell').value;
		var u_relation_ship = encodeURI(document.getElementById('u_relation_ship').value);

		var u_idx  = encodeURI(document.getElementById('u_idx').value);

		var u_group = JSON.parse(document.getElementById('u_group_data').value);

		var u_group_id = encodeURI(u_group["group_id"]);
		var u_group_name = encodeURI(u_group["group_name"]);
		
		var result = "";

		if(u_name == "" || u_tell=="" || u_relation_ship==""){
			result = "fail";
		}

		if(result != "fail"){
			alert("정상적으로 수정되었습니다.");
		}
		else{
			alert("정보가 정확하지 않습니다.");
		}

		var parmas = "user_id="+ "<%=user_id%>" +"&idx="+u_idx+"&u_name="+u_name+"&u_tell="+u_tell+"&u_relation_ship="+u_relation_ship+"&u_group_id="+u_group_id + "&u_group_name="+u_group_name;

		var url = "<%= domain %>/contact/api/contact/update.jsp";
		updateDialog.close();
		console.log(url + "?" + parmas );

		var xmlhttp = new XMLHttpRequest();

		xmlhttp.onreadystatechange = function() {
			//alert("readyState : " + xmlhttp.readyState + " status : " + xmlhttp.status);
		    if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
		       //alert(JSON.parse(xmlhttp.responseText)["result"]);
					 console.log("update : " + xmlhttp.responseText);
					 readInfo(1);
//					setTimeLine();
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

  // Form cancel button closes the dialog box
  u_cancelButton.addEventListener('click', function() {
    updateDialog.close();

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
	var url = "<%= domain %>/contact/api/contact/delete.jsp?contact_id=" + request;
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































groupInfo();
function groupInfo() {
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

					query+="  <option value='{\"group_id\": " +  item["idx"] + ", \"group_name\" : \""+ item["group_name"]+"\"}'> "+item['group_name']+"</option>";
				 }

			
				 var group_data= document.getElementById('group_data');
				 var u_group_data= document.getElementById('u_group_data');
				  group_data.innerHTML = query;
				  u_group_data.innerHTML = query;

			}
	};
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
};







function setTimeLine() {

	var i_name = encodeURI(document.getElementById('i_name').value);
	var i_tell = document.getElementById('i_tell').value;

	var xmlhttp = new XMLHttpRequest();
	
	var url = "<%= domain %>/contact/api/timeline/create.jsp?i_name="+i_name +"&i_tell="+i_tell;

	xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
				 //alert(JSON.parse(xmlhttp.responseText)["result"]);
				 console.log("readInfo() response");
				 console.log(xmlhttp.responseText);
				 var res = JSON.parse(xmlhttp.responseText);


				 var query="";
				 for(var item of res["result"]){
					// console.log(item["user_id"]);

					query+="  <option value='{\"group_id\": " +  item["idx"] + ", \"group_name\" : \""+ item["group_name"]+"\"}'> "+item['group_name']+"</option>";
				 }

			
				 var group_data= document.getElementById('group_data');
				  group_data.innerHTML = query;

			}
	};
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
};





</script>
</html>
