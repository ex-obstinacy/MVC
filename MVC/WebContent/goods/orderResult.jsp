<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>MVC</title>
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

<link rel="stylesheet" href="css/sub.css">
<link rel="stylesheet" href="css/common.css">

</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script><!-- 아임포트 결제 js -->

<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">	

</script>

<body>
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 서브비주얼 -->
<jsp:include page="/inc/sub_visual1.jsp"/>

<div id="sub_content">
	<div class="container">
		<div class="reserveInfo">
			<h2><span>결제</span>가 완료되었습니다.</h2>
			<div class="infoBox">
				
				<!-- 임시이미지 -->
				<img src="img/sub/poster.jpg">
				
				<div class="rightBox">
					<p>주문번호 : 동일하게 ~</p>
					<table >
						<colgroup>
							<col width="20%"/>
							<col width="30%"/>
							<col width="20%"/>
							<col width="30%"/>
						</colgroup>
						<tr>
							<th>구매번호</th>
							<td>ex. 202020102031</td>
							<th>예매자</th>
							<td>ex.길동이</td>
						</tr>
						<tr>
							<th>상품명</th>
							<td colspan="3">ex.커플패키지</td>
						</tr>
						<tr>
							<th>구성품</th>
							<td colspan="3">ex.팝콘2 + 콜라1</td>
						</tr>					
						<tr>
							<th>유효기간</th>
							<td colspan="3">ex.구매후 1년</td>
						</tr>
						<tr>
							<th>?</th>
							<td colspan="3"></td>
						</tr>
					</table>
				</div><!-- .rightBox -->
			</div><!-- .infoBox -->
			<div class="btnBox">
				<a href="main.jsp" class="genric-btn primary circle">홈으로</a>
				<a href="#" class="genric-btn info circle">마이페이지</a>
			</div>
		</div><!-- .reserveInfo -->
	</div><!-- .container -->
</div><!-- #reserveResult -->

  
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

<!-- jquery plugins here-->
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