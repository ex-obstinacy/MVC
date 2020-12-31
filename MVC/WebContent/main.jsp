<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
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
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="css/all.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="css/magnific-popup.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="css/slick.css"/>
	<link rel="stylesheet" href="css/slick-theme.css"/>
    <!-- style CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/main.css">
    
   <script src="js/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function() {
    	// 예매순위 슬라이더
		$('.rank_slider').slick({
			  slidesToShow: 5,
			  slidesToScroll: 1,
			  autoplay: false,
			  speed: 300,
			  infinite: false,
			  nextArrow:$('.next'),
			  prevArrow:$('.prev'),
		});    	
		
    	// 예매순위 화살표 보이기/없애기
		if($('.rank_box li:first').hasClass("slick-active") == true){
			$('.rank_box .prev').css("display","none");
		};
		
    	$('.rank_box .next').click(function(){
    		if($('.rank_box li:first').hasClass("slick-active") == false){
    			$('.rank_box .prev').css("display","block");
    		};
    		
    		if($('.rank_box li:last').hasClass("slick-active") == true){
    			$('.rank_box .next').css("display","none");
    		};
    	});
    	
    	$('.rank_box .prev').click(function(){
	    	if($('.rank_box li:first').hasClass("slick-active") == true){
				$('.rank_box .prev').css("display","none");
			};
			if($('.rank_box li:last').hasClass("slick-active") == false){
    			$('.rank_box .next').css("display","block");
    		};
    	});
    	
    	// 공지사항 롤링 메뉴
    	$('.rolling_notice ul').slick({
			  slidesToShow: 1,
			  slidesToScroll: 1,
			  autoplay: true,
			  vertical: true,
			  speed: 700,
			  autoplaySpeed: 2000,
			  arrows: false
		});
    	
    	
		
    });
    
    </script> 
</head>

<body>
    <!--헤더-->
    <jsp:include page="inc/top.jsp"/>
    <!-- 헤더 끝-->

    <!-- 메인슬라이더 시작-->
    <section class="banner_part">
            <div class="row align-items-center">
                <div class="col-lg-12">
                    <div class="banner_slider owl-carousel">
                        <div class="single_banner_slider">
                        	<a  href="MovDetail.mo?movieCd=20192567">
	                             <img src="img/main/main_slide1.jpg" alt=""><!-- 메인슬라이더 1 이미지 -->
                        	</a>
                        </div>
                        <div class="single_banner_slider">
                        	<a  href="MovDetail.mo?movieCd=20201002">
                                <img src="img/main/main_slide2.jpg" alt=""><!-- 메인슬라이더 2 이미지 -->
                        	</a>
                        </div>
                    </div><!-- .banner_slider -->
                </div><!-- .col-lg-12 -->
            </div><!-- .<div class="row align-items-center"> -->
    </section><!-- .banner_part -->
    <!-- 메인슬라이더 끝-->
    
    <!-- #main_container -->
    <div id="main_container">
    	<div class="container">
	    	<!-- 예매순위 -->
		    <section class="reserve_ranking">
		    	<h2>예매순위</h2>
		    	<div class="rank_box">
		    		<i class="fas fa-chevron-left prev"></i> 
		        	<i class="fas fa-chevron-right next"></i>
		    		<ul class="rank_slider">
		    			<li>
		    				<div class="rank_img">
		    					<div class="black_box">
									<a href="#">상세정보</a>
								</div><!-- .black_box -->
		    					<span class="grade gr_15">15</span>
		    					<img src="img/main/main_poster1.jpg" alt="">
		    				</div>		    				
		    				<div class="rank_info">
		    					<h3 class="rank_subject">조제</h3>
		    					<p>
									<span class="rating">예매율 <b>66.2%</b></span>
									<span class="score"><b>7.6</b></span>
								</p>
		    				</div>
		    			</li>
		    			<li>
		    				<div class="rank_img">
		    					<div class="black_box">
									<a href="#">상세정보</a>
								</div><!-- .black_box -->
			    				<span class="grade gr_12">12</span>
			    				<img src="img/main/main_poster2.jpg" alt="">
		    				</div>
		    				<div class="rank_info">
		    					<h3 class="rank_subject">도굴</h3>
		    					<p>
									<span class="rating">예매율 <b>66.2%</b></span>
									<span class="score"><b>7.6</b></span>
								</p>
		    				</div>
		    			</li>
		    			<li>
		    				<div class="rank_img">
		    					<div class="black_box">
									<a href="#">상세정보</a>
								</div><!-- .black_box -->
		    					<span class="grade gr_18">청불</span>
		    					<img src="img/main/main_poster3.jpg" alt="">
		    				</div>
		    				<div class="rank_info">
		    					<h3 class="rank_subject">런</h3>
		    					<p>
									<span class="rating">예매율 <b>66.2%</b></span>
									<span class="score"><b>7.6</b></span>
								</p>
		    				</div>
		    			</li>
		    			<li>
		    				<div class="rank_img">
		    					<div class="black_box">
									<a href="#">상세정보</a>
								</div><!-- .black_box -->
		    					<span class="grade gr_all">전체</span>
		    					<img src="img/main/main_poster4.jpg" alt="">
		    				</div>
		    				<div class="rank_info">
		    					<h3 class="rank_subject">이웃사촌</h3>
		    					<p>
									<span class="rating">예매율 <b>66.2%</b></span>
									<span class="score"><b>7.6</b></span>
								</p>
		    				</div>
		    			</li>
		    			<li>
		    				<div class="rank_img">
		    					<div class="black_box">
									<a href="#">상세정보</a>
								</div><!-- .black_box -->
		    					<span class="grade gr_12">12</span>
		    					<img src="img/main/main_poster5.jpg" alt="">
		    				</div>
		    				<div class="rank_info">
		    					<h3 class="rank_subject">리플레이</h3>
		    					<p>
									<span class="rating">예매율 <b>66.2%</b></span>
									<span class="score"><b>7.6</b></span>
								</p>
		    				</div>
		    			</li>
		    			<li>
		    				<div class="rank_img">
		    					<div class="black_box">
									<a href="#">상세정보</a>
								</div><!-- .black_box -->
		    					<span class="grade gr_15">15</span>
		    					<img src="img/main/main_poster6.jpg" alt="">
		    				</div>
		    				<div class="rank_info">
		    					<h3 class="rank_subject">존윅3</h3>
		    					<p>
									<span class="rating">예매율 <b>66.2%</b></span>
									<span class="score"><b>7.6</b></span>
								</p>
		    				</div>
		    			</li>
		    			<li>
		    				<div class="rank_img">
		    					<div class="black_box">
									<a href="#">상세정보</a>
								</div><!-- .black_box -->
		    					<span class="grade gr_15">15</span>
		    					<img src="img/main/main_poster7.jpg" alt="">
		    				</div>
		    				<div class="rank_info">
		    					<h3 class="rank_subject">러브액츄얼리</h3>
		    					<p>
									<span class="rating">예매율 <b>66.2%</b></span>
									<span class="score"><b>7.6</b></span>
								</p>
		    				</div>
		    			</li>
		    		</ul>
	    		</div><!-- .rank_box -->
		    </section><!-- .reserve_ranking -->
		
		    <!-- 이벤트 시작-->
		    <section class="event_cont">
	        	<h2>이벤트
	        		<a href="#" class="more_btn">더보기 &#62;</a>
	        	</h2>
	        	<ul>
	        		<li class="event_img1">
	        			<a href="#">
	        				<img src="img/main/event1.jpg">
	        			</a>
	        		</li>
	        		<li class="event_img1">
	        			<a href="#">
	        				<img src="img/main/event2.jpg">
	        			</a>
	        		</li>
	        		<li class="event_img2">
	        			<a href="#">
	        				<img src="img/main/event3.jpg">
	        			</a>
	        		</li>
	        		<li class="event_img2">
	        			<a href="#">
	        				<img src="img/main/event4.jpg">
	        			</a>
	        		</li>
	        		
	        		<li class="event_img3">
	        			<a href="#">
	        				<img src="img/main/event5.jpg">
	        			</a>
	        		</li>
	        		<li class="event_img1">
	        			<a href="#">
	        				<img src="img/main/event6.jpg">
	        			</a>
	        		</li>
	        	</ul>
		    </section><!-- .event_cont -->
		    <!-- 이벤트 끝-->
		    
		    <!-- 시사회/무대인사 시작 -->
			<section class="preview_cont">
				<h2>시사회/무대인사
					<a href="#" class="more_btn">더보기 &#62;</a>
				</h2> 
				<ul>
					<li>
						<a href="#">
							<strong>
								<span>시사회&#38;무대인사</span>
									&#60;썸머 85&#62;스페셜 굿즈 패키지
							</strong>
							<img src="img/main/preview_img1.jpg">
						</a>
					</li>
					<li>
						<a href="#">
							<strong>
								<span>시사회&#38;무대인사</span>
									&#60;화양연화 리마스터링&#62;2차 스페셜 굿즈 패키지
							</strong>
							<img src="img/main/preview_img2.jpg">
						</a>
					</li>
					<li>
						<a href="#">
							<strong>
								<span>시사회&#38;무대인사</span>
									&#60;아이 엠 우먼&#62;굿즈 패키지 상영회
							</strong>
							<img src="img/main/preview_img3.jpg">
						</a>
					</li>
				</ul>		
			</section><!-- .preview_cont -->
			<!-- 시사회/무대인사 끝 -->
			
			<section class="notice_cont">
				<span class="notice_tit">공지사항</span><!-- .notice_tit -->
				<div class="rolling_notice">
					<ul>
						<li>
							<a href="#">수도권 사회적 거리두기 2.5단계으로 인한 영화관 21시 이후 운영안내</a>
						</li>
						<li>
							<a href="#">	&#60;마스크 착용 의무화 행정명령 시행 안내&#62;</a>
						</li>
						<li>
							<a href="#">	"5인 이상 모임 금지" 수도권 행정명령에 따른 고객 안내</a>
						</li>
						<li>
							<a href="#">&#60;워 위드 그랜파&#62; 회원시사회 일정취소 안내</a>
						</li>
					</ul>
				</div><!-- .rolling_notice -->
				<a href="#" class="more_btn">더보기 &#62;</a>
			</section><!-- .notice_cont -->
	
			<section class="banner_cont">
				<a href="MovDetail.mo?movieCd=20201002"><img src="img/main/banner_img1.jpg"></a>			
			</section><!-- .banner_cont -->
		
	    </div><!-- .container -->
    </div><!-- #main_container -->
    

    <!--::footer_part start::-->
    <jsp:include page="inc/bottom.jsp"/>
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
    <script src="js/slick.js"></script>
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