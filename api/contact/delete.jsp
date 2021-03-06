<%@ include file="../config.jsp"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.*, java.text.*"  %>
<%
/*
* 연락처 삭제 API
* Method : POST
*/
request.setCharacterEncoding("UTF-8");

int rs=-1;
PreparedStatement pstmt=null;

String user_id= request.getParameter("user_id");
if(user_id==null)
	user_id = (String)session.getAttribute("user_id");
String contact_id_list = request.getParameter("contact_id");


SimpleDateFormat formatter = new java.text.SimpleDateFormat("yy.MM.dd HH:mm:ss");
String remove_time= formatter.format(new java.util.Date());


try{
	JSONObject job = new JSONObject();
	String sql = "UPDATE contact SET isTrash='true', remove_time='"+remove_time+"' WHERE user_id = '" + user_id + "' AND idx in (" + contact_id_list + ")";
		out.println(sql );
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeUpdate();

	if(rs >= 1){
	job.put("result", "success");
	}else{
	job.put("result", "fail");
	}	
	out.println(job .toJSONString());
}catch(Exception e){
	// 예외가 발생하면 예외 상황을 처리한다.
	e.printStackTrace();
	out.println("{'result' : 'error', 'message':"+e+"}");
}finally{
	// 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
	if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
	if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
}




%>