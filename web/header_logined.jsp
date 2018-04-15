<%@ page pageEncoding="utf-8"%>

<%
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
if (request.getProtocol().equals("HTTP/1.1")) 
        response.setHeader("Cache-Control", "no-cache");


%>
<!--  Header Section  -->
<header>
	<div class="container">
		<div class="logo pull-left animated wow fadeInLeft">
			<!--<img src="img/logo.png" width="30" height="30" alt="" title="">-->
		</div>


		<nav class="pull-left">
			<ul class="list-unstyled">
				<li class="animated wow fadeInLeft" data-wow-delay="0s">
					<a href="<%= domain %>/contact/web/page/contact.jsp">연락처</a></li>
				<li class="animated wow fadeInLeft" data-wow-delay=".1s"><a
					href="<%= domain %>/contact/web/page/trashcan.jsp">휴지통</a></li>
				<li class="animated wow fadeInLeft" data-wow-delay=".2s"><a
					href="<%= domain %>/contact/web/page/timeline.jsp">타임라인</a></li>
				<li class="animated wow fadeInLeft" data-wow-delay=".3s"><a
					href="<%= domain %>/contact/web/page/group.jsp">그룹</a></li>
				<li class="animated wow fadeInLeft" data-wow-delay=".3s"><a
					href="<%= domain %>/contact/web/page/index.jsp">로그아웃</a></li>
			</ul>
		</nav>


		<span class="burger_icon">menu</span>
	</div>
</header>
<!--  End Header Section  -->
