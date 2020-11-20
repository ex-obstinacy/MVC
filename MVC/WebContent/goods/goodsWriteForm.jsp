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
              <h2>상품 등록</h2>
              <p>란희 <span>-</span> GoodsWriteForm</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- breadcrumb start-->

<script src="../js/jquery-3.5.1.js"></script>
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

<!-- 상품 등록 -->
<section id="gdsWriteForm" class="checkout_area padding_top">
	<div class="container">
      <div class="cart_inner">
        <div class="table-responsive">
	<h2>상품정보 등록하기</h2>
	<p>*표시는 반드시 입력바랍니다.</p>
	<form action="GoodsWritePro.go" method="post" name="goodsWriteForm" id="goodsWriteForm" onsubmit="return ck()" enctype="multipart/form-data">
		<table class="table">
			<tr>
			 <td>*카테고리</td>
			 <td><select name="goods_ctg" id="goods_ctg">
			 		<option value="" id="gds_ctg00">카테고리선택</option>
 					<option value="pack">package</option>
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
		
</body>
</html>