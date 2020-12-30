<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<img src="img/sub/mov/trailer1.jpg">
			</li>
			<li>
				<img src="img/sub/mov/trailer2.jpg">
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
					<a href="#">더보기 ></a>
				</h2>
				<ul>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_12">12</span>
							<img src="img/sub/mov/poster_img1.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>원더 우먼 1984</h3>
							<p>
								<span class="rating">예매율 <b>66.2%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_15">15</span>
							<img src="img/sub/mov/poster_img2.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>조제</h3>
							<p>
								<span class="rating">예매율 <b>4.0%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_15">15</span>
							<img src="img/sub/mov/poster_img3.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>라이어트 : 기계들의 역습</h3>
							<p>
								<span class="rating">예매율 <b>4.0%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_15">15</span>
							<img src="img/sub/mov/poster_img4.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>화양연화</h3>
							<p>
								<span class="rating">예매율 <b>4.0%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_15">15</span>
							<img src="img/sub/mov/poster_img5.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>썸머 85</h3>
							<p>
								<span class="rating">예매율 <b>4.0%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
				</ul>
			</div><!-- .now_ranking -->
			
			<div class="screen_ranking ranking_box">
				<h2>상영 예정작 <strong>TOP 5</strong>
					<a href="#">더보기 ></a>
				</h2>
				<ul>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_12">12</span>
							<img src="img/sub/mov/poster_img1.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>원더 우먼 1984</h3>
							<p>
								<span class="rating">예매율 <b>66.2%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_15">15</span>
							<img src="img/sub/mov/poster_img2.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>조제</h3>
							<p>
								<span class="rating">예매율 <b>4.0%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_15">15</span>
							<img src="img/sub/mov/poster_img3.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>라이어트 : 기계들의 역습</h3>
							<p>
								<span class="rating">예매율 <b>4.0%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_15">15</span>
							<img src="img/sub/mov/poster_img4.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>화양연화</h3>
							<p>
								<span class="rating">예매율 <b>4.0%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
					<li>
						<div class="img_box">
							<div class="black_box">
								<a href="#">상세정보</a>
							</div><!-- .black_box -->
							<span class="grade gr_15">15</span>
							<img src="img/sub/mov/poster_img5.jpg">							
						</div><!-- .img_box -->
						<div class="mov_info">
							<h3>썸머 85</h3>
							<p>
								<span class="rating">예매율 <b>4.0%</b></span>
								<span class="score"><b>7.6</b></span>
							</p>
						</div><!-- .mov_info -->
					</li>
				</ul>
			</div><!-- .screen_ranking -->
			
			<div class="under_banner">
				<a href="#">
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