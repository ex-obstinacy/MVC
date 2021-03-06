<%@page import="vo.StoreBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

StoreBean article = (StoreBean)request.getAttribute("article");
String nowPage = request.getParameter("page");

int sale = (int)(article.getPrice() * article.getSale() * 0.01); //세일가 = 원가 * (세일 * 0.01) -> %로 나타낸거임
int sumPrice = article.getPrice() - sale; // 할인 후 적용가 = 원가 - 세일가

int goodsId = article.getGoodsId();

%>
<!DOCTYPE html>
<html lang="zxx">

<head>
<!-- 탭메뉴 -->
<style>
body{
	margin-top: 100px;
	line-height: 1.6
}
.container{
	width: 500px;
	margin: 0 auto;
}

ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
	
}
ul.tabs li{
	background: none;
	font-size: 17px;
	text-align: center;
	color: #7F7F7F;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
	border-bottom: 1px solid #ccc;
	width: 50%;
	float: left;
	
}

ul.tabs li.current{
	background: #ffffff;
	color: #000;
	border-bottom: 2px solid black;
	
}

.tab-content{
	display: none;
	background: #ffffff;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}

.tab-content p{
	padding: 30px 0;
	font-size:15px; 
/* 	font-weight:600;  */
 	margin-bottom:20px;
}

.tab-content h4{
font-size:18px; 
font-weight:500; 
position:relative; 
/* margin:0 0 20px 40px; */
}

.price{
	text-decoration : line-through;
}

</style>
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');
	
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
	
			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
		})
	
	})
	
	
	 //장바구니 button
   function basket(goodsId) {
	var basketCount = document.getElementById("basketCount");
      
         location.href = "BasketAdd.go?goodsId="+goodsId+"&basketCount="+basketCount.value;
         
   }
   
   //구매하기 button
   function order(goodsId) {
	   var basketCount = document.getElementById("basketCount");
      
         location.href = "OrderForm.go?goodsId="+goodsId+"&basketCount="+basketCount.value;
   }
   
// 수량이 변경될때마다 basketCount check / totalPrice 계산
	function countChk(count) {
// 		alert(count.value);
		basketCount = count.value;
// 		alert(basketCount);
		var element = document.getElementById('totalPrice');
		var totalPrice = <%=sumPrice%> * basketCount;
// 		alert(total);
		element.innerHTML = totalPrice;
	}
	

</script>
<!-- 탭메뉴 끝 -->

  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>store_detail</title>
  <link rel="icon" href="img/favicon.png">
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <!-- animate CSS -->
  <link rel="stylesheet" href="css/animate.css">
  <!-- owl carousel CSS -->
  <link rel="stylesheet" href="css/owl.carousel.min.css">
  <link rel="stylesheet" href="css/lightslider.min.css">
  <!-- font awesome CSS -->
  <link rel="stylesheet" href="css/all.css">
  <!-- flaticon CSS -->
  <link rel="stylesheet" href="css/flaticon.css">
  <link rel="stylesheet" href="css/themify-icons.css">
  <!-- font awesome CSS -->
  <link rel="stylesheet" href="css/magnific-popup.css">
  <!-- style CSS -->
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/common.css">  
	<link rel="stylesheet" href="css/sub.css">  
  <link rel="stylesheet" href="css/slick.css"/>
	<link rel="stylesheet" href="css/slick-theme.css"/>

</head>

<body>
   <!--::header part start::-->
  	<jsp:include page="/inc/top.jsp"/>
    <!-- Header part end-->
  
  <!--================Single Product Area =================-->
<!--   폼태그 추가 -->
<div id="content" class="contents_mall_detail" style="margin-top:120px;">
 <div class="container">
	<div class="pd_wrap">
		<div class="pd_img">
			<div class="main_img">
				<img class="" src="goodsUpload/<%=article.getFile()%>" />
			</div>
		</div>
		<div class="pd_detail">
			<table class="pd_table" summary="상품 상세설명에 대한 표입니다">
			<colgroup><col style="width: 30%;"><col style="width: auto;"></colgroup>
				<tbody>
					<tr>
						<th scope="row" class="tit" colspan="2"><%=article.getName() %></th>
					</tr>
					<tr>
						<th scope="row">가격</th>
						<td><%if(sale != 0){ %><span class="txt_price"><%=sumPrice %><em>원</em></span>
						<span class="txt_price_ins"><%=article.getPrice() %>원</span>
						<span class="txt_sale"><%=article.getSale() %>%</span><%} else {  %>
						<span class="txt_price"><%=sumPrice %><em>원</em></span><%} %></td>
					</tr>
					<tr>
						<th scope="row">구성품</th>
						<td><%=article.getComponent() %></td>
					</tr>
					<tr>
						<th scope="row">유효기간</th>
						<td>구매 후 1년 이내</td>
					</tr>
					<tr>
						<th scope="row">사용가능 영화관</th>
						<td>전 영화관</td>
					</tr>
				</tbody>
			</table>
			<div class="card_area d-flex justify-content-between align-items-center">
              <div class="product_count">
                <input type="number" value="1" id="basketCount" min="0" max="100" onchange="countChk(this)"> 
              </div>
            </div>
			<div class="txt_price_wrap">
				총 상품금액<strong class="txt_price_str"><span id="totalPrice"><%=sumPrice%></span><em>원</em></strong>
			</div>
			<div class="btn_wrap">
			<input type="button" class="btn_3" value = "장바구니" id="basket" onclick="basket(<%=goodsId%>)">
            <input type="button" class="btn_3" value = "구매하기" id="order" onclick="order(<%=goodsId%>)">
			</div>
		</div>
	</div>
	</div>
</div>

  <!--================End Single Product Area =================-->

  <!--================Product Description Area =================-->
  <div class="container">

	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1" >이용안내</li>
		<li class="tab-link" data-tab="tab-2" >유의사항</li>
	</ul>

	<div id="tab-1" class="tab-content current">
	 <p><h4>본 상품의 사용 기한은 구매 후 1년 입니다.</h4>
		- 영화관에서 스토어 예매번호 제시 후 상품으로 교환하실 수 있습니다. <br>
		- 본 상품은 온라인 전용 판매 상품으로 현장 구매는 불가합니다. <br>
		- 구매한 상품은 “마이페이지 > 구매내역”에서 확인할 수 있습니다. <br>
		- 팝콘 및 음료의 맛, 크기, 종류 변경이 불가합니다. <br>
		- 상기 이미지는 실제 제품과 다를 수 있습니다. <br>
     </p>
     </div>
	<div id="tab-2" class="tab-content">
	 <p>
            
       <h4> 취소/환불 </h4>
		- 스토어 상품의 취소기한은 구매일로부터 70일 입니다. <br>
		- 구매하신 상품은 부분환불 및 현금환불이 되지 않습니다. <br>
		- 패키지 상품 중 1장이라도 사용한 경우 환불이 불가합니다. <br>
		- 영화 상영 후 환불 및 반품은 불가합니다. <br>
		<br>
		<br>
		<h4>기타 </h4>
		- 상품 확인은 마이페이지 > 구매내역에서 가능합니다. <br>
		- 이벤트로 판매되는 상품의 구매/사용/취소 규정은 해당 이벤트 상세 페이지를 확인해주시기 바랍니다. <br>
		- 고객센터: 051-803-0909 <br>
		<br>
		<br>
		<h4> 미성년자 권리보호 안내 </h4>
		- 미성년자인 고객께서 계약을 체결하시는 경우 법정대리인이 그 계약에 동의하지 아니하면 미성년자 본인 또는 법정대리인이 그 계약을 취소할 수 있습니다. <br>
		<br>
		<br>
		<h4>분쟁 해결 </h4>
		- 회사는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해의 보상 등에 관한 처리를 위하여  고객센터(051-803-0909)를 설치 운영하고 있습니다. <br>
		- 회사는 고객센터를 통하여 이용자로부터 제출되는 불만사항 및 의견을 처리합니다. <br>
 		  　  다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보합니다. <br>
		- 전자상거래 분쟁(청약철회등)과 관련한 이용자의 피해구제는 이용약관 및 전자상거래법 등 관련 법령에 따릅니다. <br>
		<br>
            </p>
	
	</div>

	</div>
  <!--================End Product Description Area =================-->

  

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
  <script src="js/lightslider.min.js"></script>
  <!-- swiper js -->
  <script src="js/masonry.pkgd.js"></script>
  <!-- particles js -->
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.nice-select.min.js"></script>
  <!-- slick js -->
  <script src="js/slick.min.js"></script>
  <script src="js/swiper.jquery.js"></script>
  <script src="js/jquery.counterup.min.js"></script>
  <script src="js/waypoints.min.js"></script>
  <script src="js/contact.js"></script>
  <script src="js/jquery.ajaxchimp.min.js"></script>
  <script src="js/jquery.form.js"></script>
  <script src="js/jquery.validate.min.js"></script>
  <script src="js/mail-script.js"></script>
  <script src="js/stellar.js"></script>
  <!-- custom js -->
  <script src="js/theme.js"></script>
  <script src="js/custom.js"></script>
</body>

</html>