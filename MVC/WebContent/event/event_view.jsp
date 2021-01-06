<%@page import="vo.EventBean"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Member"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.MemberDAO"%>
<%@page import="org.apache.tomcat.jni.Mmap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// BoardBean 객체 파라미터 가져오기
EventBean article = (EventBean) request.getAttribute("article");

// page 파라미터 가져오기
// 1. BoardDetailAction 에서 request.setAttribute() 메서드로 저장했을 경우
// 	String nowPage = (String)request.getAttribute("page");

// 2. 서블릿 주소로 전달된 page 값을 파라미터 그대로 사용할 경우
String nowPage = request.getParameter("page");

String member_id = (String) session.getAttribute("id"); // member_id (로그인한 아이디) 세션값 불러오기

int num = Integer.parseInt(request.getParameter("num"));
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

.content-view {
	white-space: pre-line;
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

<script type="text/javascript" src="js/jquery-1.12.1.min.js"></script>
<script type="text/javascript" src="js/jquery.bxslider.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<!--  내가 추가한 부분 표시하기 -->
<link rel="styleshhet" href="css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/base.css" />
<link rel="stylesheet" type="text/css" href="js/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/layout.css" />
<link rel="stylesheet" type="text/css" href="css/content.css" />
<link rel="stylesheet" type="text/css" href="css/utobiz.css" />
<link rel="stylesheet" type="text/css" href="css/bbs.css" />
<link rel="stylesheet" href="css/sub.css">
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
	<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	%>
	<section id="listForm" class="checkout_area padding_top">
		<div class="container">
			<div id="content">
				<div class="inr02">
					<!-- 컨텐츠 -->
					<div class="col-md-12 contents_sub">
						<h3>영화 이벤트</h3>
						<!-- S -->
						<div class="block" style="padding-top: 5px;">
							<div class="row" style="min-height: 500px;">
								<!-- 리스트 시작 -->
								<div class="bbs-document-wrap" itemscope itemtype="http://schema.org/Article">
									<div class="bbs-title" itemprop="name">
										<p><%=article.getSubject()%></p>
									</div>
									<div class="bbs-detail">
										<div class="detail-attr detail-writer">
											<div class="detail-name">글번호</div>
											<div class="detail-value"><%=article.getNum()%></div>
										</div>
										<div class="detail-attr detail-writer">
											<div class="detail-name">작성자</div>
											<div class="detail-value"><%=article.getMember_id()%></div>
										</div>
										<div class="detail-attr detail-date">
											<div class="detail-name">작성일</div>
											<div class="detail-value"><%=sdf.format(article.getDate())%></div>
										</div>
										<div class="detail-attr detail-view">
											<div class="detail-name">조회</div>
											<div class="detail-value"><%=article.getReadcount()%></div>
										</div>
										<div class="detail-attr detail-file">
											<div class="detail-name">파일</div>
											<div class="detail-value">
												<%
													if (article.getFile() != null) {
												%>
												<a href="event/file_down.jsp?downFile=<%=article.getFile()%>"><%=article.getFile()%></a>
												<%
													}
												%>
											</div>
										</div>
									</div>
									<div class="bbs-content" itemprop="description">
										<div class="content-view">
											<%
												if (article.getFile() != null) {
											%>
											<img src="eventUpload/<%=article.getFile()%>" />
											<%
												}
											%>
											<br>
											<%=article.getContent()%>
											<%
												if (article.getApply().equals("생성")) {
											%>
											<div>
												<script type="text/javascript">
													function b() {
														var b = confirm("응모하시겠습니까?");

														if (b) {
															fr.submit();
														} else {
															return false;
														}
													}
												</script>
												<form action="EventApplyInsert.ev" name="fr" method="post">
													<input type="hidden" name="num" value="<%=num%>" /> <input type="hidden" name="member_id" value="<%=member_id%>" /> <input type="hidden" name="page" value="<%=nowPage%>" />
													<!-- 														<input type="image" src="/img/btn_event.png" name="Submit" value="Submit"  align="absmiddle" onclick="return b()"> -->
													<button input type="submit">
														<img alt="응모" src="img/btn_event.png" onclick="return b()">
													</button>
												</form>
											</div>
											<%
												}
											%>
										</div>
										<!-- 								<div class="bbs-document-action"> -->
										<!--div class="left">
										<button type="button" class="bbs-button-action bbs-button-like" onclick="bbs_document_like(this)" data-uid="26" title="좋아요">좋아요 <span class="bbs-document-like-count">1</span></button>
										<button type="button" class="bbs-button-action bbs-button-unlike" onclick="bbs_document_unlike(this)" data-uid="26" title="싫어요">싫어요 <span class="bbs-document-unlike-count">7</span></button>
									</div>
									<div class="right">
										<button type="button" class="bbs-button-action bbs-button-print" onclick="bbs_document_print('')" title="인쇄">인쇄</button>
									</div-->
										<!-- 								</div> -->
										<div style="border-bottom: 1px solid #aea4a4;"></div>
										<!--div style="border-bottom:1px solid #aea4a4;"></div-->
										<!--form name="myForm" id="myForm" method="post" action="/web/bbs_view.geoje" enctype="multipart/form-data" class="form-inline">
								<input type="hidden" name="mode" value="up">
								<input Type="hidden" Name="bbs" Value="free">
								<input type="hidden" name="idx" value="1">
								<input type="hidden" name="page" value="1">
								<input type="hidden" name="s_que" value="">
								<input type="hidden" name="field" value="">
								<input type="hidden" name="so_arr" value="">
								<input type="hidden" name="so_name" value="">
								<div class="bbs-reply" style="margin:0;">
									<div class="content-view" style="margin:0;padding:0;">
										<table class="table" style="margin:5px;">
										<tr height="75">
											<td style="width:14%;text-align:center;color:#669de8;font-weight:600;">송호준</td>
											<td><textarea id="editor1" class="form-control" name="contents" style="width:100%;height:75px;"></textarea></td>
											<td style="width:17%;"><button type="button" class="btn btn-info" onClick="go_submits();">댓글저장</button></td>
										</tr>
										</table>
									</div>
								</div>
								</form-->
										<div style="border-bottom: 1px solid #aea4a4;"></div>
									</div>
									<div class="bbs-document-navi">
										<div class="bbs-prev-document"></div>
										<div class="bbs-next-document"></div>
									</div>
									<div class="bbs-control">
										<div style="text-align: center;">
											<a href="EventList.ev?page=<%=nowPage%>" target="_parent" class="bbs-button">목록보기</a>
										</div>
										<%
											if (member_id != null) {
											if (member_id.equals("admin")) {
										%>
										<div style="text-align: center;">
											<a href="EventModifyForm.ev?num=<%=article.getNum()%>&page=<%=nowPage%>" target="_parent" class="bbs-button">수정하기</a>
										</div>
	
										<div>
											<script type="text/javascript">
												function a() {
													var a = confirm("삭제하시겠습니까?");

													if (a) {
														fr.submit();
													} else {
														return false;
													}
												}
											</script>
											<form action="EventDeletePro.ev" name="fr" method="post">
												<input type="hidden" name="num" value="<%=num%>" /> <input type="hidden" name="page" value="<%=nowPage%>" /> <input type="submit" value="삭제하기" onclick="return a()" class="bbs-button">
											</form>
										</div>
										<%
											}
										}
										%>
									</div>
									<!-- 페이징 끝 -->
								</div>
							</div>
							<!-- E -->
						</div>
						<!-- //컨텐츠 -->
					</div>
				</div>
				<!-- //본문 -->
	</section>
	<!--       </div> container -->
	<!-- 	</section> listform -->
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