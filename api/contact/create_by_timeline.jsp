<%@ include file="../config.jsp"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.*, java.text.*"  %>
<%
/*
* 연락처 추가 API2
* Method : POST
*/
request.setCharacterEncoding("UTF-8");

ResultSet rs= null;
PreparedStatement pstmt=null;

String user_id= request.getParameter("user_id");
if(user_id==null)
	user_id = (String)session.getAttribute("user_id");
String user_name= request.getParameter("user_name");


SimpleDateFormat formatter = new java.text.SimpleDateFormat("yy.MM.dd HH:mm:ss");
String created_time= formatter.format(new java.util.Date());

if(false){
//	out.println("{'result' : '빈 칸이 있습니다.'}");
}else{
try{
	JSONObject job = new JSONObject();




	String sql = "select * from member where user_name='"+user_name + "'";	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.next();
	rs.getString("user_id");
	;
	;
	;




//		out.println(sql );
	sql = "INSERT INTO contact (user_id, friend_name, friend_tell, friend_relationship, friend_group_id,  friend_group_name, created_time)" +
"  VALUES ('"+user_id +"', '" + rs.getString("user_name") + "' , '" + rs.getString("user_tell")+ "', '나를 추가한 사람', (select idx from `group` where user_id = '"+user_id+"' AND group_name = '내 연락처') , '내 연락처','" + created_time + "');";
//		out.println(sql );
	pstmt = conn.prepareStatement(sql);
	int rs_cnt = pstmt.executeUpdate();

	if(rs_cnt == 1){
	job.put("result", "success");
	}else{
	job.put("result", "fail");
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
}



%>