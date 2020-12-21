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
                             <img src="img/main/main_slide1.jpg" alt=""><!-- 메인슬라이더 1 이미지 -->
                        </div>
                        <div class="single_banner_slider">
                                <img src="img/main/main_slide2.jpg" alt=""><!-- 메인슬라이더 2 이미지 -->
                        </div>
                    </div><!-- .banner_slider -->
                </div><!-- .col-lg-12 -->
            </div><!-- .<div class="row align-items-center"> -->
    </section><!-- .banner_part -->
    <!-- 메인슬라이더 끝-->
    
    <!-- #main_container -->
    <div id="main_container">
    	<!-- 예매순위 -->
	    <section class="reserve_ranking">
	    	<div class="container">
	    		<h2>예매순위</h2>
	    		<div class="rank_box">
		    		<i class="fas fa-chevron-left prev"></i> 
		        	<i class="fas fa-chevron-right next"></i>
		    		<ul class="rank_slider">
		    			<li>
		    				<img src="img/main/main_poster1.jpg" alt="">
		    				<div>
		    					<span class="rank_subject">조제</span>
		    					<p>예매율 : </p>
		    				</div>
		    			</li>
		    			<li>
		    				<img src="img/main/main_poster2.jpg" alt="">
		    				<div>
		    					<span class="rank_subject">도굴</span>
		    					<p>예매율 : </p>
		    				</div>
		    			</li>
		    			<li>
		    				<img src="img/main/main_poster3.jpg" alt="">
		    				<div>
		    					<span class="rank_subject">런</span>
		    					<p>예매율 : </p>
		    				</div>
		    			</li>
		    			<li>
		    				<img src="img/main/main_poster4.jpg" alt="">
		    				<div>
		    					<span class="rank_subject">이웃사촌</span>
		    					<p>예매율 : </p>
		    				</div>
		    			</li>
		    			<li>
		    				<img src="img/main/main_poster5.jpg" alt="">
		    				<div>
		    					<span class="rank_subject">리플레이</span>
		    					<p>예매율 : </p>
		    				</div>
		    			</li>
		    			<li>
		    				<img src="img/main/main_poster6.jpg" alt="">
		    				<div>
		    					<span class="rank_subject">존윅3</span>
		    					<p>예매율 : </p>
		    				</div>
		    			</li>
		    			<li>
		    				<img src="img/main/main_poster7.jpg" alt="">
		    				<div>
		    					<span class="rank_subject">러브액츄얼리</span>
		    					<p>예매율 : </p>
		    				</div>
		    			</li>
		    		</ul>
	    		</div><!-- .rank_box -->
	    	</div><!-- .container -->
	    </section><!-- .reserve_ranking -->
	    
	<!--     product_list part start -->
	<!--     <section class="product_list best_seller section_padding"> -->
	<!--         <div class="container"> -->
	<!--             <div class="row justify-content-center"> -->
	<!--                 <div class="col-lg-12"> -->
	<!--                     <div class="section_tittle text-center"> -->
	<!--                         <h2>예매 순위</h2> -->
	<!--                     </div> -->
	<!--                 </div> -->
	<!--             </div> -->
	<!--             <div class="row align-items-center justify-content-between"> -->
	<!--                 <div class="col-lg-12"> -->
	<!--                     <div class="best_product_slider owl-carousel"> -->
	                    
	<!--                         <div class="single_product_item"> -->
	<!--                             <img src="img/main/main_poster1.jpg" alt=""> -->
	<!--                             <div class="single_product_text"> -->
	<!--                                 <h4>조제</h4> -->
	<!--                                 <h3>예매율</h3> -->
	<!--                             </div> -->
	<!--                         </div> -->
	                        
	<!--                         <div class="single_product_item"> -->
	<!--                             <img src="img/main/main_poster2.jpg" alt=""> -->
	<!--                             <div class="single_product_text"> -->
	<!--                                 <h4>도굴</h4> -->
	<!--                                 <h3>예매율</h3> -->
	<!--                             </div> -->
	<!--                         </div> -->
	                        
	<!--                         <div class="single_product_item"> -->
	<!--                             <img src="img/main/main_poster3.jpg" alt=""> -->
	<!--                             <div class="single_product_text"> -->
	<!--                                 <h4>Quartz Belt Watch</h4> -->
	<!--                                 <h3>예매율</h3> -->
	<!--                             </div> -->
	<!--                         </div> -->
	                        
	<!--                         <div class="single_product_item"> -->
	<!--                             <img src="img/main/main_poster4.jpg" alt=""> -->
	<!--                             <div class="single_product_text"> -->
	<!--                                 <h4>Quartz Belt Watch</h4> -->
	<!--                                 <h3>예매율</h3> -->
	<!--                             </div> -->
	<!--                         </div> -->
	                        
	<!--                         <div class="single_product_item"> -->
	<!--                             <img src="img/main/main_poster5.jpg" alt=""> -->
	<!--                             <div class="single_product_text"> -->
	<!--                                 <h4>Quartz Belt Watch</h4> -->
	<!--                                 <h3>예매율</h3> -->
	<!--                             </div> -->
	<!--                         </div> -->
	                        
	<!--                     </div> -->
	<!--                 </div> -->
	<!--             </div>.container -->
	<!--         </div> -->
	<!--     </section> -->
	<!--     product_list part end -->
	
	    <!-- feature_part start-->
	    <section class="feature_part padding_top">
	        <div class="container">
	        	<h2>이벤트</h2>
	            <div class="row align-items-center justify-content-between">
	                <div class="col-lg-7 col-sm-6">
	                    <div class="single_feature_post_text">
	                        <p>Premium Quality</p>
	                        <h3>Latest foam Sofa</h3>
	                        <a href="#" class="feature_btn">EXPLORE NOW <i class="fas fa-play"></i></a>
	                        <img src="img/feature/feature_1.png" alt="">
	                    </div>
	                </div>
	                <div class="col-lg-5 col-sm-6">
	                    <div class="single_feature_post_text">
	                        <p>Premium Quality</p>
	                        <h3>Latest foam Sofa</h3>
	                        <a href="#" class="feature_btn">EXPLORE NOW <i class="fas fa-play"></i></a>
	                        <img src="img/feature/feature_2.png" alt="">
	                    </div>
	                </div>
	                <div class="col-lg-5 col-sm-6">
	                    <div class="single_feature_post_text">
	                        <p>Premium Quality</p>
	                        <h3>Latest foam Sofa</h3>
	                        <a href="#" class="feature_btn">EXPLORE NOW <i class="fas fa-play"></i></a>
	                        <img src="img/feature/feature_3.png" alt="">
	                    </div>
	                </div>
	                <div class="col-lg-7 col-sm-6">
	                    <div class="single_feature_post_text">
	                        <p>Premium Quality</p>
	                        <h3>Latest foam Sofa</h3>
	                        <a href="#" class="feature_btn">EXPLORE NOW <i class="fas fa-play"></i></a>
	                        <img src="img/feature/feature_4.png" alt="">
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	    <!-- upcoming_event part start-->
	
	    <!-- product_list start-->
	    <section class="product_list section_padding">
	        <div class="container">
	            <div class="row justify-content-center">
	                <div class="col-lg-12">
	                    <div class="section_tittle text-center">
	                        <h2>awesome <span>shop</span></h2>
	                    </div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="col-lg-12">
	                    <div class="product_list_slider owl-carousel">
	                        <div class="single_product_list_slider">
	                            <div class="row align-items-center justify-content-between">
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_1.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_2.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_3.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_4.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_5.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_6.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_7.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_8.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="single_product_list_slider">
	                            <div class="row align-items-center justify-content-between">
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_1.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_2.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_3.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_4.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_5.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_6.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_7.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-lg-3 col-sm-6">
	                                    <div class="single_product_item">
	                                        <img src="img/product/product_8.png" alt="">
	                                        <div class="single_product_text">
	                                            <h4>Quartz Belt Watch</h4>
	                                            <h3>$150.00</h3>
	                                            <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	    <!-- product_list part start-->
	
	    <!-- awesome_shop start-->
	    <section class="our_offer section_padding">
	        <div class="container">
	            <div class="row align-items-center justify-content-between">
	                <div class="col-lg-6 col-md-6">
	                    <div class="offer_img">
	                        <img src="img/offer_img.png" alt="">
	                    </div>
	                </div>
	                <div class="col-lg-6 col-md-6">
	                    <div class="offer_text">
	                        <h2>Weekly Sale on
	                            60% Off All Products</h2>
	                        <div class="date_countdown">
	                            <div id="timer">
	                                <div id="days" class="date"></div>
	                                <div id="hours" class="date"></div>
	                                <div id="minutes" class="date"></div>
	                                <div id="seconds" class="date"></div>
	                            </div>
	                        </div>
	                        <div class="input-group">
	                            <input type="text" class="form-control" placeholder="enter email address"
	                                aria-label="Recipient's username" aria-describedby="basic-addon2">
	                            <div class="input-group-append">
	                                <a href="#" class="input-group-text btn_2" id="basic-addon2">book now</a>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	    <!-- awesome_shop part start-->
	
	    
	
	    <!-- subscribe_area part start-->
	    <section class="subscribe_area section_padding">
	        <div class="container">
	            <div class="row justify-content-center">
	                <div class="col-lg-7">
	                    <div class="subscribe_area_text text-center">
	                        <h5>Join Our Newsletter</h5>
	                        <h2>Subscribe to get Updated
	                            with new offers</h2>
	                        <div class="input-group">
	                            <input type="text" class="form-control" placeholder="enter email address"
	                                aria-label="Recipient's username" aria-describedby="basic-addon2">
	                            <div class="input-group-append">
	                                <a href="#" class="input-group-text btn_2" id="basic-addon2">subscribe now</a>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	    <!--::subscribe_area part end::-->
	
	    <!-- subscribe_area part start-->
	    <section class="client_logo padding_top">
	        <div class="container">
	            <div class="row align-items-center">
	                <div class="col-lg-12">
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_1.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_2.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_3.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_4.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_5.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_3.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_1.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_2.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_3.png" alt="">
	                    </div>
	                    <div class="single_client_logo">
	                        <img src="img/client_logo/client_logo_4.png" alt="">
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	    <!--::subscribe_area part end::-->
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