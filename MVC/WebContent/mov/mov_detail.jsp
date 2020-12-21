<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>aranaz</title>
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
		$('.stillcut_slider').slick({
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
			$('.stillcut_slider').slick('slickPlay'); 
			$(this).css('display','none');
			$('.stop_btn').css('display','block');
		});
		
		$('.stop_btn').click(function(){ // 스틸컷 슬라이더 정지
			$('.stillcut_slider').slick('slickPause');    
			$(this).css('display','none');
			$('.start_btn').css('display','block');
		});
		
		// 영화상세 탭메뉴
		$('ul.detail_tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');

			$('ul.detail_tabs li').removeClass('current');
			$('.tab-content').removeClass('current');

			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
		});
		
		// 트레일러 팝업창 띄우기
		$(".trailer_thumb").click(function(){ //레이어 팝업 열기 버튼 클릭 시
			$(this).next("div").css("display","block");
			$('.black_bg').css("display","block");
			$(this).next("div").children("iframe")[0].contentWindow.postMessage('{"event":"command","func":"' + 'playVideo' + '","args":""}', '*');
		});
		
		$(".close_btn").click(function(){ //닫기
			$(".trailer_popup").css("display","none");
			$('.black_bg').css("display","none");
			$(this).next("iframe")[0].contentWindow.postMessage('{"event":"command","func":"' + 'stopVideo' + '","args":""}', '*');
		});
		
		
		
	});

	</script>
</head>

<body>
	<div class="black_bg"></div><!-- .black_bg(트레일러 영상 시작시 검은배경) -->
  <!--::header part start::-->
	<jsp:include page="/inc/top.jsp"/>
  <!-- Header part end-->

<div id="sub_content" class="mov_detail">
	<div class="stillcut_box">
		<div class="stillcut_pager">
			<button class="prev">prev</button>
			<button class="next">next</button>
		</div>
		<ul class="stillcut_slider">
			<li><img src="img/sub/mov_detail/stillcut1.jpg"></li>
			<li><img src="img/sub/mov_detail/stillcut2.jpg"></li>
			<li><img src="img/sub/mov_detail/stillcut3.jpg"></li>
			<li><img src="img/sub/mov_detail/stillcut4.jpg"></li>
			<li><img src="img/sub/mov_detail/stillcut5.jpg"></li>
			<li><img src="img/sub/mov_detail/stillcut6.jpg"></li>
			<li><img src="img/sub/mov_detail/stillcut7.jpg"></li>
		</ul>
		<div class="stillcut_control">
			<span class="start_btn">start</span>
			<span class="stop_btn">stop</span>
		</div>
	</div><!-- .stillcut_Box -->
	
	<div class="container">
		<section class="detail_box1">
			<img src="img/sub/poster.jpg">
			<div class="detail_top">
				<h2 class="grade_15">조제</h2>
				<ul class="detail_info1">
					<li>
						<span>관람객 평점</span>
						<strong>7.6</strong>
					</li>
					<li>
						<span>예매율</span>
						<strong>3.9%</strong>
					</li>
					<li>
						<span>누적관객수</span>
						<strong>115,964<span>명</span></strong>
					</li>
				</ul><!-- .detail_info1 -->
				
				<div class="detail_info2">
					<dl>
						<dt>장르</dt>
						<dd>
							<span>멜로/로맨스, 드라마 / 한국</span>
							<span>2020.12.10 개봉</span>
							<span>117분</span>
						</dd>
					</dl>
					<dl>
						<dt>감독</dt>
						<dd>
							<span>김종관</span>
						</dd>
					</dl>
					<dl>
						<dt>출연</dt>
						<dd>
							<span>한지민, 남주혁</span>
						</dd>
					</dl>
				</div><!-- .detail_info2 -->
				<a href="http://localhost:8080/MVC/ReserveMain.re"  class="genric-btn primary circle">예매하기</a>
			</div><!-- .detail_top -->
		</section><!-- .detail_box1 -->
		
		<section class="detail_box2">
			<ul class="detail_tabs">
				<li class="tab-_ink current" data-tab="tab-1">영화정보</li>
				<li class="tab_link" data-tab="tab-2">평점 및 관람평</li>
			</ul><!-- .detail_tabs -->
			
			<div id="tab-1" class="tab-content current">
				<div class="story_cont">
					<h3>줄거리</h3>
					<p>할머니와 단둘이 사는 집, 그곳에서 책을 읽고 상상하며 자신만의 세계를 살고 있는 ‘조제’. 우연히 만난 그녀에게 특별한 감정을 느끼기 시작한 ‘영석’은 천천히, 그리고 솔직하게 다가가기 시작한다. 하지만 처음 경험해보는 사랑이 설레는 한편 가슴 아픈 ‘조제’는 자신에게 찾아온 낯선 감정을 밀어내는데… 기억할 거야 너와 함께한 모든 순간을</p>
				</div><!-- .story_cont -->
				<div class="trailer_cont">
					<h3>트레일러</h3>
					<!-- iframe 가져오고나서 src 주소값 뒤에 ?enablejsapi=1 꼭 붙여야함 ! -->
					<ul>
						<li>
							<div class="trailer_thumb">
								<img src="img/sub/mov_detail/thumbnail1.jpg">
								<span>1차 예고편</span>
							</div>
							<div class="trailer_popup">
								<button class="close_btn">X</button>
								<iframe src="https://www.youtube.com/embed/c7YepYEKK0c?enablejsapi=1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
							</div>
						</li>
						<li>
							<div class="trailer_thumb">
								<img src="img/sub/mov_detail/thumbnail2.jpg">
								<span>2차 예고편</span>
							</div>
							<div class="trailer_popup">
								<button class="close_btn">X</button>
								<iframe src="https://www.youtube.com/embed/M5tvXLIu2iE?enablejsapi=1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
							</div>
						</li>
						<li>
							<div class="trailer_thumb">
								<img src="img/sub/mov_detail/thumbnail3.jpg">
								<span>제작 다이어리 영상</span>
							</div>
							<div class="trailer_popup">
								<button class="close_btn">X</button>
								<iframe src="https://www.youtube.com/embed/ABm-pDyG_68?enablejsapi=1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
							</div>
						</li>
					</ul>
				</div><!-- .trailer_cont -->
				<div class="people_cont">
					<h3>감독 및 배우</h3>
					<ul>
						<li>
							<div><img src="img/sub/mov_detail/director_kim.jpg"></div>
							<strong>김종관<span>감독</span></strong>
							
						</li>
						<li>
							<div><img src="img/sub/mov_detail/actress_han.jpg"></div>
							<strong>한지민<span>배우</span></strong>
							
						</li>
						<li>
							<div><img src="img/sub/mov_detail/actor_nam.jpg"></div>
							<strong>남주혁<span>배우</span></strong>
							
						</li>
					</ul>
				</div><!-- .people_cont -->
			</div>
			<div id="tab-2" class="tab-content">평점 및 관람평</div>
			
			
		</section><!-- .detail_box2 -->
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