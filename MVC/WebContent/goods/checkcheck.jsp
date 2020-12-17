<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String[] checkRow = request.getParameterValues("checkRow");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>확인용 페이지</h1>
<%
for(String check: checkRow) {
	out.println("체크된 basketId : "+check+"<br>");
}
%>
</body>
</html>