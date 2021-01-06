<%@page import="vo.StoreBean"%>
<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	ArrayList<StoreBean> articleList = (ArrayList<StoreBean>) request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
%>

<!DOCTYPE html>
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

<style>
	th{background:#eee;}
	th, td{text-align:center; word-break:keep-all;}
</style>
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
									<li><a href="MemberMain.me">나의 등급</a></li>
									<li><a href="MemberReserveList.me">예매내역</a></li>
									<li class="active"><a href="MemberOrderList.me">결제내역</a></li>
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
							<h2 class="member_title">결제내역</h2><!-- .member_title -->
							<%
								if(articleList.size() != 0) {
							%>
							<table class="table">
							<%
								if (articleList != null && listCount > 0) {
							%>
							<colgroup>
								<col width="20%">
								<col width="25%">
								<col width="30%">
								<col width="15%">
								<col width="10%">
							</colgroup>
							<tr>
								<th>구매일</th>
								<th>주문번호</th>
								<th>상품명</th>
								<th>결제금액</th>
								<th>구매자</th>
							</tr>
							<%
								for (int i = 0; i < articleList.size(); i++) {
// 									int orderCount = articleList.get(i).getOrderCount() -1;
									int count = 0;
									for (int x=0; x<articleList.size(); x++) {
										if (articleList.get(i).getOrderNum().equals(articleList.get(x).getOrderNum())) {
											count++;
										}
									}
									if (count == 1) {
							%>
							<tr>
								<td><%=articleList.get(i).getDate() %></td>
								<td><a href="MemberOrderDetail.me?orderNum=<%=articleList.get(i).getOrderNum() %>"><%=articleList.get(i).getOrderNum() %></a></td>
<%-- 								<%if(orderCount == 0){ %> --%>
								<td><%=articleList.get(i).getName() %></td>
<%-- 								<%} else { %> --%>
<%-- 								<td align="center"><%=articleList.get(i).getName() %> 외 <%=orderCount %></td> --%>
<%-- 								<% } %> --%>
								<td><%=articleList.get(i).getSumPrice() %></td>
								<td><%=articleList.get(i).getMember_name() %></td>
							</tr>
							<%
									} else {
							%>
							<tr>
								<td><%=articleList.get(i).getDate() %></td>
								<td><a href="MemberOrderDetail.me?orderNum=<%=articleList.get(i).getOrderNum() %>"><%=articleList.get(i).getOrderNum() %></a></td>
								<td><%=articleList.get(i).getName() %> 외 <%=count-1 %></td>
								<td><%=articleList.get(i).getSumPrice() %></td>
								<td><%=articleList.get(i).getMember_name() %></td>
							</tr>
							
							<%			
									i = i + count -1;
									}
								} 
							%>
							</table>
							
							<section id="pageList" style="text-align: center;width: 100%">
								<div class="container">
								<%
									if(id!=null){
										if(nowPage <= 1) {
								%>
									<input type="button" value="이전" class="btn_3">&nbsp;
										<%} else {%>
									<input type="button" value="이전" class="btn_3" onclick="MemberOrderList.me?page=<%=nowPage - 1 %>'">&nbsp;
										<%}
										for(int i = startPage; i <= endPage; i++) { 
											if(i == nowPage) { 
										%>
									[<%=i %>]&nbsp;
											<%} else { %>
									<a href="MemberOrderList.me?page=<%=i%>">[<%=i%>]</a>&nbsp;
											<%} %>
										<%} %>
										<%if(nowPage >= maxPage) { %>
									<input type="button" value="다음" class="btn_3">
										<%} else { %>
									<input type="button" value="다음" class="btn_3" onclick="MemberOrderList.me?page=<%=nowPage + 1 %>'">
										<%} %>
									<%}%>
								</div>
							</section>
							<% 
							}else {
							%>
									
							<section id="emptyArea">
								<div class="container">결제 내역이 없습니다.</div>
							</section>
							<%
							}
							}
							%>
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