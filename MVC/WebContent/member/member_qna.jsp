<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.QnaBean"%>
<%@page import="vo.StoreBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberShipBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String member_id = (String) session.getAttribute("id");

	ArrayList<QnaBean> articleList = (ArrayList<QnaBean>)request.getAttribute("articleList");

	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	
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
									<li><a href="MemberMain.me">나의 등급</a></li>
									<li><a href="MemberReserveList.me">예매내역</a></li>
									<li><a href="MemberOrderList.me">결제내역</a></li>
									<li><a href="BasketList.go">장바구니</a></li>
									<li><a href="MemberMovComment.me">리뷰내역</a></li>
									<li class="active"><a href="MemberQnADetail.me">1:1문의</a></li>
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
							<h2 class="member_title">1:1문의</h2><!-- .member_title -->
							<%
								if(articleList.size() != 0) {
							%>
							<table class="table">
							<%
								if(member_id!=null){
							%>
								<tr>
									<td align="center">작성일</td>
									<td align="center">제 목</td>
									<td align="center">작성자</td>
									<td align="center">조회수</td>
								</tr>
								<%
									for(int i = 0; i < articleList.size(); i++) {
								%>
								<tr>
									<td align="center"><%=sdf.format(articleList.get(i).getDate())%></td>
									<td align="center">
										<%if(articleList.get(i).getRe_lev() != 0) {
											for(int j = 0; j <= articleList.get(i).getRe_lev() * 2; j++) { %>
										&nbsp;
										<%} %>
										└▶
										<%} %>
										&nbsp; 
										<a href="QnaDetail.qn?num=<%=articleList.get(i).getNum() %>&page=<%=nowPage %>&re_ref=<%=articleList.get(i).getRe_ref() %>&re_lev=<%=articleList.get(i).getRe_lev() %>">
											<%=articleList.get(i).getSubject() %>
										</a>
									<td align="center"><%=articleList.get(i).getMember_id() %></td>
									<td align="center"><%=articleList.get(i).getReadcount() %></td>
								</tr>
								<%	} %>
							<%	} %>
							</table>
							
							<section id="pageList">
								<div class="container">
								<%
									if(member_id!=null){
										if(nowPage <= 1) {
								%>
									<input type="button" value="이전" class="btn_3">&nbsp;
										<%} else {%>
									<input type="button" value="이전" class="btn_3" onclick="location.href='MemberQnADetail.me?page=<%=nowPage - 1 %>'">&nbsp;
										<%}
										for(int i = startPage; i <= endPage; i++) { 
											if(i == nowPage) { 
										%>
									[<%=i %>]&nbsp;
											<%} else { %>
									<a href="MemberQnADetail.me?page=<%=i %>">[<%=i %>]</a>&nbsp;
											<%} %>
										<%} %>
										<%if(nowPage >= maxPage) { %>
									<input type="button" value="다음" class="btn_3">
										<%} else { %>
									<input type="button" value="다음" class="btn_3" onclick="location.href='MemberQnADetail.me?page=<%=nowPage + 1 %>'">
										<%} %>
									<%}%>
								</div>
							</section>
							<% 
							}else {
							%>
									
							<section id="emptyArea">
								<div class="container">등록된 글이 없습니다</div>
							</section>
							<section id="buttonArea">
								<div class="container">
									<input type="button" value="1대1 문의" class="btn_3" onclick="location.href='QnaList.qn'">
								</div>
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