<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.NoticeBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>MVC</title>
<style>
.title_top {
	margin-bottom: 10px;
	padding: 25px 0 14px;
	border-bottom: 1px solid #EEE;
}

/* Style the navigation menu */
.topnav {
	width: 100%;
	background-color: #555;
	overflow: auto;
	margin-bottom: 10px;
}

/* Navigation links */
.topnav a {
	float: left;
	padding: 12px;
	color: #FFF !important;
	text-decoration: none;
	font-size: 17px;
	width: 25%;
	/* Four equal-width links. If you have two links, use 50%, and 33.33% for three links, etc.. */
	text-align: center; /* If you want the text to be centered */
}

/* Add a background color on mouse-over */
.topnav a:hover {
	background-color: #FF3368;
	color: #FFF !important;
}

/* Style the current/active link */

/* Add responsiveness - on screens less than 500px, make the navigation links appear on top of each other, instead of next to each other */
@media screen and (max-width: 500px) {
	.topnav a {
		float: none;
		display: block;
		width: 100%;
		text-align: left;
		/* If you want the text to be left-aligned on small screens */
	}
}

/* 검색 */
.search input[type=text] {
	float: right;
	padding: 6px;
	border: none;
	margin-top: 8px;
	margin-right: 16px;
	font-size: 17px;
	background-color: #EAEAEA;
}

@media screen and (max-width: 600px) {
	.search input[type=text] {
		float: none;
		display: block;
		text-align: left;
		width: 100%;
		margin: 0;
		padding: 14px;
	}
	.search input[type=text] {
		border: 1px solid #ccc;
	}
}
</style>
<link rel="icon" href="img/favicon.png">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- animate CSS -->
<link rel="stylesheet" href="css/animate.css">
<!-- owl carousel CSS -->
<link rel="stylesheet" href="css/owl.carousel.min.css">
<!-- font awesome CSS -->
<link rel="stylesheet" href="css/all.css">
<!-- flaticon CSS -->
<link rel="stylesheet" href="css/flaticon.css">
<link rel="stylesheet" href="css/themify-icons.css">
<!-- font awesome CSS -->
<link rel="stylesheet" href="css/magnific-popup.css">
<!-- swiper CSS -->
<link rel="stylesheet" href="css/slick.css">
<!-- style CSS -->
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/sub.css">
</head>
<body>
	<!--::header part start::-->
	<jsp:include page="../inc/top.jsp" />
	<!-- Header part end-->
	<!-- 서브비주얼 -->
	<jsp:include page="/inc/sub_event1.jsp"/>

	
	<!--================Blog Area =================-->
	<section class="blog_area padding_top">
		<div class="container">
			<div class="topnav">
				<a href="EventList.ev" target="_parent">영화</a>
				<a href="PreviewList.pr" target="_parent">시사회/무대인사</a> 
				<a href="WinList.wi" target="_parent">당첨자발표</a>
				<a href="EventListHot.ev" target="_parent"> HOT</a>
			</div>
		</div>
	</section>
	<section id="listForm" class="checkout_area padding_top">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<h2>HOT</h2>
					<table class="table">

						<tr>
							<td align="center">번호</td>
							<td align="center">제 목</td>
							<td align="center">작성자</td>
							<td align="center">작성일</td>
							
						</tr>

						<tr>
							<td align="center">1</td>
							<td align="center">
								<a href="EventHot1.ev"> 함께해요! # 안심 영화관 만들기
								</a>
							<td align="center">admin</td>
							<td align="center">2021-01-04</td>
							
						</tr>
															
						<tr>
							<td align="center">2</td>
							<td align="center">
								<a href="EventHot4.ev"> 매주 금-토요일 영화티켓 장당 5000 M 포인트 사용
								</a>
							<td align="center">admin</td>
							<td align="center">2021-01-04</td>
							
						</tr>																
						
						<tr>
							<td align="center">3</td>
							<td align="center">
								<a href="EventHot4.ev"> 	2021년에도 새해 복 많이 받으소 ~
								</a>
							<td align="center">admin</td>
							<td align="center">2021-01-01</td>
							
						</tr>							
					
						<tr>
							<td align="center">4</td>
							<td align="center">
								<a href="EventHot2.ev"> 매일 MVC ON은 메리 크리스마스
								</a>
							<td align="center">admin</td>
							<td align="center">2020-12-10</td>
							
						</tr>
						
					</table>
				</div>
			</div>
		</div>
	</section>




	<!--================Blog Area =================-->
	<!--::footer_part start::-->
	<jsp:include page="../inc/bottom.jsp" />
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
	<!-- custom js -->
	<script src="js/custom.js"></script>
</body>
</html>