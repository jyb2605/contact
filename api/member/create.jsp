<%@ include file="../config.jsp"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.*, java.text.*"  %>
<%
/*
* 멤버 추가 API
* Method : POST
*/
request.setCharacterEncoding("UTF-8");

int rs=-1;
PreparedStatement pstmt=null;

String user_id = request.getParameter("user_id");
String user_name= request.getParameter("user_name");
String user_pw = request.getParameter("user_pw");
String m1 = request.getParameter("m1");
String m2 = request.getParameter("m2");
String m3 = request.getParameter("m3");
String user_tell = m1+m2+m3;

String user_address = request.getParameter("user_address");



SimpleDateFormat formatter = new java.text.SimpleDateFormat("yy.MM.dd HH:mm:ss");
String created_time= formatter.format(new java.util.Date());

try{
	JSONObject job = new JSONObject();
	String sql = "INSERT INTO member (user_id, user_pw, user_name, user_tell, user_address, created_time)" +
"  VALUES ('"+user_id +"', '" + user_pw+ "' , '" + user_name+ "', '" + user_tell+ "', '" + user_address+ "' , '" + created_time + "');";
//		out.println(sql );
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeUpdate();




	sql = "INSERT INTO `group` (user_id, group_name, created_time)  VALUES ('"+user_id +"', '내 연락처' , '" + created_time + "');";
		out.println(sql );
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeUpdate();


	if(rs == 1){
		job.put("result", "success");
		response.sendRedirect("INSERT SERVER URL:8080/contact/web/page/index.jsp");
	}else{
		job.put("result", "fail");
		response.sendRedirect("INSER SERVER URL:8080/contact/web/page/contact.jsp");
	}

	out.println(job .toJSONString());
}catch(Exception e){
	// 예외가 발생하면 예외 상황을 처리한다.
	e.printStackTrace();
	out.println("{'result' : 'error', 'message' : "+e+"}");
}finally{
	// 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
	if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
	if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
}




%>
