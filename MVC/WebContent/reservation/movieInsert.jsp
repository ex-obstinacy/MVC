<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 지역 선택 -> 상영관 선택
		$('#local').change(function() {
			if($('#local>option:selected').val() == "서울") {
				// 서울 상영관만 뜨게하기
				$('#cname>option:first').remove();
				$('#cname').append("<option value='강남점'>강남점</option>");
				$(this).unbind();
			} else if($('#local>option:selected').val() == "부산") {
				// 부산 상영관만 뜨게하기
				$('#cname>option:first').remove();
				$('#cname').append("<option value='서면점'>서면점</option>");
				$('#cname').append("<option value='사상점'>사상점</option>");
				$(this).unbind();
			}
		});
		// 날짜 선택 -> 시간 선택
		$('#date').change(function() {
			$('#time>option:first').remove();
			$('#time').append("<option value='13:00'>[1관]13:00</option>");
			$('#time').append("<option value='16:00'>[2관]16:00</option>");
			$('#time').append("<option value='20:00'>[1관]20:00</option>");
			$('#time').append("<option value='22:00'>[2관]22:00</option>");
			$(this).unbind();
		});
	});
	
	
</script>
</head>
<body>
<h3>※ 영화 등록</h3>
<form action="movieInsertPro.jsp" method="post" id="movie_fr">
	영화제목 : 		<!-- 현재 상영중인 영화 API로 제목 selectbox로 가져오기 -->
	<input type="text" name="subject" id="subject"><br>
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
	</select>
	상영관 : 
	<select name="cinema_name" id="cinema_name">
		<option value="">상영관을 선택하세요.</option>
	</select>
	상영날짜 : 
	<input type="date" name="date" id="date">
	상영시간 : 
	<input type="text" name="time" id="time"><br>
	<input type="submit" value="등록">
</form>
</body>
</html>