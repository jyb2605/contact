<%@ include file="../config.jsp"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%
/*
* 휴지통 조회 API
* Method : GET
*/

request.setCharacterEncoding("UTF-8");

String user_id= request.getParameter("user_id");
if(user_id==null)
	user_id = (String)session.getAttribute("user_id");

int current_page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : -1;


if(current_page == -1)
	current_page = 1;

String search_type= request.getParameter("search_type");
if(search_type==null)
	search_type="이름";
	
String search_input= request.getParameter("search_input");
if(search_input==null)
	search_input="";


if(user_id==null)
	user_id = (String)session.getAttribute("user_id");

ResultSet rs=null;
PreparedStatement pstmt=null;
try{
	JSONArray result = new JSONArray();
	JSONObject job = new JSONObject();


	String order_by_query = "ORDER BY idx DESC";

	
	String where_query="Where user_id = '" + user_id + "' AND isTrash='true' AND ";

	switch(search_type){
		case "name":
			where_query += "friend_name like '%" + search_input + "%'";
			break;
		case "tell":
			where_query += "friend_tell like '%" + search_input + "%'";
			break;
		case "group":
			where_query += "friend_group_name like '%" + search_input + "%'";
			break;
	}
	int page_cnt = 5; //한꺼번에 출력할 리스트의 갯수
	String sql = "select count(*) from contact " + where_query;
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	// get the number of rows from the result set
	int total_cnt = 0;
	if(rs.next()) total_cnt = rs.getInt(1);
	int total_page = (int) Math.ceil((double) total_cnt /(double) page_cnt );

	//out.println(sql +"<br>");	
	//out.println("total_cnt : " + total_cnt +"<br>");
	//out.println("totalpage : " + total_page +"<br>");
	sql = "select * from contact " + where_query + " " + order_by_query + " LIMIT " + (current_page -1) * page_cnt + " , " + page_cnt;
	//out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();




	//out.println(total_page);

	JSONObject res = getPage(current_page , total_page );
	res.put("total_page", total_page);
	//out.println(res);
	





	while(rs.next()){
		String idx = rs.getString("idx");
		user_id = rs.getString("user_id");
		String friend_name = rs.getString("friend_name");
		String friend_tell = rs.getString("friend_tell");
		String friend_relationship = rs.getString("friend_relationship");
		String friend_group_id = rs.getString("friend_group_id");
		String isTrash = rs.getString("isTrash");
		String created_time = rs.getString("created_time");
		String remove_time = rs.getString("remove_time");


		job = new JSONObject();
		job.put("idx", idx);
		job.put("user_id", user_id);
		job.put("friend_name", friend_name);
		job.put("friend_tell", friend_tell);
		job.put("friend_relationship", friend_relationship);
		job.put("friend_group_id", friend_group_id);
		job.put("isTrash", isTrash);
		job.put("created_time", created_time);
		job.put("remove_time", remove_time);

		result.add(job);

	}
	res.put("result", result);
	
	//out.println("id : " + id + ", name : " + name + ", address : " + address +"<br>");
	out.println(res.toJSONString());

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

<%!
public JSONObject getPage(int currentPage, int totalPage) {
	String getParm="";
	
	JSONObject job = new JSONObject();
	JSONArray jarr = new JSONArray();

	String str = "";
	if (currentPage > 1) {
		str += "<a href='javascript:void(0)'><<&nbsp;&nbsp;</a>";
		str += "<a href='javascript:void(0)'><&nbsp;&nbsp;</a>";

		job.put("start_page", "true");
	}else{
		job.put("start_page", "false");
	}

	
	int start_page = currentPage - 2;
	
	if ((currentPage - 1) <= 0) {
		start_page = currentPage;

	} else if ((currentPage - 2) <= 0) {
		start_page = currentPage - 1;

	}
	
	int end_page = currentPage + 2;


	if (end_page >= totalPage)
		end_page = totalPage;



	if (totalPage > 1) {


		for(int k = start_page; k <= end_page; k ++) {
			if (currentPage != k){
				str += " &nbsp;<a href='javascript:void(0)'><span>"+k+"</span></a>";
				
				jarr.add(k);
			}
			else{
				str += " &nbsp;<strong style='color:#ed1c24;'>"+k+"</strong> ";
				job.put("current_page", k);
				jarr.add(k);
			}
		}
	}

	job.put("page_list", jarr);


	if (currentPage < totalPage) {
		str+= "<a href='javascript:void(0)'>&nbsp;&nbsp;></a>";
		str += "<a href='javascript:void(0)'>&nbsp;&nbsp;>></a>";

		job.put("end_page", "true");
	}else{
		job.put("end_page", "false");
	}

	str += "";
	return job;
}
%>