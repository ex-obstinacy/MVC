<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
LocalDate today = LocalDate.now();

// session 객체에 저장된 id 값 가져와서 변수에 저장
String id = (String)session.getAttribute("id");

// 영화코드 가져와서 변수에 저장
String movieCd = request.getParameter("movieCd");
System.out.println("영화코드 : " + movieCd);
%>
<html lang="zxx">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>MVC</title>
  <link rel="icon" href="img/favicon.png">
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <!-- animate CSS -->
  <link rel="stylesheet" href="css/animate.css">
  <!-- owl carousel CSS -->
  <link rel="stylesheet" href="css/owl.carousel.min.css">
  <!-- nice select CSS -->
  <link rel="stylesheet" href="css/nice-select.css">
  <!-- font awesome CSS -->
  <link rel="stylesheet" href="css/all.css">
  <!-- flaticon CSS -->
  <link rel="stylesheet" href="css/flaticon.css">
  <link rel="stylesheet" href="css/themify-icons.css">
  <!-- font awesome CSS -->
  <link rel="stylesheet" href="css/magnific-popup.css">
  <!-- swiper CSS -->
  <link rel="stylesheet" href="css/slick.css">
  <link rel="stylesheet" href="css/price_rangs.css">
  <!-- style CSS -->
  <link rel="stylesheet" href="css/style.css">
<!--   <link rel="stylesheet" href="css/reservation.css" type="text/css"> -->
  <link rel="stylesheet" href="css/common.css">
  <link rel="stylesheet" href="css/sub.css">
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 등록되어있는 영화목록 가져오기
		$.getJSON('MovieListJson.re', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdsubject').append("<li class='"+item.movie_code+"'><input type='radio' name='movie' id='"+item.movie_code+"' value='"+item.movie_subject+"' class='rmovie "+item.movie_code+"'/><label for='"+item.movie_code+"'>"
						+"<span id='span_r1' class='g"+item.movie_grade+"'>"+item.movie_grade+"</span><span id='span_r2'>"+item.movie_subject+"</span></label></li>");
			});
			
			// 영화상세페이지 - 예매 로 넘어올 경우 해당 영화 선택되어있게하기
			if($('#tdsubject > li > input').hasClass(<%=movieCd%>)) {
				$('#tdsubject > li > input.'+<%=movieCd%>).prop("checked", true);
			}
		});
		// cinema 목록 db에서 가져오기(admin_reserve랑 동일)
		$.getJSON('CinemaListJson.re', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdcinema').append("<li class='cdiv reserveNo "+item.cinema_local+" "+item.cinema_name+"'><input type='radio' name='cinema' id='"+item.cinema_name+"' value='"+item.cinema_name+"' class='rcinema "+item.cinema_name+"'/><label for='"+item.cinema_name+"'>"+item.cinema_name+"</label></li>");
			});
			// 서울-강남점, 부산-서면점 만 오픈함
			if($('#tdcinema li').hasClass('강남') || $('#tdcinema li').hasClass('서면') || $('#tdcinema li').hasClass('MVC영화관')) {
				$('#movieform > table td>ul#tdcinema li.강남').removeClass('reserveNo');
				$('#movieform > table td>ul#tdcinema li.서면').removeClass('reserveNo');
				$('#movieform > table td>ul#tdcinema li.MVC영화관').removeClass('reserveNo');
			}
			// 오픈안한 영화관은 클릭안됨
			$('#movieform > table td>ul#tdcinema li.reserveNo').click(function() {
				$('#tdcinema input').prop("checked", false);
				$('#tddate input').prop("checked", false);
				$('#tdtime input').prop("checked", false);
				$('#tdtime .tdiv').removeClass('show');
			});
		});
		// showtime 목록 db에서 가져오기
		$.getJSON('TimeListJson.re', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdtime').append("<li class='tdiv "+item.movie_code+" "+item.cinema_name+" "+item.showdate+"'><input type='radio' name='time' id='"+item.movie_code+"/"+item.cinema_name+"/"+item.showdate+"/"+item.showtime+"' value='"+item.showtime+
						"' class='rtime'/><label for='"+item.movie_code+"/"+item.cinema_name+"/"+item.showdate+"/"+item.showtime+"'>"
						+item.showtime_t+" "+item.showtime_g+"</label></li>");
			});
		});
		
		
		// 지역 선택
		$('#tdlocal input').click(function() {
			if($('.rmovie').is(":checked") == false) {
				alert("영화를 선택하세요.");
				$(this).prop("checked", false);
			} else {
				// 지역별로 상영관 출력
				var local_id = $(this).attr('id');
				$('#tdcinema .cdiv').removeClass('show');
				$('#tdcinema .'+local_id).addClass('show');
			}
		});
		
		// 날짜 선택
		$('#tddate input').click(function() {
			if($('.rcinema').is(":checked") == false) {
				alert("영화관을 선택하세요.");
				$(this).prop("checked", false);
				$('.rtime').prop("checked", false);
			} else {
				var movie_id = $('#tdsubject input[name="movie"]:checked').attr('id');
				var cinema_id = $('#tdcinema input[name="cinema"]:checked').attr('id');
				var date_id = $(this).attr('id');
				if($('#tdtime li').hasClass(movie_id+' '+cinema_id+' '+date_id)) {
					$('#tdtime .tdiv').removeClass('show');
					$('#tdtime .'+movie_id+'.'+cinema_id+'.'+date_id).addClass('show');
					$('#tdtime li.notimelist').addClass('noshow');
				} else {
					$('#tdtime .tdiv').removeClass('show');
					$('#tdtime li.notimelist').removeClass('noshow');
				}
			}
		});
		// 날짜는 3일뒤까지만 예약 가능
		$('#movieform > table td>ul#tddate li').addClass('reserveNo');
		$('#movieform > table td>ul#tddate li:nth-child(1)').removeClass('reserveNo');
		$('#movieform > table td>ul#tddate li:nth-child(2)').removeClass('reserveNo');
		$('#movieform > table td>ul#tddate li:nth-child(3)').removeClass('reserveNo');
		$('#movieform > table td>ul#tddate li:nth-child(4)').removeClass('reserveNo');
		
		$('#movieform > table td>ul#tddate li.reserveNo').click(function() {
			alert("예매하실 수 없는 날짜입니다.")
			$('#tddate input').prop("checked", false);
			$('#tdtime input').prop("checked", false);
			$('#tdtime .tdiv').removeClass('show');
		});
		
// 		필수 조건
		$('#movieform').submit(function() {
			if($('.rmovie').is(":checked") == false) {
				alert("영화를 선택해주세요.");
				$('.rmovie').focus();
				return false;
			}
			if($('.rlocal').is(":checked") == false) {
				alert("지역을 선택해주세요.");
				$('.rlocal').focus();
				return false;
			}
			if($('.rcinema').is(":checked") == false) {
				alert("영화관을 선택해주세요.");
				$('.rcinema').focus();
				return false;
			}
			if($('.rdate').is(":checked") == false) {
				alert("날짜를 선택해주세요.");
				$('.rdate').focus();
				return false;
			}
			if($('.rtime').is(":checked") == false) {
				alert("시간을 선택해주세요.");
				$('.rtime').focus();
				return false;
			}
			if(<%=id%> == null) {
				alert("로그인이 필요합니다.");
				location.href = "MemberLogin.me";
				return false;
			}
		});
		
		// 상위항목 체크할 때 마다 하위항목 리셋
		$('#tdsubject').click(function() {
			$('#tdlocal input').prop("checked", false);
			$('#tdcinema input').prop("checked", false);
			$('#tdcinema .cdiv').removeClass('show');
			$('#tddate input').prop("checked", false);
			$('#tdtime input').prop("checked", false);
			$('#tdtime .tdiv').removeClass('show');
			$('#tdtime li.notimelist').removeClass('noshow');
		});
		$('#tdlocal').click(function() {
			$('#tdcinema input').prop("checked", false);
			$('#tddate input').prop("checked", false);
			$('#tdtime input').prop("checked", false);
			$('#tdtime .tdiv').removeClass('show');
			$('#tdtime li.notimelist').removeClass('noshow');
		});
		$('#tdcinema').click(function() {
			$('#tddate input').prop("checked", false);
			$('#tdtime input').prop("checked", false);
			$('#tdtime .tdiv').removeClass('show');
			$('#tdtime li.notimelist').removeClass('noshow');
		});
		$('#tddate').click(function() {
			$('#tdtime input').prop("checked", false);
		});
		
		// 날짜 슬라이더
		$('.post-wrapper').slick({
			  slidesToShow: 5,
			  slidesToScroll: 1,
			  autoplay: false,
			  speed: 300,
			  infinite: false,
			  nextArrow:$('.next'),
			  prevArrow:$('.prev'),
		});

	});
	
</script>
</head>

<body>
  <!--::header part start::-->
	<jsp:include page="/inc/top.jsp"/>
  <!-- Header part end-->

	<!-- 서브비주얼 -->
	<jsp:include page="/inc/sub_visual1.jsp"/>

  

  <!--================Reservation Area =================-->
  <div id="sub_content" class="reserveMain">
	  <div class="container">
	  	<h3 class="sub_title">영화/상영관/날짜 선택</h3>
		<!-- 영화등록표 시작 -->
	  	<form action="MovieNumFind.re" method="post" id="movieform">
		<table>
			<colgroup>
				<col width="30%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>영화제목</th>
				<th>지역</th>
				<th>영화관</th>
				<th>날짜 및 시간</th>
			</tr>
			<tr>
				<td rowspan="2">
					<ul id="tdsubject">
						<!-- 등록된 영화 리스트 표출 -->
					</ul>
				</td>
				<td rowspan="2">
					<ul id="tdlocal">
						<li><input type="radio" name="local" id="서울" value="서울" class="rlocal"><label for="서울">서울</label></li>
						<li><input type="radio" name="local" id="경기" value="경기" class="rlocal"/><label for="경기">경기</label></li>
						<li><input type="radio" name="local" id="인천" value="인천" class="rlocal"/><label for="인천">인천</label></li>
						<li><input type="radio" name="local" id="강원" value="강원" class="rlocal"/><label for="강원">강원</label></li>
						<li><input type="radio" name="local" id="대전" value="대전/충청" class="rlocal"/><label for="대전">대전/충청</label></li>
						<li><input type="radio" name="local" id="대구" value="대구" class="rlocal"/><label for="대구">대구</label></li>
						<li><input type="radio" name="local" id="부산" value="부산/울산" class="rlocal"/><label for="부산">부산/울산</label></li>
						<li><input type="radio" name="local" id="경상" value="경상" class="rlocal"/><label for="경상">경상</label></li>
						<li><input type="radio" name="local" id="광주" value="광주/전라/제주" class="rlocal"/><label for="광주">광주/전라/제주</label></li>
					</ul>
				</td>
				<td rowspan="2">
					<ul id="tdcinema">
						<!-- 지역 클릭시 영화관 리스트 표출 -->
					</ul>
				</td>
				<td class="dateBox">
					
					<i class="fas fa-chevron-left prev"></i> 
        			<i class="fas fa-chevron-right next"></i>
					<ul id="tddate" class="post-wrapper">
						
						<li>
							<span class="month"><%=today.format(DateTimeFormatter.ofPattern("MM"))%>월</span>
							<input type="radio" name="date" id="<%=today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" value="<%=today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" class="rdate"/>
									<label for="<%=today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>"><%=today.format(DateTimeFormatter.ofPattern("dd"))%></label></li>
							<%
							for(int i=1;i<=3;i++) {
								%><li><input type="radio" id="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" value="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" name="date" class="rdate"/>
									<label for="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>"><%=today.plusDays(i).format(DateTimeFormatter.ofPattern("dd"))%></label></li><%
							}
							for(int i=4;i<=10;i++) {
								%><li><input type="radio" id="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" value="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" name="date" class="rdate" disabled/>
									<label for="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>"><%=today.plusDays(i).format(DateTimeFormatter.ofPattern("dd"))%></label></li><%
							}
							%>
					</ul>
				</td>
			</tr>
			<tr>
				<td>
					<ul id="tdtime">
						<li class="notimelist"><img src="img/sub/notimelist.png" alt="film"></li>
						<li class="notimelist">조회 가능한 상영시간이 없습니다.</li>
						<li class="notimelist">조건을 변경해주세요.</li>
						<!-- 등록된 시간 리스트 표출 -->
					</ul>
				</td>
			</tr>
		</table>
		<div class="btnBox">
			<input type="submit" class="genric-btn primary circle" value="좌석선택">
		</div>
		</form>
	  </div>
  </div><!-- #sub_content -->
  <!--================End Reservation Area =================-->

  <!--::footer_part start::-->
  <jsp:include page="/inc/bottom.jsp"/>
  <!--::footer_part end::-->

  <!-- jquery plugins here-->
  <!-- jquery -->
  <script src="js/jquery-1.12.1.min.js"></script>
  <!-- popper js -->
  <script src="js/popper.min.js"></script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.min.js"></script>
  <!-- easing js -->
  <script src="js/jquery.magnific-popup.js"></script>
  <!-- swiper js -->
  <script src="js/swiper.min.js"></script>
  <!-- swiper js -->
  <script src="js/masonry.pkgd.js"></script>
  <!-- particles js -->
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.nice-select.min.js"></script>
  <!-- slick js -->
  <script src="js/slick.min.js"></script>
  <script src="js/jquery.counterup.min.js"></script>
  <script src="js/waypoints.min.js"></script>
  <script src="js/contact.js"></script>
  <script src="js/jquery.ajaxchimp.min.js"></script>
  <script src="js/jquery.form.js"></script>
  <script src="js/jquery.validate.min.js"></script>
  <script src="js/mail-script.js"></script>
  <script src="js/stellar.js"></script>
  <script src="js/price_rangs.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
</body>

</html>