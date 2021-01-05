<%@page import="vo.WinBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.NoticeBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전달받은 request 객체로부터 데이터 가져오기
// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
ArrayList<WinBean> articleList = (ArrayList<WinBean>) request.getAttribute("articleList");
PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
int nowPage = pageInfo.getPage();
int maxPage = pageInfo.getMaxPage();
int startPage = pageInfo.getStartPage();
int endPage = pageInfo.getEndPage();
int listCount = pageInfo.getListCount();

String member_id = (String) session.getAttribute("id");
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
	width: 25%;
	/* Four equal-width links. If you have two links, use 50%, and 33.33% for three links, etc.. */
	text-align: center; /* If you want the text to be centered */
}

/* Add a background color on mouse-over */
.topnav a:hover {
	background-color: #FF3368;
	color: #FFF !important;
}

/* div정리 */
.btnDiv {text-align: center;}
.btnDiv > div {display: inline-block;}
.btnWrite {margin-right: 100px;}
.search{margin-left: 200px;}
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

/* 검색 */
.search input[type=text] {
/* 	float: right; */
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
<link rel="stylesheet" href="css/sub.css">
</head>
<body>
	<!--::header part start::-->
	<jsp:include page="../inc/top.jsp" />
	<!-- Header part end-->
	<!-- 서브비주얼 -->
	<jsp:include page="/inc/sub_event1.jsp"/>
	<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	%>

	<!--================Blog Area =================-->
	<section class="blog_area padding_top">
		<div class="container">
			<div class="topnav">
				<a href="EventList.ev" target="_parent">영화</a>
				<a href="PreviewList.pr" target="_parent">시사회/무대인사</a> 
				<a href="WinList.wi" target="_parent">당첨자발표</a>
				<a href="EventListHot.ev" target="_parent"> HOT</a>
<!-- 				<a href="#"> </a> -->
			</div>
		</div>
	</section>
	<section id="listForm" class="checkout_area padding_top">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<h2>당첨자 발표</h2>
					<table class="table">
						<%
							if (articleList != null && listCount > 0) {
						%>
						<tr>
							<td align="center">번호</td>
							<td align="center">제 목</td>
							<td align="center">작성자</td>
							<td align="center">작성일</td>
							<td align="center">조회수</td>
						</tr>
						<%
							for (int i = 0; i < articleList.size(); i++) {
						%>
						<tr>
							<td align="center"><%=articleList.get(i).getNum()%></td>
							<td align="center"><a href="WinDetail.wi?num=<%=articleList.get(i).getNum()%>&page=<%=nowPage%>"> <%=articleList.get(i).getSubject()%>
							</a>
							<td align="center">admin</td>
							<td align="center"><%=sdf.format(articleList.get(i).getDate())%></td>
							<td align="center"><%=articleList.get(i).getReadcount()%></td>
						</tr>
						<%
							}
						%>
					</table>
				</div>
			</div>
		</div>
	</section>


	<div class="btnDiv">	
			<div class="btnWrite">
			
		<%
			if(member_id!=null){
							
						
				if (member_id.equals("admin")) {
			%>	
			
				<input type="button" value="글쓰기" class="btn_3" onclick="location.href='WinWriteForm.wi'">
			<%
				} else {
			%>			
				<input type="button" value="글쓰기" class="btn_3" onclick="alert('글쓰기 권한이 없습니다.');"/>	
			<%
				}
			
			}else{
				
			%>
				<input type="button" value="글쓰기" class="btn_3" onclick="alert('글쓰기 권한이 없습니다.');"/>
			<%	
			}
		%>
		
		</div>
		
		<div>
			<%if(nowPage <= 1) {%>
			
			<input type="button" value="이전" class="btn_3">&nbsp;
			<%} else {%>
			<input type="button" value="이전" class="btn_3" onclick="location.href='WinList.wi?page=<%=nowPage - 1 %>'">&nbsp;
			<%} %>
			<%for(int i = startPage; i <= endPage; i++) { 
			if(i == nowPage) { %>
			[<%=i %>]&nbsp;
			<%} else { %>
			<a href="WinList.wi?page=<%=i %>">[<%=i %>]
			</a>&nbsp;
			<%} %>
			<%} %>
			<%if(nowPage >= maxPage) { %>
			<input type="button" value="다음" class="btn_3">
			<%} else { %>
			<input type="button" value="다음" class="btn_3" onclick="location.href='WinList.wi?page=<%=nowPage + 1 %>'">
			<%} %>
		</div>
			
			<div class="search">
				<form action="WinListSearch.wi" method="post">
					<input type="text" name="search" class="input_box" placeholder="Search..">
					<input type="submit" name="searchBtn" class="btn_3" value="검색">
				</form>
			</div>
		</div>


	<%
		} else {
	%>
	<section id="emptyArea">
		<div class="container">등록된 글이 없습니다</div>
	</section>
	<section id="buttonArea">
 		<div class="container"> 
			<%
if(member_id!=null){
	if(member_id.equals("admin")){
		%><input type="button" value="글쓰기" class="btn_3" onclick="location.href='WinWriteForm.wi'">
		</div>
		<%
	}
}
%>
	</section>
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