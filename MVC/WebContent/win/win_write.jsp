<%@page import="vo.WinBean"%>
<%@page import="vo.MemberBean"%>
<%@page import="dao.MemberDAO"%>
<%@page import="org.apache.tomcat.jni.Mmap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
// 	ArrayList<NoticeBean> articleList = (ArrayList<NoticeBean>)request.getAttribute("articleList");
	
//request 객체에 저장된 BoardBean 객체(article) 가져오기

//세션값 가져오기
String member_id = (String)session.getAttribute("id");



// int event_num= (Integer)session.getAttribute("event_num");


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

<link rel="stylesheet" type="text/css" href="css/bbs.css" />
</head>
<body>
	<!--::header part start::-->
	<jsp:include page="../inc/top.jsp" />
	<!-- Header part end-->
	<!-- 서브비주얼 -->
	<jsp:include page="/inc/sub_event1.jsp"/>
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
			<div class="inr02">
				<!--main content-->
					<h3>이벤트 당첨 발표글 쓰기</h3>
					<div class="block" style="padding-top: 5px;">
						<div class="row" style="min-height: 500px;">
							<!-- 게시판 -->
							<div class="bbs-view m_noview">
								<section id="writeForm">
									<form action="WinWritePro.wi" method="post"  name="eventform">
											
											<input type="hidden" name="mode" value="up">
											<input Type="hidden" Name="bbs" Value="free">
											<input Type="hidden" Name="num_a" Value="7">
											<input Type="hidden" Name="num_b" Value="9">
											<input Type="hidden" Name="htmltype" Value="HTML">
										<table>
<%-- 											<input type="hidden" name="num" value="<%=article.getEvent_num()%>" /> --%>
											<!-- 								<form action="NoticeWritePro.no" method="post"enctype="multipart/form-data" name="noticeform"> -->
											
											
											
											<colgroup>
												<col width="20%">
												<col width="80%">
											</colgroup>
											<tbody>
												<tr>
													<td class="bbs-list-a" >제 &nbsp; &nbsp; 목</td>
													<td class="bbs-list-b" >
														<input type="text" name="subject" value="" placeholder="제목 입력란" class="form-control" required="required">
													</td>
												</tr>
												
												<tr>
													<td class="bbs-list-a">I &nbsp; &nbsp; D</td>
													<td class="bbs-list-b">
														<input type="text" name="member_id" placeholder="아이디" class="form-control" value="<%=member_id %>" readonly>
													</td>
												</tr>												
												
																						
												
												<tr>
													<td class="bbs-list-a">이벤트 글 번호</td>
													<td class="bbs-list-b">
														<input type="text" name="event_num" placeholder="이벤트 글 번호" class="form-control"  required="required">
													</td>
												</tr>
												
												
						
												<tr>
													<td class="bbs-list-a">본 문</td>
													<td class="bbs-list-b">
														<textarea id="editor1" name="content" style="width: 100%; height: 500px; resize: none;"></textarea>
													</td>
												</tr>
											</tbody>
											<!-- 									<section id="commandCell"> -->
											<!-- 										<section id=commandCell> -->
											<!-- 									<input type="submit" value="등록">&nbsp;&nbsp; -->
											<!-- 									 <input type="reset" value="다시쓰기" /> -->
											<!-- 									</section> -->
											<!-- 								</table> -->
											<!-- 								<div style="height:20px;clear:both;"></div> -->
											<!-- 								<div style="width:100%;text-align:right;padding-right:30px;"><button type="button" class="btn btn-warning" onClick="go_url('NoticeList_no');">작성취소</button>  -->
											<!-- 								<button type="button" class="btn btn-info" onClick="go_submits();">작성완료</button></div> -->
											<!-- 							</div> -->
										</table>
										<section id="commandCell">
											<input type="submit" value="등록" class="genric-btn primary circle">&nbsp;&nbsp; <input type="reset" value="다시쓰기" class="genric-btn info circle" />
										</section>
									</form>
								</section>
								<!-- 게시판 -->
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>
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