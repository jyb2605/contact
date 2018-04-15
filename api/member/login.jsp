<%@ include file="../config.jsp"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%
/*
* 로그인 API
* Method : POST
*/

request.setCharacterEncoding("UTF-8");

String user_id = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");



ResultSet rs= null;
PreparedStatement pstmt=null;
try{
	JSONObject job = new JSONObject();
	String sql = "select * from member where user_id = '" + user_id +"' AND user_pw = '"+ user_pw + "'";
//	out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	int rowCnt = 0;
	if(rs.next()) rowCnt = rs.getInt(1);

	if(rowCnt  >= 1){
		job.put("result", "success");
		session.setAttribute("user_id", user_id);
		response.sendRedirect("INSERT SERVER URL:8080/contact/web/page/contact.jsp");

	}else{
		job.put("result", "fail");
		response.sendRedirect("INSERET SERVER URL:8080/contact/web/page/index.jsp?result=fail");
	}


	out.println(job.toJSONString());

}catch(Exception e){
	// 예외가 발생하면 예외 상황을 처리한다.
	e.printStackTrace();
	out.println(e);
//	out.println("{'result' : 'error'}");
}finally{
	// 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
	if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제
	if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
	if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
}
%>
