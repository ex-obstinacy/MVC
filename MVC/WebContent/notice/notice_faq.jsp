<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>MVC</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$("#flip1").click(function() {
			$("#panel1").slideToggle("slow");
		});
	});

	$(document).ready(function() {
		$("#flip2").click(function() {
			$("#panel2").slideToggle("slow");
		});
	});

	$(document).ready(function() {
		$("#flip3").click(function() {
			$("#panel3").slideToggle("slow");
		});
	});

	$(document).ready(function() {
		$("#flip4").click(function() {
			$("#panel4").slideToggle("slow");
		});
	});

	$(document).ready(function() {
		$("#flip5").click(function() {
			$("#panel5").slideToggle("slow");
		});
	});

	$(document).ready(function() {
		$("#flip6").click(function() {
			$("#panel6").slideToggle("slow");
		});
	});

	$(document).ready(function() {
		$("#flip7").click(function() {
			$("#panel7").slideToggle("slow");
		});
	});

	$(document).ready(function() {
		$("#flip8").click(function() {
			$("#panel8").slideToggle("slow");
		});
	});

	$(document).ready(function() {
		$("#flip9").click(function() {
			$("#panel9").slideToggle("slow");
		});
	});
</script>
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

/* 열고 닫기 연습 */
#panel1, #flip1, #panel2, #flip2, #panel3, #flip3, #panel4, #flip4,
	#panel5, #flip5, #panel6, #flip6, #panel7, #flip7, #panel8, #flip8,
	#panel9, #flip9 {
	padding: 5px;
	text-align: center;
	background-color: #F8F8F8;
	border: solid 1px #c3c3c3;
}

#panel1, #panel2, #panel3, #panel4, #panel5, #panel6, #panel7, #panel8,
	#panel9 {
	padding: 50px;
	display: none;
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
</head>
<body>
	<!--::header part start::-->
	<jsp:include page="../inc/top.jsp" />
	<!-- Header part end-->
	<!--================Home Banner Area =================-->
	<!-- breadcrumb start-->
	<section class="breadcrumb breadcrumb_bg">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8">
					<div class="breadcrumb_iner">
						<div class="breadcrumb_iner_item">
							<h2>Shop Single</h2>
							<p>
								Home <span>-</span> Shop Single
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- breadcrumb start-->
	<!--================Blog Area =================-->
	<section class="blog_area padding_top">
		<div class="container">
			<div class="topnav">
				<a href="NoticeList.no" target="_parent">공지사항</a> <a href="NoticeFaq.no" target="_parent">FAQ</a> <a href="QnaList.qn" target="_parent">1대1 문의</a> <a href="#contact">회원 약관</a>
			</div>
		</div>
	</section>
	<section id="listForm" class="checkout_area padding_top">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<h2>FAQ - 자주 묻는 질문</h2>
					<table class="table">
						<tr>
							<td align="center">번호</td>
							<td align="center">질문</td>
						</tr>
						<tr>
							<td align="center">1</td>
							<td align="center">
								<div id="flip1">카드로 결제할 경우 환불은 언제 되나요?</div>
								<div id="panel1">
									<span style="font-size: 14pt; float: left;">환불안내</span><br> <br>
									<span style="float: left;">ㆍ 신용카드</span><br> <span style="float: left;">- 결제 후 3일 이내 취소시 승인취소 가능합니다.</span><br> <span style="float: left; color: red;">- 3일 이후 예매 취소 시 영업일 기준 3일 ~7일 이내 카드사에서 환불됩니다.</span><br> <br> <span style="float: left;">ㆍ 체크카드</span><br> <span style="float: left;"> - 결제 후 3일 이내 취소 시 당일 카드사에서 환불 처리됩니다.</span><br> <span style="float: left; color: red;"> - 3일 이후 예매 취소 시 카드사에 따라 3일 ~ 10일 이내 카드사에서 환불됩니다.</span><br> <br> <span style="float: left;">ㆍ 휴대폰 결제</span><br> <span style="float: left; color: red;"> - 결제 일자 기준 당월(1일~말일까지) 취소만 가능합니다.</span><br> <span style="float: left;"> - 익월 취소의 경우 롯데시네마 고객센터(1544-8855)로 문의 주시기 바랍니다.</span><br> <br> <span style="float: left;">ㆍ카카오페이 간편결제</span><br> <span style="float: left;"> - 카카오페이머니를 사용하신 경우 카카오페이머니 잔액으로 원복됩니다.</span><br> <span style="float: left;"> - 카드 결제를 한 경우 카드사 정책에 따라 승인취소가 진행되며,</span><br> <span style="float: left;"> 3일 이후 매입 취소 시
										영업일 기준 3~10일 소요됩니다.</span><br> <br> <span style="float: left;">ㆍ페이코 간편결제</span><br> <span style="float: left;"> - PAYCO 쿠폰/포인트를 사용하신 경우 각각의 쿠폰/포인트로 원복됩니다.</span><br> <span style="float: left;"> - 카드 결제 금액은 카드사 정책에 따라 승인취소가 진행되며,</span><br> <span style="float: left;"> - 3일 이후 매입취소 시 영업일 기준 3~10일 소요됩니다.</span><br>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center">2</td>
							<td align="center">
								<div id="flip2">국가 유공자 할인은 어떻게 받나요?</div>
								<div id="panel2">
									<span style="float: left;">국가유공자임을 증명할 수 있는 국가유공자증 소지자 본인에 한해 일반(2D) 영화 5천원 관람이 가능합니다. 국가유공자 할인의 경우, 온라인 예매 시에는 </span><br> <span style="float: left;">할인 적용이 불가하며 영화관 현장에서 예매할 시에만 할인 가능합니다. 또한, 국가유공상이자는 장애인석을 이용하실 수 있습니다.</span>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center">3</td>
							<td align="center">
								<div id="flip3">분실물을 찾고 싶어요.</div>
								<div id="panel3">
									<span style="float: left;">영화관을 이용하시다가 소지물품을 분실하신 경우에는 통합콜센터 1544-8855로 연락하시어 확인 하시거나,</span><br> <span style="float: left;"> 홈페이지 고객센터 - 분실물안내에서 분실물 접수 혹은 확인을 하실 수 있습니다.</span><br>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center">4</td>
							<td align="center">
								<div id="flip4">단체 관람의 경우 할인 혜택이 어떻게 되나요?</div>
								<div id="panel4">
									<span style="float: left;">단체 관람의 경우, 20명 이상 티켓 구매 시 1인당 1,000원씩 할인 혜택을 받으실 수 있습니다.</span><br> <span style="float: left;">단체 관람과 관련하여 문의가 있으실 경우 통합콜센터 1544-8855로 연락하시거나</span><br> <span style="float: left;"> [홈페이지] → [고객센터] → [단체관람/대관문의]로 내용 접수해주시기 바랍니다.</span><br> <span style="float: left;">※ 조조, 심야, 문화의 날, 공휴일, 주말 등 일부는 제외될 수 있습니다.</span><br> <span style="float: left;">※ 영화관 별로 단체 관람 대상 인원수 및 할인 혜택에 일부 차이가 있을 수 있습니다.</span><br>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center">5</td>
							<td align="center">
								<div id="flip5">장애인 할인 혜택에 대해 알려주세요.</div>
								<div id="panel5">
									<span style="float: left;">일반 2D 영화 : 5,000원 관람, 3D 영화 : 8,000원 관람이 가능합니다.</span><br> <span style="float: left;">온라인으로 예매를 하셨더라도, 티켓 발권을 위해 복지카드를 가지고 영화관 인포메이션 데스크를 방문해주셔야 합니다.</span><br> <span style="float: left;">(장애1~3등급 : 동반 1인 포함 할인 가능/ 장애4~6등급 : 본인만 할인 가능)</span><br>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center">6</td>
							<td align="center">
								<div id="flip6">시니어 할인 혜택에 대해 알려주세요.</div>
								<div id="panel6">
									<span style="float: left;">만 65세 이상의 시니어 고객님들에게 할인 혜택을 제공하고 있습니다.</span><br> <span style="float: left;">-일반 2D 영화 : 5,000원</span><br> <span style="float: left;">-3D 영화 : 8,000원</span><br> <span style="float: left; color: red;">티켓발권을 위해 본인의 신분증(만 65세 이상)을 가지고 영화관 인포메이션 데스크를 방문해주셔야 합니다. </span><br> <span style="float: left; color: red;">타인의 신분증 제시 시 입장에 제한이 있을 수 있으므로, 반드시 입장하시는 당사자 본인의 신분증을 지참해주시기 바랍니다. </span><br> <span style="float: left; color: red;">(온라인 예매 시에도 동일 정책 적용) </span><br>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center">7</td>
							<td align="center">
								<div id="flip7">결제(예매) 및 취소 규정 안내</div>
								<div id="panel7">
									<span style="float: left;">■ 예매 시</span><br> <span style="float: left;">ㆍ 홈페이지 예매 시 → 영화 시작시간 20분 전까지 예매 가능합니다.</span><br> <span style="float: left;">ㆍ 모바일 앱/웹 예매 시 → 영화 시작시간까지 예매 가능합니다.</span><br> <span style="float: left;">ㆍ 현장 → 영화 시작시간까지 예매 가능합니다.</span><br> <span style="float: left;">■ 취소 시</span><br> <span style="float: left;">ㆍ 홈페이지 취소 시 → 영화 시작시간 20분 전까지 취소 가능합니다.</span><br> <span style="float: left;">ㆍ 모바일 앱/웹 예매 시 → 영화 시작시간 20분 전까지 취소 가능합니다.</span><br> <span style="float: left;">ㆍ 현장 → 영화 시작시간 직전까지 취소 가능합니다.</span><br> <span style="float: left;">※ 무대인사가 포함된 영화의 경우 행사의 원활한 진행을 위해 상영시간 24시간 이전부터는 취소가 불가합니다.</span><br>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center">8</td>
							<td align="center">
								<div id="flip8">상영관 내 외부 음식물 반입 제한 안내</div>
								<div id="panel8">
									<span style="float: left;">MVC에서는 상영관 내 외부 음식물 반입이 가능합니다.</span><br> <span style="float: left;">다만, 강한 냄새로 인해 타 고객님에게 불쾌감 또는 영화관람에 방해가 되는 음식의 경우</span><br> <span style="float: left;">쾌적한 영화관람과 안전을 위해 상영관 입장 전 외부에서 음식을 취식 후 입장해 주실 것을 </span><br> <span style="float: left;">안내하고 있습니다. </span><br> <span style="float: left;">다소 불편한 점이 있더라도 고객님의 너른 양해 부탁드립니다. </span><br>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center">9</td>
							<td align="center">
								<div id="flip9">관람등급 안내</div>
								<div id="panel9">
									<span style="float: left;">MVC는 영화 및 비디오 진흥에 관한 법률(이하 영비법)을 준수합니다.</span><br> <span style="float: left;">■ 등급 기준</span><br> <span style="float: left;">ㆍ 전체 관람가 : 모든 연령의 관람객이 관람할 수 있는 영화</span><br> <span style="float: left;">ㆍ 12세 관람가 : 만 12세 미만의 관람객은 관람할 수 없는 영화(보호자 동반 시 12세 미만 관람가)</span><br> <span style="float: left;">ㆍ 15세 관람가 : 만 15세 미만의 관람객은 관람할 수 없는 영화(보호자 동반 시 15세 미만 관람가)</span><br> <span style="float: left;">ㆍ 청소년 관람불가 : 만 18세 미만의 관람객은 관람할 수 없는 영화</span><br> <span style="float: left;">영비법 29조에 따르면 [만 12세 이상 관람가/ 만 15세 이상 관람가]의 등급이라도</span><br> <span style="float: left;">부모 등 보호자를 동반하는 경우 어린이(유아) 동반이 가능합니다.</span><br> <span style="float: left;">반드시 보호자의 동반이 필요함을 양지하여 주시기 바랍니다.</span><br> <span style="float: left; color: red;">단, 청소년 관람불가 영화는 보호자 동반과 관계없이 </span><br> <span style="float: left; color: red;">만 18세 미만이거나 연령 조건을 만족하여도 초중고 재학 중인 청소년 및 영유아 관람이 절대 불가합니다. </span><br> <span style="float: left; color: red;">영화관
										현장에서 연령확인 불가 시 입장이 제한될 수 있습니다. </span><br>
								</div>
							</td>
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