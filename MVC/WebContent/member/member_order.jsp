<%@page import="vo.StoreBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//session 객체에 저장된 id 값 가져와서 변수에 저장
String id = (String)session.getAttribute("id");

ArrayList<StoreBean> orderList = (ArrayList<StoreBean>)request.getAttribute("orderList");

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
    <!--::header part start::-->
    <jsp:include page="../inc/top.jsp"/>
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
							<div class="widgets_inner">
								<ul class="list">
									<li><a href="MemberReserveList.me">예매내역</a></li>
									<li><a href="MemberOrderList.me">결제내역</a></li>
									<li><a href="BasketList.go">장바구니</a></li>
									<li><a href="MemberMovComment.me">리뷰내역</a></li>
									<li><a href="MemberQnADetail.me">1:1문의</a></li>
									<li><a href="MemberInfo.me">My 정보</a></li>
									<li><a href="MemberDelete.me">회원 탈퇴</a></li>
								</ul>
							</div>
						</aside>
					</div>
				</div>
	<!--================ 메뉴 영역 =================-->		
	
<div class="col-lg-9">
  <div class="row align-items-center latest_product_inner">
	<div class="container">
		<div class="member_order">
			<h2>결제 내역</h2>
			<!-- 임시이미지 -->
					<%
					if(orderList != null){
					
					for(int i= 0; i< orderList.size(); i++){
					%>
			<div class="infoBox">
				<img src="goodsUpload/<%=orderList.get(i).getFile() %>">
				
				<div class="rightBox">
					<p>교환권번호 : <%=orderList.get(i).getReserveNum() %></p>
					<table >
					
					
					
						<colgroup>
							<col width="20%"/>
							<col width="30%"/>
							<col width="20%"/>
							<col width="30%"/>
						</colgroup>
						<tr>
							<th>주문번호</th>
							<td><%=orderList.get(i).getOrderNum() %></td>
<!-- 							<th>구매자</th> -->
<%-- 							<td><%=orderList.get(i).getMember_name()%></td> --%>
						</tr>
						<tr>
							<th>상품명</th>
							<td colspan="3"><%=orderList.get(i).getName()%></td>
						</tr>
						<tr>
							<th>구성품</th>
							<td colspan="3"><%=orderList.get(i).getComponent()%></td>
						</tr>					
						<tr>
							<th>유효기간</th>
							<td colspan="3"><%=orderList.get(i).getExpiredate()%></td>
						</tr>
					</table>
				</div><!-- .rightBox -->
			</div><!-- .infoBox -->
						<%	
					}
					
						
					}
					%>
			<div class="btnBox">
				<a href="Main" class="genric-btn primary circle">홈으로</a>
				<a href="MemberMain.me" class="genric-btn info circle">마이페이지</a>
			</div>
		</div><!-- .reserveInfo -->
	</div><!-- .container -->
</div><!-- #reserveResult -->
			</div>
		</div>
	</section>
  
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