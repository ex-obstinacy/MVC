<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<%
	LocalDate today = LocalDate.now();
	%>
<html lang="zxx">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>aranaz</title>
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
  <link rel="stylesheet" href="css/reservation.css" type="text/css">
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 등록되어있는 영화목록 가져오기
		$.getJSON('reservation/movieListjson.jsp', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdsubject').append("<div class='sdiv "+item.movie_subject+"'><input type='radio' name='movie' id='"+item.movie_subject+"' value='"+item.movie_subject+"' class='rmovie'/><label for='"+item.movie_subject+"'>"+item.movie_subject+"</label></div>");
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
		// cinema 목록 db에서 가져오기(admin_reserve랑 동일)
		$.getJSON('reservation/cinemaListjson.jsp', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdcinema').append("<div class='cdiv "+item.cinema_local+"'><input type='radio' name='cinema' id='"+item.cinema_name+"' value='"+item.cinema_name+"' class='rcinema'/><label for='"+item.cinema_name+"'>"+item.cinema_name+"</label></div>");
			});
		});
		// showtime 목록 db에서 가져오기
		$.getJSON('reservation/timeListjson.jsp', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdtime').append("<div class='tdiv "+item.movie_subject+" "+item.cinema_name+" "+item.showdate+"'><input type='radio' name='time' id='"+item.showtime+"' value='"+item.showtime+"' class='rtime'/><label for='"+item.showtime+"'>"+item.showtime+"</label></div>");
			});
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
				$('#tdtime .tdiv').removeClass('show');
				$('#tdtime .'+movie_id+'.'+cinema_id+'.'+date_id).addClass('show');
			}
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
	});
</script>
</head>

<body>
  <!--::header part start::-->
	<jsp:include page="/inc/top.jsp"/>
  <!-- Header part end-->


  <!--================Home Banner Area =================-->
  <!-- breadcrumb start-->
  <section class="breadcrumb breadcrumb_bg">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="breadcrumb_iner">
            <div class="breadcrumb_iner_item">
              <h2>Reservation</h2>
              <p>Home <span>-</span>Reservation</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- breadcrumb start-->

  <!--================Reservation Area =================-->
  <section class="cart_area padding_top">
	  <div class="container">
		<!-- 영화등록표 시작 -->
	  	<form action="MovieNumFind.re" method="post" id="movieform">
		<table>
			<tr>
				<th>영화제목</th>
				<th>지역</th>
				<th>영화관</th>
				<th>날짜 및 시간</th>
			</tr>
			<tr>
				<td rowspan="2">
					<div id="tdsubject">
						<!-- 등록된 영화 리스트 표출 -->
					</div>
				</td>
				<td rowspan="2">
					<div id="tdlocal">
						<input type="radio" name="local" id="서울" value="서울" class="rlocal"><label for="서울">서울</label><br>
						<input type="radio" name="local" id="경기" value="경기" class="rlocal"/><label for="경기">경기</label><br>
						<input type="radio" name="local" id="인천" value="인천" class="rlocal"/><label for="인천">인천</label><br>
						<input type="radio" name="local" id="강원" value="강원" class="rlocal"/><label for="강원">강원</label><br>
						<input type="radio" name="local" id="대전" value="대전/충청" class="rlocal"/><label for="대전">대전/충청</label><br>
						<input type="radio" name="local" id="대구" value="대구" class="rlocal"/><label for="대구">대구</label><br>
						<input type="radio" name="local" id="부산" value="부산/울산" class="rlocal"/><label for="부산">부산/울산</label><br>
						<input type="radio" name="local" id="경상" value="경상" class="rlocal"/><label for="경상">경상</label><br>
						<input type="radio" name="local" id="광주" value="광주/전라" class="rlocal"/><label for="광주">광주/전라</label><br>
						<input type="radio" name="local" id="제주" value="제주" class="rlocal"/><label for="제주">제주</label><br>
					</div>
				</td>
				<td rowspan="2">
					<div id="tdcinema">
						<!-- 지역 클릭시 영화관 리스트 표출 -->
					</div>
				</td>
				<td>
					<div id="tddate">
						<input type="radio" name="date" id="<%=today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" value="<%=today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" class="rdate"/>
									<label for="<%=today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>"><%=today.format(DateTimeFormatter.ofPattern("dd"))%></label>
							<%
							for(int i=1;i<=10;i++) {
								%><input type="radio" id="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" value="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" name="date" class="rdate"/>
									<label for="<%=today.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>"><%=today.plusDays(i).format(DateTimeFormatter.ofPattern("dd"))%></label><%
							}
							%>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div id="tdtime">
						<!-- 등록된 시간 리스트 표출 -->
					</div>
				</td>
			</tr>
		</table><br>
		<input type="submit" class="genric-btn primary circle" value="좌선선택">
		</form>
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