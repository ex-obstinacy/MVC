<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
  <link href="css/reservation.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 등록된 영화관 리스트 가져오기
		$.getJSON('reservation/cinemaListjson.jsp', function(rdata) {
			$.each(rdata, function(index, item) {
				$('#cldiv').append("<div class='cl_div "+item.cinema_local+"'><input type='radio' name='cinema' id='"+item.cinema_name+"' value='"+item.cinema_name+"' class='rcinema'/><label for='"+item.cinema_name+"'>"+item.cinema_local+" - "+item.cinema_name+"</label></div>");
			});
		});
		// 필수 조건
		$('#cinema_fr').submit(function() {
			var local = $('#local').val();
			var name = $('#name').val();
			
			if(local == "") {
				alert("지역을 선택하세요.");
				$('#local').focus();
				return false;
			}
			if(name == "") {
				alert("영화관명을 입력하세요.");
				$('#name').focus();
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
              <h2>Cinema Management</h2>
              <p>Admin<span>-</span>Cinema</p>
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
	  	<div>
			<form action="CinemaDeletePro.re" method="post">
				<table id="cinema_list">
					<tr>
						<th>지역 - 영화관명</th>
					</tr>
					<tr>
						<td>
							<div id="cldiv">
							<!-- 영화관 리스트 표출 -->
							</div>
						</td>
					</tr>
				</table> <br>
				<input type="submit" value="삭제">
			</form>
		</div>
	  	<br><br>
		<!-- 영화관 등록 폼 -->
		<div>
			<form action="CinemaAddPro.re" method="post" id="cinema_fr">
				<select name="local" id="local">
					<option value="">지역을 선택하세요.</option>
					<option value="서울">서울</option>
					<option value="경기">경기</option>
					<option value="인천">인천</option>
					<option value="강원">강원</option>
					<option value="대전/충청">대전/충청</option>
					<option value="대구">대구</option>
					<option value="부산/울산">부산/울산</option>
					<option value="경상">경상</option>
					<option value="제주">제주</option>
				</select><br><br><br>
				영화관 명 : 
				<input type="text" name="name" id="name"><br><br>
				<input type="submit" value="등록">
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