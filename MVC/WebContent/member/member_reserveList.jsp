<%@page import="vo.ReserveBean"%>
<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	ArrayList<ReserveBean> articleList = (ArrayList<ReserveBean>) request.getAttribute("articleList");
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
									<li class="active"><a href="MemberReserveList.me">예매내역</a></li>
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
							<h2 class="member_title">예매내역</h2><!-- .member_title -->
							<%
								if(articleList.size() != 0) {
							%>
							<table class="table">
							<%
								if (articleList != null && listCount > 0) {
							%>
							<colgroup>
								<col width="15%">
								<col width="25%">
								<col width="5%">
								<col width="25%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<tr>
								<th>예매번호</th>
								<th>영화제목</th>
								<th>상영관</th>
								<th>관람일 / 시간</th>
								<th>좌석</th>
								<th>인원</th>
							</tr>
							<%
								for (int i = 0; i < articleList.size(); i++) {
							%>
							
							<tr>
								<td><a href="MemberReserveDetail.me?ticketnum=<%=articleList.get(i).getTicketnum() %>&moviecode=<%=articleList.get(i).getMovie_code() %>&page=<%=nowPage %>"><%=articleList.get(i).getTicketnum() %></a></td>
								<td><%=articleList.get(i).getMovie_subject() %></td>
								<td><%=articleList.get(i).getCinema_name() %>점</td>
								<td><%=articleList.get(i).getShowdate() %> / <%=articleList.get(i).getShowtime() %></td>
								<td><%=articleList.get(i).getSeatnum() %></td>
								<td>성인 : <%=articleList.get(i).getAdultnum() %>명, 아동 및 청소년 : <%=articleList.get(i).getKidsnum() %></td>
							</tr>
								<%	} %>
							<%	} %>
							</table>
							
							<section id="pageList" style="text-align: center;width: 100%">
								<div class="container">
								<%
									if(id!=null){
										if(nowPage <= 1) {
								%>
									<input type="button" value="이전" class="btn_3">&nbsp;
										<%} else {%>
									<input type="button" value="이전" class="btn_3" onclick="MemberReserveList.me?page=<%=nowPage - 1 %>'">&nbsp;
										<%}
										for(int i = startPage; i <= endPage; i++) { 
											if(i == nowPage) { 
										%>
									[<%=i %>]&nbsp;
											<%} else { %>
									<a href="MemberReserveList.me?page=<%=i%>">[<%=i%>]</a>&nbsp;
											<%} %>
										<%} %>
										<%if(nowPage >= maxPage) { %>
									<input type="button" value="다음" class="btn_3">
										<%} else { %>
									<input type="button" value="다음" class="btn_3" onclick="MemberReserveList.me?page=<%=nowPage + 1 %>'">
										<%} %>
									<%}%>
								</div>
							</section>
							<% 
							}else {
							%>
									
							<section id="emptyArea">
								<div class="container">예매 내역이 없습니다.</div>
							</section>
							<%
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