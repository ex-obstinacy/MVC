<%@page import="reservation.ReservationDAO"%>
<%@page import="reservation.ReservationBean"%>
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

String subject = request.getParameter("subject");
String local = request.getParameter("local");
String cinema_name = request.getParameter("cinema_name");
String date = request.getParameter("date");
String time = request.getParameter("time");

ReservationBean rb = new ReservationBean();
rb.setSubject(subject);
rb.setLocal(local);
rb.setCinema_name(cinema_name);
rb.setDate(date);
rb.setTime(time);

ReservationDAO rdao = new ReservationDAO();
rdao.insertMovie(rb);

response.sendRedirect("movieInsert.jsp");
%>
location.reload();
</body>
</html>