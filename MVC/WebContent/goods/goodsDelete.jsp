<%@page import="vo.StoreBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>goodsModifyForm</title>
    <link rel="icon" href="img/favicon.png">
<!--     Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
<!--     animate CSS -->
    <link rel="stylesheet" href="css/animate.css">
<!--     owl carousel CSS -->
    <link rel="stylesheet" href="css/owl.carousel.min.css">
<!-- nice select CSS -->
    <link rel="stylesheet" href="css/nice-select.css">
<!--     font awesome CSS -->
    <link rel="stylesheet" href="css/all.css">
<!--     flaticon CSS -->
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/themify-icons.css">
<!--     font awesome CSS -->
    <link rel="stylesheet" href="css/magnific-popup.css">
<!--     swiper CSS -->
    <link rel="stylesheet" href="css/slick.css">
<!--     style CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/common.css"> 
</head>
<body>
  <!--::header part start::-->
  <jsp:include page="/inc/top.jsp"/>
  <!-- Header part end-->
  
    <!--================Home Banner Area =================-->
  <!-- breadcrumb start-->
  <section class="breadcrumb breadcrumb_bg">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="breadcrumb_iner">
            <div class="breadcrumb_iner_item">
              <h2>상품 수정</h2>
              <p>란희 <span>-</span> GoodsModifyForm</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- breadcrumb start-->

<script src="js/jquery-3.5.1.js"></script>
<%
    //request 객체에 저장된 BoardBean 객체(article) 가져오기
// 	StoreBean article = (StoreBean)request.getAttribute("article");
	int goodsId = Integer.parseInt(request.getParameter("goodsId"));
	// request 객체에 저장된 페이지번호(page) 파라미터 가져오기
	String nowPage = request.getParameter("page");

		//admin 세션값 가져오기
// 		String id = (String)session.getAttribute("id");
// 		if(id==null){
// 			id="";
// 			}
// 		MemberDAO mdao = new MemberDAO();
// 		MemberBean mb = mdao.getMember(id);
		
		//세션값이 admin 일때만 상품등록창 보이게하기
// 		if(id.equals("admin")){
			//상품등록창 주소
// 		}
%>
<% 
//한글 처리
request.setCharacterEncoding("utf-8"); %>

<!-- 상품 등록 -->
<section id="gdsWriteForm" class="checkout_area padding_top">
	<div class="container">
      <div class="cart_inner">
        <div class="table-responsive">
	<h2>상품정보 삭제</h2>
	
	<form action="GoodsDeletePro.go" method="post" name="goodsDeleteForm" id="goodsModifyForm">
		<input type="hidden" name="goodsId" value="<%=goodsId %>" >
		<input type="hidden" name="page" value="<%=nowPage %>" >
		<table class="table">
				<tr>
					<td><label>비밀번호 : </label></td>
					<td><input type="password" name="goods_pass" required="required"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="삭제">&nbsp;&nbsp;
						<input type="button" value="돌아가기" onclick="history.back()">
					</td>
				</tr>
			</table>
	</form>
	 	  </div>
        </div>
      </div>
</section>

  <!-- ================ goodsWriteForm section end ================= -->

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
  <!-- custom js -->
  <script src="js/custom.js"></script>	
</body>
</html>