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

String sql = "select distinct movie_subject from admin_reservation";
PreparedStatement ps = con.prepareStatement(sql);

ResultSet rs = ps.executeQuery();

JSONArray movieList = new JSONArray();

while(rs.next()) {
	JSONObject jo = new JSONObject();
	jo.put("movie_subject", rs.getString("movie_subject"));
// 	jo.put("movie_num", rs.getInt("num"));
	
	movieList.add(jo);
}
%>

<%=movieList %>