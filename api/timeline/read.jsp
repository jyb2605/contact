<%@ include file="../config.jsp"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%
/*
* 타임라인 조회 API
* Method : GET
*/

request.setCharacterEncoding("UTF-8");

String user_id= request.getParameter("user_id");
if(user_id==null)
	user_id = (String)session.getAttribute("user_id");

ResultSet rs=null;
PreparedStatement pstmt=null;
try{
	JSONArray result = new JSONArray();
	JSONObject job = new JSONObject();


	String order_by_query = "ORDER BY idx DESC";

	
	String where_query="Where user_id = '" + user_id + "' ";



	String sql = "Select `member`.user_name , `member`.user_tell, `contact`.created_time from `member`, contact where `member`.user_id in (select stranger_id from request Where user_id = '"+user_id+"') AND `contact`.friend_name = '"+user_id+"'";

	//out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();


	while(rs.next()){
		String user_name = rs.getString("user_name");
		String user_tell = rs.getString("user_tell");
		String created_time = rs.getString("created_time");
		job = new JSONObject();

		job.put("created_time", created_time);
		job.put("user_tell", user_tell);
		job.put("user_name", user_name);
		result.add(job);
	}
	
	//out.println("id : " + id + ", name : " + name + ", address : " + address +"<br>");
	out.println(result.toJSONString());

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

