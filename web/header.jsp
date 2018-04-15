<%@ page pageEncoding="utf-8"%>

<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");


%>
<script>
function goto(){
	location.href="insert server url:8080/contact/web/page/signup.jsp";

}
</script>

<!--  Header Section  -->
<header>
	<div class="container">
		<div class="logo pull-left animated wow fadeInLeft">
			<!--<img src="img/logo.png" width="30" height="30" alt="" title="">-->
		</div>


		<div class="social pull-right">
			<div>
				<div class="login">
					<form method="post" action="insert server url/contact/api/member/login.jsp">

						<div class="form-group animated wow fadeInLeft" id="submit_form">
							<input type="text" class="form-control" name="user_id" value=""
								placeholder="Email" style="display: inline-block; width: 30%;">
							&nbsp
							<input type="password" class="form-control" name="user_pw"
								value="" placeholder="Password"
								style="display: inline-block; width: 30%;">
							 <input type="submit" class="form-control" name="commit" value="Login"
								style="display: inline-block; width: 15%;"> <input
								type="button" class="form-control" name="commit" value="Sign up"
								style="display: inline-block; width: 15%;" onclick="goto()" >
						</div>




					</form>
				</div>
			</div>

		</div>

		<span class="burger_icon">menu</span>
	</div>
</header>
<!--  End Header Section  -->
