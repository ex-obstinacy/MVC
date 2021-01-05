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
    <jsp:include page="/inc/top.jsp"/>
    <!-- Header part end-->


    <!-- breadcrumb start-->
<!--     <section class="breadcrumb breadcrumb_bg"> -->
<!--     	<div class="container"> -->
<!--             <div class="row justify-content-center"> -->
<!--                 <div class="col-lg-8"> -->
<!--                     <div class="breadcrumb_iner"> -->
<!--                         <div class="breadcrumb_iner_item"> -->
<!--                             <h2>Tracking Order</h2> -->
<!--                             <p>Home <span>-</span> Tracking Order</p> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </section> -->
    <!-- breadcrumb start-->

    <!--================login_part Area =================-->
    <div id="sub_content">
    	<div class="container">
    		<section class="login_part">
	    		<div class="login_box">
	    			<h2>로그인</h2>
	    			<form class="contact_form" action="MemberLoginPro.me" method="post" novalidate="novalidate">
	    				<div class="input_box">
	    					<input type="text" id="name" name="name" value="" placeholder="아이디를 입력해주세요">
		                	<input type="password" id="password" name="password" value="" placeholder="비밀번호를 입력해주세요">
	    				</div><!-- .input_box -->	                
		                <button type="submit" value="submit" class="btn_login">로그인</button>
		            </form>
		            <a href="MemberAgreeForm.me" class="btn_join">회원가입</a>
	    		</div><!-- .login_box -->
	    		
	    		<a href="http://localhost:8080/MVC/MovDetail.mo?movieCd=20192567" class="right_banner">
	    			<img src="img/sub/member/login_banner1.jpg">
	    		</a><!-- .right_banner -->
    		</section><!-- .login_part -->
    	</div><!-- .container -->
    </div><!-- #sub_content -->
<!--     <section class="login_part padding_top"> -->
<!--         <div class="container"> -->
<!--             <div class="row align-items-center"> -->
<!--                 <div class="col-lg-6 col-md-6"> -->
<!--                     <div class="login_part_text text-center"> -->
<!--                         <div class="login_part_text_iner"> -->
<!--                             <h2>New to our Shop?</h2> -->
<!--                             <p>There are advances being made in science and technology -->
<!--                                 everyday, and a good example of this is the</p> -->
<!--                             <a href="MemberAgreeForm.me" class="btn_3">Create an Account</a> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 <div class="col-lg-6 col-md-6"> -->
<!--                     <div class="login_part_form"> -->
<!--                         <div class="login_part_form_iner"> -->
<!--                             <h3>Welcome Back ! <br> -->
<!--                                 Please Sign in now</h3> -->
<!--                             <form class="row contact_form" action="MemberLoginPro.me" method="post" novalidate="novalidate"> -->
<!--                                 <div class="col-md-12 form-group p_star"> -->
<!--                                     <input type="text" class="form-control" id="name" name="name" value="" -->
<!--                                         placeholder="Username"> -->
<!--                                 </div> -->
<!--                                 <div class="col-md-12 form-group p_star"> -->
<!--                                     <input type="password" class="form-control" id="password" name="password" value="" -->
<!--                                         placeholder="Password"> -->
<!--                                 </div> -->
<!--                                 <div class="col-md-12 form-group"> -->
<!--                                     <button type="submit" value="submit" class="btn_3"> -->
<!--                                         log in -->
<!--                                     </button> -->
<!--                                 </div> -->
<!--                             </form> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </section> -->
    <!--================login_part end =================-->

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