<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String movie = request.getParameter("movie");
String local = request.getParameter("local");
String cinema = request.getParameter("cinema");
String date = request.getParameter("date");
String time = request.getParameter("time");

int movie_num = 0;

Class.forName("com.mysql.jdbc.Driver");

String dbUrl = "jdbc:mysql://localhost:3306/practice";
String dbUser = "root";
String dbPass= "1234";
Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

String sql = "select num from admin_reservation where movie_subject=? and cinema_name=? and showdate=? and showtime=?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, movie);
ps.setString(2, cinema);
ps.setString(3, date);
ps.setString(4, time);

ResultSet rs = ps.executeQuery();
if(rs.next()) {
	movie_num = rs.getInt("num");
}
%>

영화 등록 번호 : <%=movie_num %><br>
영화 : <%=movie %> <br>
지역 : <%=local %> <br>
영화관 : <%=cinema %> <br>
날짜 : <%=date %> <br>
시간(관) : <%=time %><br>
</body>
</html>