<%@ include file="../config.jsp"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.*, java.text.*"  %>
<%
/*
* 타임라인 추가 API
* Method : POST
*/
request.setCharacterEncoding("UTF-8");

ResultSet rs=null;
PreparedStatement pstmt=null;

String user_id = request.getParameter("user_id");
if(user_id==null)
	user_id = (String)session.getAttribute("user_id");
String user_name= request.getParameter("i_name");
String user_tell = request.getParameter("i_tell");

SimpleDateFormat formatter = new java.text.SimpleDateFormat("yy.MM.dd HH:mm:ss");
String created_time= formatter.format(new java.util.Date());

try{
	JSONObject job = new JSONObject();


	String sql = "select * from member where user_name = '" + user_name +"' AND user_tell = '"+ user_tell + "'";
	//out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	int rowCnt = 0;
	String stranger_id="";
	if(rs.next()){ rowCnt = rs.getInt(1);  stranger_id = rs.getString("user_id");}

	if(rowCnt  >= 1){
		//멤버 존재
		job.put("result", "success");
	





	sql = "INSERT INTO request (user_id, stranger_id)" +
"  VALUES ('"+stranger_id+"', '"+user_id +"');";
//		out.println(sql );
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();

	}else{
		//멤버 없음
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




%>