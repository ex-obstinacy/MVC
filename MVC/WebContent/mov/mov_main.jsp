<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.MovBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	// 현재 상영작 객체 가져오기
	ArrayList<MovBean> currentMovList = (ArrayList<MovBean>) request.getAttribute("currentMovList");
	// 상영 예정작 객체 가져오기
	ArrayList<MovBean> toBeMovList = (ArrayList<MovBean>) request.getAttribute("toBeMovList");
	
%>

<!DOCTYPE html>
<html lang="zxx">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
  <link rel="stylesheet" href="css/slick.css"/>
	<link rel="stylesheet" href="css/slick-theme.css"/>

	<script src="js/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){ 
		// 스틸컷 슬라이더
		$('.trailer_slider').slick({
			  slidesToShow: 1,
			  slidesToScroll: 1,
			  autoplay: true,
			  autoplaySpeed: 4000,
			  speed: 300,
			  infinite: true,
			  dots : true,
			  dotsClass : "slick-dots",
			  nextArrow:$('.next'),
			  prevArrow:$('.prev'),
		});
		
		$('.start_btn').click(function(){   // 스틸컷 슬라이더 시작
			$('.trailer_slider').slick('slickPlay'); 
			$(this).css('display','none');
			$('.stop_btn').css('display','block');
		});
		
		$('.stop_btn').click(function(){ // 스틸컷 슬라이더 정지
			$('.trailer_slider').slick('slickPause');    
			$(this).css('display','none');
			$('.start_btn').css('display','block');
		});
		
		
		
		
	});

	</script>
</head>

<body>
	<!-- TOP 이동 버튼 -->
<%-- 	<jsp:include page="../inc/btn_top.jsp"/> --%>
	
  <!--::header part start::-->
	<jsp:include page="/inc/top.jsp"/>
  <!-- Header part end-->

	<div class="mov_trailer">
		<div class="trailer_pager">
			<span class="prev">prev</span>
			<span class="next">next</span>
		</div>
		<ul class="trailer_slider">
			<li>
				<a href="MovDetail.mo?movieCd=20201002">
					<img src="img/sub/mov/trailer1.jpg">
				</a>
			</li>
			<li>
				<a href="MovDetail.mo?movieCd=20192567">
					<img src="img/sub/mov/trailer2.jpg">
				</a>
			</li>
		</ul>
		<div class="trailer_control">
			<span class="start_btn">start</span>
			<span class="stop_btn">stop</span>
		</div>
	</div><!-- .mov_trailer -->

	<div id="sub_content" class="mov_main">
		<div class="container">
			<div class="now_ranking ranking_box">
				<h2>현재 상영작 <strong>TOP 5</strong>
					<a href="MovCurrentMain.mo">더보기 ></a>
				</h2>
				<ul>
					<%
						for (int i = 0; i < currentMovList.size(); i++) {
							
					%>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="MovDetail.mo?movieCd=<%=currentMovList.get(i).getMovieCd() %>">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_<%=currentMovList.get(i).getGrade() %>"><%=currentMovList.get(i).getGrade() %></span>
							<img src="movUpload/<%=currentMovList.get(i).getPost() %>">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3><%=currentMovList.get(i).getSubjet() %></h3>
							<p>
								<span class="rating">예매율 <b><%=currentMovList.get(i).getBookingRate() %>%</b></span>
								<span class="score"><b><%=currentMovList.get(i).getTotalRating() %></b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<%
						}
					%>
				</ul>
			</div><!-- .now_ranking -->
			
			<div class="screen_ranking ranking_box">
				<h2>상영 예정작 <strong>TOP 5</strong>
					<a href="MovToBeMain.mo">더보기 ></a>
				</h2>
				<ul>
					<%
						for (int i = 0; i < toBeMovList.size(); i++) {
					%>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href=MovDetail.mo?movieCd=<%=toBeMovList.get(i).getMovieCd() %>>상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_<%=toBeMovList.get(i).getGrade() %>"><%=toBeMovList.get(i).getGrade() %></span>
							<img src="movUpload/<%=toBeMovList.get(i).getPost() %>">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3><%=toBeMovList.get(i).getSubjet() %></h3>
							<p>
								<span class="rating">개봉예정일 <b><%=toBeMovList.get(i).getOpenDt() %></b></span>
								<span class="score"><b><%=toBeMovList.get(i).getTotalRating() %></b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<%
						}
					%>
				</ul>
			</div><!-- .screen_ranking -->
			
			<div class="under_banner">
				<a href="MovDetail.mo?movieCd=20201002">
					<img src="img/sub/mov/banner_img1.jpg">
				</a>
			</div><!-- .under_banner -->
		</div><!-- .container -->
		
	</div><!-- #sub_content -->

  <!--::footer_part start::-->
  <jsp:include page="/inc/bottom.jsp"/>
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
  <script src="js/stellar.js"></script>
  <script src="js/price_rangs.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
</body>

</html>