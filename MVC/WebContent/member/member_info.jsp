<%@page import="vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");

	// MemberBean 객체 가져오기
	MemberBean article = (MemberBean)request.getAttribute("article");
	
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
    
    <!-- member CSS -->
    <link rel="stylesheet" href="css/member.css">
	
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

    <!--================main_part Area =================-->



	
	<section class="login_part padding_top">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6">
                    <div class="login_part_text text-center">
                        <div class="login_part_text_iner">
                        	<nav id="member_sub_menu">
								<ul>
									<li><a href="">결제내역</a></li>
									<li><a href="">장바구니</a></li>
									<li><a href="">리뷰내역</a></li>
									<li><a href="">1:1문의</a></li>
									<li><a href="">My정보</a></li>
								</ul>
							</nav>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="login_part_form">
                        <div class="login_part_form_iner">
						    <form action="MemberWritePro.me" id="join" method="post" name="fr" class="container" onsubmit="return check()">
								<table>
									<tr>
										<td class=td_size>아이디</td>
										<td><%=article.getId() %></td>
									</tr>
									<tr>
										<td>비밀번호</td>
										<td><input type="password" name="pass" id="pass" required="required" placeholder="8~12자 영문,숫자,특수문자" onkeyup="checkPasswd(this)"><span id="checkPasswdResult"></span></td>
									</tr>
									<tr>
										<td>비밀번호 재확인</td>
										<td><input type="password" name="rePass" id="rePass" required="required" onkeyup="retryPasswd(this)"><span id="retryPasswdResult"></span></td>
									</tr>
									<tr>
										<td>이름</td>
										<td><input type="text" name="name" id="name" required="required" value="<%=article.getName() %>"></td>
									</tr>
									<tr>
										<td>전화번호</td>
										<td><input type="text" name="phone" required="required"></td>
									</tr>
									<tr>
										<td>이메일</td>
										<td><input type="email" name="email" id="email" required="required"></td>
									</tr>
									<tr>
										<td>이메일 재확인</td>
										<td><input type="email" name="reEmail" id="reEmail" required="required" onkeyup="retryEmail(this)"><span id="retryEmailResult"></span></td>
									</tr>
									<tr>
										<td>성별</td>
										<td><input type="radio" name="gender" value="male" id="male" required="required">남 <input type="radio" name="gender" value="female" id="female">여</td>
									</tr>
									<tr>
										<td>생년월일</td>
										<td><input type="date" name="birthday" id="birthday" required="required" placeholder="2000-12-20"></td>
									</tr>
								</table>
								<table>
									<tr>
										<td rowspan="3" class=td_size>주소</td>
										<td><input type="text" name="postcode" id="postcode" class="id" placeholder="우편번호"> <input type="button" value="우편번호검색" class="genric-btn info circle" onclick="execPostCode()"></td>
									</tr>
									<tr>
										<td><input type="text" name="address" id="address" placeholder="주소" size="46"></td>
									</tr>
									<tr>
										<td><input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"> <input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목"></td>
									</tr>
								</table>
								<div class="clear"></div>
								<div id="buttons">
									<input type="submit" value="가입하기" class="genric-btn primary circle">
									<input type="reset" value="취소" class="genric-btn success circle">
								</div>
							</form>                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!--================main_part end =================-->

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