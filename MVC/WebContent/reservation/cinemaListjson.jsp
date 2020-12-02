<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
Class.forName("com.mysql.jdbc.Driver");

String dbUrl = "jdbc:mysql://localhost:3306/practice";
String dbUser = "root";
String dbPass= "1234";
Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

String sql = "select * from cinema order by local";
PreparedStatement ps = con.prepareStatement(sql);

ResultSet rs = ps.executeQuery();

JSONArray cinemaList = new JSONArray();

while(rs.next()) {
	JSONObject jo = new JSONObject();
	jo.put("cinema_name", rs.getString("name"));
	// local의 앞 2글자만 추출해서 저장
	String slocal = rs.getString("local").substring(0, 2);
	jo.put("cinema_local", slocal);
	
	cinemaList.add(jo);
}
%>

<%=cinemaList %>