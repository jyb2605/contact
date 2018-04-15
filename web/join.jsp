<%@ page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
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
<title>Insert title here</title>
<script>
function pwdCheck(){
	var pwd = document.getElementById('pwd_in').value;
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
}
</script>
</head>
<body>
<form method="get" action="#">
<div id="name">
	이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" id="name_in" size="10">
</div>
<div id="id">
	아 이 디
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" id="id_in" size="10">
	&nbsp;&nbsp;&nbsp;
	<button type="button" onclick="duplication_check()">중복 확인</button>
</div>
<div id="pwd">
	비밀번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="password" id="pwd_in" size="10" maxlength=20 pattern="[A-Za-z0-9@#$%^&*]{6,20}">
	<a>특수문자를 반드시 포함하여 6자 이상 20자 미만으로 작성</a>
</div>
<div id="pwd_chk">
	비밀번호 확인
	<input type="password" id="pwdchk_in" size="10" 
	maxlength=20 pattern="[A-Za-z0-9@#$%^&*]{6,20}"
	onkeyup="pwdCheck()">
	<a id="confirm_msg">비밀번호를 다시 입력해 주세요.</a>
</div>
<div id="p_num">
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
</div>
<div id="addr">
	주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" id="addr_in" size="40">
</div>
<input type="submit" value="가    입" size="10">
</form>
</body>
</html>