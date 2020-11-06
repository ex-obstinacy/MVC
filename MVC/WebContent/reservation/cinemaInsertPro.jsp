<%@page import="cinema.CinemaDAO"%>
<%@page import="cinema.CinemaBean"%>
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

String name = request.getParameter("name");
String local = request.getParameter("local");

CinemaBean cb = new CinemaBean();
cb.setName(name);
cb.setLocal(local);

CinemaDAO cdao = new CinemaDAO();
cdao.insertMovie(cb);

response.sendRedirect("cinemaInsert.jsp");
%>
</body>
</html>