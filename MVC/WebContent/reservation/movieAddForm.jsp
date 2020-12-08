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
		$.getJSON('AllMovieListJson.re', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#mldiv').append("<div class='ml_div "+item.movie_subject+"'><input type='radio' name='movie' id='"+item.movie_subject+"' value='"+item.movie_num+"' class='rmovie'/><label for='"+item.movie_subject+"'>"
						+item.cinema_name+" - "+item.movie_subject+" : "+item.showdate+" / "+item.showtime+"</label></div>");
			});
		})
		// cinema 목록 db에서 가져오기
		$.getJSON('reservation/cinemaListjson.jsp', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#tdcinema').append("<div class='cdiv "+item.cinema_local+"'><input type='radio' name='cinema' id='"+item.cinema_name+"' value='"+item.cinema_name+"' class='rcinema'/><label for='"+item.cinema_name+"'>"+item.cinema_name+"</label></div>");
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
			var subject = $('#txtsubject').val();
			var time = $('#txttime').val();
			
			if(subject == "") {
				alert("영화제목을 입력하세요.");
				$('#tsubject').focus();
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
			if(time == "") {
				alert("시간과 관을 입력하세요.");
				$('#ttime').focus();
				return false;
			}
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
              <h2>Movie Management</h2>
              <p>Admin<span>-</span>Movie</p>
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
	  	<!-- 등록된 영화 리스트 -->
		<div>
			<form action="MovieDeletePro.re" method="post">
				<table id="movie_list">
					<tr>
						<th>영화관 - 영화제목 : 날짜 / 시간</th>
					</tr>
					<tr>
						<td>
							<div id="mldiv">
							<!-- 영화관 리스트 표출 -->
							</div>
						</td>
					</tr>
				</table>
				<input type="submit" value="삭제">
			</form>
		</div>
		<br><br>
		<!-- 영화등록표 시작 -->
		<div>
		  	<form action="MovieAddPro.re" method="post" id="movieform">
			<table>
				<tr>
					<th>영화제목</th>
					<th>지역</th>
					<th>영화관</th>
					<th>날짜 및 시간</th>
				</tr>
				<tr>
					<td rowspan="2">
						<div id="tsubject">
						<input type="text" name="movie_subject" id="txtsubject" placeholder="영화제목을 입력해주세요."/>
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
						<div id="ttime">
							<input type="text" name="time" id="txttime" placeholder="HH:MM(n관)"/>
						</div>
					</td>
				</tr>
			</table>
		<!-- 	<input type="submit" value="좌석선택"> -->
			<input type="submit" value="영화등록">
			</form>
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