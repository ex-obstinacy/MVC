<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.MovCommentBean"%>
<%@page import="vo.StoreBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberShipBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String member_id = (String) session.getAttribute("id");

	ArrayList<MovCommentBean> articleList = (ArrayList<MovCommentBean>) request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
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
						<!--         <section class="cart_area"> -->
						<div class="container">
							<div class="cart_inner">
							
							
								<div class="table-responsive">
									<table class="table">
										<%
											if (articleList != null && listCount > 0) {
										%>
										<tr>
											<th align="center">제목</th>
											<th align="center">내용</th>
											<th align="center">작성일</th>
											<th align="center">평점</th>
										</tr>
										<%
												for (int i = 0; i < articleList.size(); i++) {
										%>
										<tr>
											<td align="center">
												<a href="MovDetail.mo?movieCd=<%=articleList.get(i).getMovie_board_movCode() %>&page=<%=nowPage %>">
													<img src="movUpload/<%=articleList.get(i).getPost() %>" width="70"><br>
													<%=articleList.get(i).getSubjet() %>
												</a>
											</td>
											<td align="center"><%=articleList.get(i).getContent() %></td>
											<td align="center"><%=sdf.format(articleList.get(i).getDate()) %></td>
											<td align="center"><%=articleList.get(i).getCmgrade() %></td>
										</tr>
										<%
												}
											}
										%>
									</table>
								</div>
								
								
						<section id="pageList">
							<div class="container">
								<%
									if (nowPage <= 1) {
								%>
								<input type="button" value="이전" class="btn_3">&nbsp;
								<%
									} else {
								%>
								<input type="button" value="이전" class="btn_3" onclick="location.href='MemberMovComment.me?page=<%=nowPage - 1%>'">&nbsp;
								<%
									}
								%>
					
								<%
									for (int i = startPage; i <= endPage; i++) {
									if (i == nowPage) {
								%>
								[<%=i%>]&nbsp;
								<%
									} else {
								%>
								<a href="MemberMovComment.me?page=<%=i%>">[<%=i%>]
								</a>&nbsp;
								<%
									}
								%>
								<%
									}
								%>
					
								<%
									if (nowPage >= maxPage) {
								%>
								<input type="button" value="다음" class="btn_3">
								<%
									} else {
								%>
								<input type="button" value="다음" class="btn_3"
									onclick="location.href='MemberMovComment.me?page=<%=nowPage + 1%>'">
								<%
									}
								%>
							</div>
						</section>
							
							
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