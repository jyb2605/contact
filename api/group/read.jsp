<%@ include file="../config.jsp"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%
/*
* 그룹 조회 API
* Method : GET
*/

request.setCharacterEncoding("UTF-8");

String user_id= request.getParameter("user_id");
if(user_id==null)
	user_id = (String)session.getAttribute("user_id");

int current_page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : -1;


if(current_page == -1)
	current_page = 1;

if(user_id==null)
	user_id = (String)session.getAttribute("user_id");

ResultSet rs=null;
PreparedStatement pstmt=null;

ResultSet rs2=null;
PreparedStatement pstmt2=null;
try{
	JSONArray result = new JSONArray();
	JSONObject job = new JSONObject();


	String order_by_query = "ORDER BY idx DESC";	
	String where_query="Where user_id = '" + user_id + "'";




















	int page_cnt = 10; //한꺼번에 출력할 리스트의 갯수
	String sql = "select count(*) from `group` " + where_query;
//	out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	int total_cnt = 0;
	if(rs.next()) total_cnt = rs.getInt(1);

//	out.println("total_cnt : " + total_cnt + "<br/>");


	// get the number of rows from the result set

//	if(rs.next()) total_cnt = rs.getInt(1);
	int total_page = (int) Math.ceil( total_cnt / page_cnt );
//	out.println("total_page : " + total_page + "<br/>");

	//out.println(sql +"<br>");	
	//out.println("total_cnt : " + total_cnt +"<br>");
	//out.println("totalpage : " + total_page +"<br>");




	sql = "select *, (select count(*) from contact where `group`.idx = `contact`.friend_group_id  AND isTrash ='false') AS `members_cnt` from `group` " + where_query + "  " + order_by_query + " LIMIT " + (current_page -1) * page_cnt + " , " + page_cnt;
	//out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();





















	//out.println(total_page);

	JSONObject res = getPage(current_page , total_page );
	res.put("total_page", total_page);
	//out.println(res);
	




	String friends_name = "";
	while(rs.next()){
		String idx = rs.getString("idx");
		user_id = rs.getString("user_id");
		String group_name = rs.getString("group_name");
		String members_cnt = rs.getString("members_cnt");


		job = new JSONObject();
		job.put("idx", idx);
		job.put("user_id", user_id);
		job.put("group_name", group_name);
		job.put("members_cnt", members_cnt);


		friends_name = "";
		sql = "select friend_name from contact "+where_query+" AND isTrash ='false' AND  friend_group_id = " + idx;


		pstmt2 = conn.prepareStatement(sql);

		rs2 = pstmt2.executeQuery();

		while(rs2.next()){

			friends_name += rs2.getString("friend_name") + " ";

		}
		friends_name = friends_name.length() >100 ? friends_name.substring(0, 100) + "..." : friends_name;
		
		job.put("friends_name", friends_name);

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

		job.put("end_page", "true");
	}else{
		job.put("end_page", "false");
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

		job.put("start_page", "true");
	}else{
		job.put("start_page", "false");
	}

	str += "";
	return job;
}
%>