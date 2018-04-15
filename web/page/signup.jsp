<%@ page pageEncoding="utf-8" %>
<%@ include file="../../constant.jsp"%>
<!DOCTYPE html>
<html lang="en-us">
<head>
	<!--  App Title  -->
	<title>회원가입</title>
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
function pwdCheck(){
	var pwd = document.getElementById('user_pw').value;
	var pwd2 = document.getElementById('pwdchk_in').value;
	console.log("hello")
	if(pwd2==""){

		document.getElementById('confirm_msg').innerHTML="비밀번호를 다시 입력해 주세요.";
		//document.getElementById('confirm').value = "비밀번호를 다시 입력해 주세요.";
		//document.getElementByID('confirm').setAttribute('style','color:green');
		document.getElementById('confirm-msg').style.color="green";
	}
	else if(pwd==pwd2){
		document.getElementById('confirm_msg').innerHTML="비밀번호가 일치합니다.";
		//document.getElementByID('confirm').setAttribute('style','color:blue');
		document.getElementById('confirm_msg').style.color="blue";
	}
	else{
		document.getElementById('confirm_msg').innerHTML="비밀번호가 일치하지 않습니다.";
		//document.getElementByID('confirm').setAttribute('style','color:red');
		document.getElementById('confirm_msg').style.color="red";
	}
};

function check() {
	var id = document.getElementById('user_id').value;
	var result = document.getElementById('id_confirm');
	var xmlhttp = new XMLHttpRequest();
	var url = "INSERT SERVER URL:8080/contact/api/member/duplication.jsp?user_id=";
	url+=id;
	console.log("check() 진입");
	xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4 && xmlhttp.status ==200) {
				 console.log("check() response");
				 var res = JSON.parse(xmlhttp.responseText);
				 var query="";
				 var contact_data = document.getElementById('contact_data');
				result.innerHTML = res["message"];
			}
	};
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
};

function pop(){
	alert("환영합니다! 회원가입이 완료되었습니다.");
};


</script>
</head>
<body>

<%@ include file="../header.jsp"%>

<div
	style="margin-top: 100px;
	margin-bottom: 100px;
	margin-right: 150px;
	margin-left: 80px;"
>
<form
	method="post"
	action="INSERT SERVER URL:8080/contact/api/member/create.jsp">
	이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" id="user_name" name="user_name" size="10">
<br>
<br>
	아 이 디
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" id="user_id" name ="user_id" size="10">
	&nbsp;&nbsp;&nbsp;
	<input type="button"  value="중복확인" onclick="check()"/>
	<a id = "id_confirm"></a>
<br>
<br>

	비밀번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="password" id="user_pw" name="user_pw" size="10" maxlength=20>
	&nbsp;<a>특수문자를 반드시 포함하여 6자 이상 20자 미만으로 작성</a>
<br>
<br>

	비밀번호확인&nbsp;
	<input type="password" id="pwdchk_in" size="10"
	maxlength=20 "
	onkeyup="pwdCheck()">
	&nbsp;<a id="confirm_msg">비밀번호를 다시 입력해 주세요.</a>
<br>
<br>

	전화번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<select name="m1">
		<option value=" ">select</option>
		<option value="010">010</option>
		<option value="011">011</option>
		<option value="016">016</option>
		<option value="018">018</option>
		<option value="019">019</option>
	</select> -
	<input type="text" size=4 name="m2" maxlength=4 pattern="[0-9]{4}"/> -
	<input type="text" size=4 name="m3" maxlength=4 pattern="[0-9]{4}"/>
	<br />

<br>
<br>
	주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" id="user_address" size="40">
<br>
<input type="submit" value="가    입" size="10" onclick="pop()">
</form>
</div>
<%@ include file="../footer.jsp"%>

</body>
</html>
