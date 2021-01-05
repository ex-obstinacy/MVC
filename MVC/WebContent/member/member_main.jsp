<%@page import="vo.StoreBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberShipBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String member_id = (String) session.getAttribute("id");

	// MemberShip 객체 받아오기
	MemberShipBean memberShip = (MemberShipBean) request.getAttribute("memberShip");
%>

<!DOCTYPE html>
<html lang="zxx">

<head>
<style type="text/css">
.oldprice {
	text-decoration: line-through;
	color: #BDBDBD;
}
</style>

<%
	if (member_id == null) {
%>
<script type="text/javascript">
	alert("로그인이 필요합니다.");
	location.href = "MemberLogin.me";
</script>
<%
	}
%>


<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
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

<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/sub.css">

</head>

<body>
	<!--::header part start::-->
	<jsp:include page="../inc/top.jsp" />
	<!-- Header part end-->
    <!--     서브비주얼 -->
	<jsp:include page="/inc/sub_main1.jsp"/>

	<!--================ 메뉴 영역 =================-->
	<section class="cart_area">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<div class="left_sidebar_area">
						<aside class="left_widgets p_filter_widgets">
							<div class="l_w_title"></div>
							<div class="side_menu">
								<h3>마이페이지</h3>
								<ul class="list side_list">
									<li class="active"><a href="MemberMain.me">나의 등급</a></li>
									<li><a href="MemberReserveList.me">예매내역</a></li>
									<li><a href="MemberOrderList.me">결제내역</a></li>
									<li><a href="BasketList.go">장바구니</a></li>
									<li><a href="MemberMovComment.me">리뷰내역</a></li>
									<li><a href="MemberQnADetail.me">1:1문의</a></li>
									<li><a href="MemberInfo.me">My 정보</a></li>
									<li><a href="MemberDelete.me">회원 탈퇴</a></li>
								</ul>
							</div><!-- .side_menu -->
						</aside>
					</div>
				</div>
				<!--================ 메뉴 영역 =================-->
				<div class="col-lg-9">
					<div class="row align-items-center latest_product_inner">
						<!--         <section class="cart_area"> -->
						<div class="container">
							<div class="cart_inner">
								<h2 class="member_title">나의 등급</h2><!-- .member_title -->
								<%
									if (memberShip.getGrade().equals("VIP")) {
								%>
									<div class="membership_box">
										<p>현재 멤버쉽포인트는 <span class="point"><%=memberShip.getPoint()%></span>로 <span class="member_gr vip"><%=memberShip.getGrade() %></span>등급입니다.</p>
										<p>항상 이용해주셔서 감사합니다!</p>
									</div><!-- .membership_box -->
								<%
									} else if(memberShip.getGrade().equals("GOLD")){								
								%>
									<div class="membership_box">
										<p>현재 멤버쉽포인트는 <span class="point"><%=memberShip.getPoint()%></span>포인트로 <span class="member_gr gold"><%=memberShip.getGrade() %></span>등급입니다.</p>
										<p><span class="member_gr vip"><%=memberShip.getNextGrade() %></span>등급까지 남은 멤버쉽포인트는 <span class="point"><%=memberShip.getNextPoint() - memberShip.getPoint() %></span>포인트입니다.</p>
									</div><!-- .membership_box -->
								<%
									} else if(memberShip.getGrade().equals("SILVER")){								
								%>
									<div class="membership_box">
										<p>현재 멤버쉽포인트는 <span class="point"><%=memberShip.getPoint()%></span>로 <span class="member_gr silver"><%=memberShip.getGrade() %></span>등급입니다.</p>
										<p><span class="member_gr gold"><%=memberShip.getNextGrade() %></span>등급까지 남은 멤버쉽포인트는 <span class="point"><%=memberShip.getNextPoint() - memberShip.getPoint() %></span>입니다.</p>
									</div><!-- .membership_box -->
								<%
									} else if(memberShip.getGrade().equals("BRONZE")){								
								%>
									<div class="membership_box">
										<p>현재 멤버쉽포인트는 <span class="point"><%=memberShip.getPoint()%></span>로 <span class="member_gr bronze"><%=memberShip.getGrade() %></span>등급입니다.</p>
										<p><span class="member_gr silver"><%=memberShip.getNextGrade() %></span>등급까지 남은 멤버쉽포인트는 <span class="point"><%=memberShip.getNextPoint() - memberShip.getPoint() %></span>입니다.</p>
									</div><!-- .membership_box -->
	                    		<%
									}
	                    		%>
	                    			<table class="membership_info">
	                    				<colgroup>
	                    					<col width="10%"/>
	                    					<col width="22.5%"/>
	                    					<col width="22.5%"/>
	                    					<col width="22.5%"/>
	                    					<col width="22.5%"/>
	                    				</colgroup>
	                    				<tr>
	                    					<th>등급</th>
	                    					<th><span class="bronze"></span>BRONZE</th>
	                    					<th><span class="silver"></span>SILVER</th>
	                    					<th><span class="gold"></span>GOLD</th>
	                    					<th><span class="vip"></span>VIP</th>
	                    				</tr>
	                    				<tr>
	                    					<td>조건</td>
	                    					<td>회원가입시 적용</td>
	                    					<td>멤버쉽포인트 1000포인트 이상</td>
	                    					<td>멤버쉽포인트 2000포인트 이상</td>
	                    					<td>멤버쉽포인트 3000포인트 이상</td>
	                    				</tr>
	                    				<tr>
	                    					<td>혜택</td>
	                    					<td>-</td>
	                    					<td>매년 영화관람권 1개 지급</td>
	                    					<td>매년 영화관람권 3개 지급</td>
	                    					<td>매년 영화관람권 6개 지급</td>
	                    				</tr>
	                    			</table><!-- .membership_info -->
							
							</div>
						</div>
						<!--   </section> -->

					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Category Product Area =================-->


	<!--::footer_part start::-->
	<jsp:include page="../inc/bottom.jsp" />
	<!--::footer_part end::-->

	<!-- jquery plugins here-->
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