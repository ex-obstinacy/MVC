<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>※ 상영관 등록</h3>
<form action="cinemaInsertPro.jsp" method="post" id="cinema_fr">
	지역 : 
	<select name="local" id="local">
		<option value="">지역을 선택하세요.</option>
		<option value="서울">서울</option>
		<option value="경기">경기</option>
		<option value="인천">인천</option>
		<option value="강원">강원</option>
		<option value="대전/충청">대전/충청</option>
		<option value="대구">대구</option>
		<option value="부산">부산</option>
		<option value="경상">경상</option>
		<option value="광주/전라/제주">광주/전라/제주</option>
	</select><br><br>
	상영관 명 : 
	<input type="text" name="name" id="name">
	<input type="submit" value="등록">
</form>
</body>
</html>