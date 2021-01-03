<%@page import="vo.QnaBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.NoticeBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	ArrayList<QnaBean> articleList = (ArrayList<QnaBean>)request.getAttribute("articleList");

	
	
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
	
// 	QnaBean article = (QnaBean)request.getAttribute("article");
// 	QnaBean article2 = (QnaBean)request.getAttribute("article2");
	
// 	String Member_id =(String)session.getAttribute("id");
	
	String member_id = (String)session.getAttribute("id"); // 
	
	String id = (String)request.getAttribute("id");
	
	
%>
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
	width: 33%;
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
</head>
<body>
	<!--::header part start::-->
	<jsp:include page="../inc/top.jsp" />
	<!-- Header part end-->
	<!--================Home Banner Area =================-->
	<!-- breadcrumb start-->
	<%
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
%>
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
				<a href="NoticeList.no" target="_parent">공지사항</a> <a href="NoticeFaq.no" target="_parent">FAQ</a> <a href="QnaList.qn" target="_parent">1대1 문의</a> 
			</div>
		</div>
	</section>
	<section id="listForm" class="checkout_area padding_top">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<h2>1대1 문의</h2>
					<%if(member_id==null){
		%>
					<h4>로그인한 회원만 이용 가능합니다.</h4>
					<%
		}
		%>
						<%
			
			
// 			if(articleList != null && listCount > 0) {
			if(articleList.size() != 0) {
			%>
					<table class="table">

						<%
				
				if(member_id!=null){
					
										
					
					%>
						<tr>
							<td align="center">번호</td>
							<td align="center">제 목</td>
							<td align="center">작성자</td>
							<td align="center">작성일</td>
							<td align="center">조회수</td>
						</tr>
					
					<%
						
							for(int i = 0; i < articleList.size(); i++) {
				%>
				
				
						<tr>
							<td align="center"><%=articleList.get(i).getNum() %></td>
							<td align="center">
								<%if(articleList.get(i).getRe_lev() != 0) { %>
								<%for(int j = 0; j <= articleList.get(i).getRe_lev() * 2; j++) { %>
								&nbsp;
								<%} %>
								└▶
								<%} %>
								&nbsp; <a href="QnaDetail.qn?num=<%=articleList.get(i).getNum() %>
															&page=<%=nowPage %>
															&re_ref=<%=articleList.get(i).getRe_ref() %>
															&re_lev=<%=articleList.get(i).getRe_lev() %>">
								 <%=articleList.get(i).getSubject() %>
								</a>
							<td align="center"><%=articleList.get(i).getMember_id() %></td>
							<td align="center"><%=sdf.format(articleList.get(i).getDate())%></td>
							<td align="center"><%=articleList.get(i).getReadcount() %></td>
						</tr>
								<%}%>

							
							
							
							
						<%}%>
					</table>
				</div>
			</div>
		</div>
	</section>
	<section id="buttonArea">
		<div class="container">
			<%
if(member_id!=null){
		%><input type="button" value="글쓰기" class="btn_3" onclick="location.href='QnaWriteForm.qn'">
			<div class="search">
				<form action="QnaListSearch.qn" method="post">
					<input type="text" name="search" class="input_box" placeholder="Search..">
				</form>
			</div>
			<%
	}
	%>
		</div>
	</section>
	<section id="pageList">
		<div class="container">
		<%
if(member_id!=null){
		%>
			<%if(nowPage <= 1) {%>
			<br>
			<input type="button" value="이전" class="btn_3">&nbsp;
			<%} else {%>
			<input type="button" value="이전" class="btn_3" onclick="location.href='QnaList.qn?page=<%=nowPage - 1 %>'">&nbsp;
			<%} %>
			<%for(int i = startPage; i <= endPage; i++) { 
			if(i == nowPage) { %>
			[<%=i %>]&nbsp;
			<%} else { %>
			<a href="QnaList.an?page=<%=i %>">[<%=i %>]
			</a>&nbsp;
			<%} %>
			<%} %>
			<%if(nowPage >= maxPage) { %>
			<input type="button" value="다음" class="btn_3">
			<%} else { %>
			<input type="button" value="다음" class="btn_3" onclick="location.href='QnaList.qn?page=<%=nowPage + 1 %>'">
			<%} %>
					<%
	}
	%>
		</div>
	</section>
	

	<% 
	}else {
	%>
			
	<section id="emptyArea">
		<div class="container">등록된 글이 없습니다</div>
	</section>
	<%
	if(member_id!=null){
	%>
	<section id="buttonArea">
		<div class="container">
			<input type="button" value="글쓰기" class="btn_3" onclick="location.href='QnaWriteForm.qn'">
		</div>
	</section>
	<%
	}
	%>
	<%
	}
	%>
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