<%@page import="vo.MemberBean"%>
<%@page import="vo.ReserveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// String member_id=(String)session.getAttribute("id");

ReserveBean reserveInfo = (ReserveBean)request.getAttribute("reserveInfo");

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

<section id="reserveResult">
	<div class="container">
		<div class="reserveInfo">
			<dl>
				<dt>예매번호</dt>
				<dd><%=reserveInfo.getTicketnum() %></dd>
			</dl>
			<dl>
				<dt>영화</dt>
				<dd><%=reserveInfo.getMovie_subject() %></dd>
			</dl>
			<dl>
				<dt>상영관</dt>
				<dd><%=reserveInfo.getCinema_name()%></dd>
			</dl>
			<dl>
				<dt>일시</dt>
				<dd><%=reserveInfo.getShowdate() %><%=reserveInfo.getShowtime() %></dd>
			</dl>
			<dl>
				<dt>좌석</dt>
				<dd><%=reserveInfo.getSeatnum() %></dd>
			</dl>
			<dl>
				<dt>인원</dt>
				<dd>성인 : <%=reserveInfo.getAdultnum() %>, 청소년 및 아동 : <%=reserveInfo.getKidsnum() %></dd>
			</dl>
		</div><!-- .reserveInfo -->
	</div><!-- .container -->
</section><!-- #reserveResult -->

  
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