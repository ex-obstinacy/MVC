<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
	
	LocalDate today = LocalDate.now();
%>
<html lang="zxx">

<head>
<%
	if (id == null) {
%>
		<script type="text/javascript">
			alert("로그인이 필요합니다.");
			location.href = "MemberLogin.me";
		</script>
<%
	} else if (!id.equals("admin")) {
%>
		<script type="text/javascript">
			alert("잘못된 접근입니다.");
			history.back();
		</script>
<%
	}
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
		$.getJSON('AllMovieListJson.re', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#mldiv').append("<li class='ml_div "+item.movie_code+"'><input type='radio' name='movie' id='"+item.movie_num+item.cinema_name+"' value='"+item.movie_num+"' class='rmovie'/><label for='"+item.movie_num+item.cinema_name+"'>"
						+"<span id='span_m1' class='"+item.cinema_name+"'>["+item.cinema_name+"]</span><span id='span_r1' class='g"+item.movie_grade+"'>"+item.movie_grade+"</span><span id='span_m2'>"+item.movie_subject+"</span><span id='span_m3'>"+item.showtime+"</span><span id='span_m4'>"+item.showdate+"</span></label></li>");
			});
		});
		// moive_board 상영중인 영화목록 가져오기
		$.getJSON('ShowMovieListJson.re', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdsubject').append("<li class='mdiv "+item.movie_code+"'><input type='radio' name='movie_code' id='"+item.movie_code+"' value='"+item.movie_code+"' class='rsmovie'/><label for='"+item.movie_code+"'>"
						+"<span id='span_r1' class='g"+item.movie_grade+"'>"+item.movie_grade+"</span><span id='span_r2'>"+item.movie_subject+"</span></label></li>");
			});
		});
		// cinema 목록 db에서 가져오기
		$.getJSON('CinemaListJson.re', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdcinema').append("<li class='cdiv "+item.cinema_local+"'><input type='radio' name='cinema' id='"+item.cinema_name+"' value='"+item.cinema_name+"' class='rcinema'/><label for='"+item.cinema_name+"'>"+item.cinema_name+"</label></li>");
			});
		});
		// 지역 선택
		$('#tdlocal input').click(function() {
			// 지역별로 상영관 출력
			var local_id = $(this).attr('id');
			$('#tdcinema .cdiv').removeClass('show');
			$('#tdcinema .'+local_id).addClass('show');
		});
		
		// 필수 조건
		$('#movieform').submit(function() {
			if($('.rsmovie').is(":checked") == false) {
				alert("영화를 선택하세요.");
				$('.rsmovie').focus();
				return false;
			}
			if($('.rlocal').is(":checked") == false) {
				alert("지역을 선택하세요.");
				$('.rlocal').focus();
				return false;
			}
			if($('.rcinema').is(":checked") == false) {
				alert("영화관을 선택하세요.");
				$('.rcinema').focus();
				return false;
			}
			if($('.rdate').is(":checked") == false) {
				alert("날짜를 선택하세요.");
				$('.rdate').focus();
				return false;
			}
			if($('#seltime').val() == "") {
				alert("시간을 선택하세요.");
				$('#seltime').focus();
				return false;
			}
			if($('#selguan').val() == "") {
				alert("관을 선택하세요.");
				$('#selguan').focus();
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
		});
		$('#tdlocal').click(function() {
			$('#tdcinema input').prop("checked", false);
			$('#tddate input').prop("checked", false);
			$('#tdtime input').prop("checked", false);
			$('#tdtime .tdiv').removeClass('show');
		});
		$('#tdcinema').click(function() {
			$('#tddate input').prop("checked", false);
			$('#tdtime input').prop("checked", false);
			$('#tdtime .tdiv').removeClass('show');
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
	<jsp:include page="/inc/sub_main1.jsp"/>

  

  <!--================Reservation Area =================-->
  <section id="sub_content" class="reserveMain">
	  <div class="container">
<!-- 	  	<h3 class="sub_title"><b>관리자님! 영화를 등록/삭제 해주세요.</b></h3> -->
	  	<div class="row">
	  	<div class="col-lg-3">
            <div class="left_sidebar_area">
                <aside class="left_widgets p_filter_widgets">
                    <div class="side_menu">
						<h3>관리자메뉴</h3>
						<ul class="list side_list">
							<li><a href="AdminMovList.mo">영화목록</a></li>
							<li><a href="CinemaAddForm.re">영화관</a></li>
							<li class="active"><a href="MovieAddForm.re">상영중인 영화</a></li>
							<li><a href="GoodsList.go">스토어</a></li>
							<li><a href="AdminNoticeList.ad">공지사항</a></li>
							<li><a href="AdminQnAList.ad">1대1 문의</a></li>
							<li><a href="AdminMemberList.ad">회원 목록</a></li>
						</ul>
					</div><!-- .side_menu -->
                </aside>
            </div>
        </div>
	  	<!-- 등록된 영화 목록 -->
	  	<div id="mlistdiv">
	  	<h2 class="member_title">영화목록</h2><!-- .member_title -->
	  	<form action="MovieDeletePro.re" method="post" id="mlistform">
			<table>
				<tr>
					<th>상영중인 영화</th>
					<th id="thBox"><input type="submit" class="genric-btn default circle" value="삭제"></th>
				</tr>
				<tr>
					<td colspan="2">
						<ul id="mldiv">
						<!-- 영화 리스트 표출 -->
						</ul>
					</td>
				</tr>
			</table>
		</form>
	  	</div>
	  	<!-- 등록된 영화 목록 -->
		<!-- 영화등록표 -->
		<div id="mformdiv">
	  	<form action="MovieAddPro.re" method="post" id="movieform">
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
						<!-- moive_board의 영화 목록 -->
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
						<li><input type="radio" name="local" id="광주" value="광주/전라" class="rlocal"/><label for="광주">광주/전라</label></li>
						<li><input type="radio" name="local" id="제주" value="제주" class="rlocal"/><label for="제주">제주</label></li>
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
							for(int i=1;i<=19;i++) {
								%><li><input type="radio" id="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" value="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" name="date" class="rdate"/>
									<label for="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>"><%=today.plusDays(i).format(DateTimeFormatter.ofPattern("dd"))%></label></li><%
							}
							%>
					</ul>
				</td>
			</tr>
			<tr>
				<td>
					<ul id="ultime">
						<li>
							<select name="seltime" id="seltime">
								<option value="">시간</option>
								<optgroup label="오전">
									<option>08:00</option><option>08:30</option>
									<option>09:00</option><option>09:30</option>
									<option>10:00</option><option>10:30</option>
									<option>11:00</option><option>11:30</option>
								</optgroup>
								<optgroup label="오후">
									<option>12:00</option><option>12:30</option>
									<option>13:00</option><option>13:30</option>
									<option>14:00</option><option>14:30</option>
									<option>15:00</option><option>15:30</option>
									<option>16:00</option><option>16:30</option>
									<option>17:00</option><option>17:30</option>
									<option>18:00</option><option>18:30</option>
									<option>19:00</option><option>19:30</option>
									<option>20:00</option><option>20:30</option>
									<option>21:00</option><option>21:30</option>
									<option>22:00</option><option>22:30</option>
									<option>23:00</option><option>23:30</option>
								</optgroup>
								<optgroup label="심야">
									<option>00:00</option><option>00:30</option>
									<option>01:00</option>
								</optgroup>
							</select>
						</li>
						<li>
							<select name="selguan" id="selguan">
								<option value="">관</option>
								<option>1관</option>
								<option>2관</option>
								<option>3관</option>
								<option>4관</option>
								<option>5관</option>
							</select>
						</li>
					</ul>
				</td>
			</tr>
		</table>
		<div class="btnBox">
			<input type="submit" class="genric-btn primary circle" value="영화등록">
		</div>
		</form>
		</div>
		<!-- 영화등록표 -->
		</div>
	  </div>
  </section>
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