<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>goodsWriteForm</title>
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
        <link rel="stylesheet" href="css/sub.css">
</head>
<body>
  <!--::header part start::-->
  <jsp:include page="/inc/top.jsp"/>
  <!-- Header part end-->
  <jsp:include page="/inc/sub_main1.jsp"/>
   

<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#goodsWriteForm').submit(function(){
		if ($('#gds_ctg00').is(":selected") == true) {
			alert("상품 카테고리를 선택 하세요");
			$('#goods_ctg').focus();
			return false;
		}
	});
});
</script>
<%
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

<section class="cat_product_area section_padding">
	 <div class="container">
	     <div class="row">
	         <div class="col-lg-3">
	             <div class="left_sidebar_area">
	                 <aside class="left_widgets p_filter_widgets">
	                     <div class="side_menu">
							<h3>관리자메뉴</h3>
							<ul class="list side_list">
								<li><a href="AdminMovList.mo">영화목록</a></li>
								<li><a href="CinemaAddForm.re">영화관</a></li>
								<li><a href="MovieAddForm.re">상영중인 영화</a></li>
								<li class="active"><a href="GoodsList.go">스토어</a></li>
								<li><a href="AdminNoticeList.ad">공지사항</a></li>
								<li><a href="AdminQnAList.ad">1대1 문의</a></li>
								<li><a href="AdminMemberList.ad">회원 목록</a></li>
							</ul>
						</div><!-- .side_menu -->
			        </aside>
	    		</div>
			</div>
	<!--================ 메뉴 영역 =================-->    


			<!-- 상품 등록 -->
			<div class="col-lg-9">
				<section id="gdsWriteForm" class="checkout_area padding_top">
					<div class="container">
				      <div class="cart_inner">
				      	<h2 class="member_title">스토어</h2><!-- .member_title -->
				        <div class="table-responsive">
					<h2>상품정보 등록하기</h2>
					<p>*표시는 반드시 입력바랍니다.</p>
					<form action="GoodsWritePro.go" method="post" name="goodsWriteForm" id="goodsWriteForm" onsubmit="return ck()" enctype="multipart/form-data">
						<table class="table">
							<tr>
							 <td>*카테고리</td>
							 <td><select name="goods_ctg" id="goods_ctg">
							 		<option value="" id="gds_ctg00">카테고리선택</option>
				 					<option value="package">package</option>
				 					<option value="ticket">ticket</option>
				  					<option value="snack">snack</option>
				 				  </select></td>
							</tr>
							<tr>
							 <td><label for="goods_name" >*상품이름</label></td>
							 <td><input type="text" name="goods_name" id="goods_name" required="required"></td>
							</tr>
							<tr>
							 <td><label for="goods_price">*상품가격</label></td>
							 <td><input type="text" name="goods_price" id="goods_price" required="required"></td>
							</tr>
							<tr>
							 <td><label for="goods_sale">*할인율</label></td>
							 <td><input type="text" name="goods_sale" id="goods_sale" value="0" required="required"></td>
							</tr>
							<tr>
							 <td><label for="goods_sellCount">*판매수량</label></td>
							 <td><input type="text" name="goods_sellCount" id="goods_sellCount" value="0" required="required"></td>
							</tr>
							<tr>
							 <td><label for="goods_component">*상품구성</label></td>
							 <td><input type="text" name="goods_component" id="goods_component" required="required"></td>
							</tr>
							<tr>
							 <td><label for="goods_file">*이미지파일</label></td>
							 <td><input type="file" name="goods_file" id="goods_file" required="required"></td>
							</tr>
							<tr>
							 <td><label for="goods_content">상세내용</label></td>
							 <td><textarea name="goods_content" id="goods_content" rows="10" cols="20"></textarea></td>
							</tr>
						</table>
						<section id="commandCell">
							<input type="submit" value="상품등록" class="btn_3">  &nbsp;&nbsp;
							<input type="button" value="상품목록" class="btn_3" onclick="location.href='GoodsList.go'">
						</section>
					</form>
					 	  </div>
				        </div>
				      </div>
				</section>
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