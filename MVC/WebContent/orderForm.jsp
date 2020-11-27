<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>구매하기</title>
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
</head>

<body>

<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">

function NoMultiChk(chk){ // 결제수단 중복체크 불가
    var obj = document.getElementsByName("selectPay");
    for(var i=0; i < obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

</script>

  <!--::header part start::-->
	<jsp:include page="inc/top.jsp"/>
  <!-- Header part end-->


  <!--================Home Banner Area =================-->
  <!-- breadcrumb start-->
  <section class="breadcrumb breadcrumb_bg">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="breadcrumb_iner">
            <div class="breadcrumb_iner_item">
              <h2>구매하기</h2>
              <p>Home <span>-</span>구매하기</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- breadcrumb start-->

  <!--================Cart Area =================-->
  <section class="cart_area padding_top">
    <div class="container">
      <div class="cart_inner">
        <h3>구매상품 정보</h3>
         <hr>
        <form action="orderPro.go" name="basket" method="post" id="orderForm">
          <table class="table">
            <thead>
              <tr>
                <th scope="col"></th>
                <th scope="col">상품</th>
                <th scope="col">수량</th>
                <th scope="col">합계</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td></td>
                <td>
                  <div class="media">
                    <div class="d-flex">
                      <img src="img/product/single-product/cart-1.jpg" alt="" />
                    </div>
                    <div class="media-body">
                      <p>팝콘(M)</p>
                      <p>구성품:팝콘(M)</p>
                    </div>
                  </div>
                </td>
                <td>
                  <div class="product_count">
                    <p>n개</p>
                  </div>
                </td>
                <td>
                  <h5>2000원</h5>
                </td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td>
                  <h5>총 상품금액</h5>
                  <h5>할인금액</h5>
                  <h3>총 결제예정금액</h3>
                </td>
                <td>
                  <h5>2000원</h5>
                  <h5>0원</h5>
                  <h3>34000원</h3>
                </td>
              </tr>
            </tbody>
          </table>
  
  <!--::주문자 입력 정보 폼 시작::-->
<!--  <section class="checkout_area padding_top">
 <div class="order_box"> 
 <div class="container">
 <h3>주문자 정보 확인</h3>
  <div class="billing_details">
        <div class="row">
          <div class="col-lg-8">
            <form class="row contact_form" action="#" method="post" novalidate="novalidate">
              <div class="col-md-6 form-group p_star">
                <input type="text" class="form-control" id="first" name="name" />
                <span class="placeholder" data-placeholder="성함"></span> 이름 세션 정보가져오기
              </div>
              <div class="col-md-6 form-group p_star">
                <input type="text" class="form-control" id="last" name="name" />
                <span class="placeholder" data-placeholder="휴대전화번호"> 휴대전화번호 세션 정보가져오기</span>
              </div>
              <h8>구매하신 기프티콘은 주문자 정보에 입력된 휴대전호 번호로 MMS로 발송 됩니다.<br>
            입력된 휴대전화 번호가 맞는지 꼭 확인하세요.</h8>
            </form>
          </div>
         </div>
       </div>
       </div>
    </div>
   </section> -->
  <!--::주문자 입력 정보 폼 끝::-->
  
  <br>
  
  <!--::결제수단 선택 폼 시작::-->
   <div class="selectPayment">
		<h3 class="pd_top">결제수단 선택</h3>
			<hr>
			<ul>
				<li>
					<input type="checkbox" name="selectPay" value="creditCard" id="creditCard" onclick="NoMultiChk(this)">
					<label for="creditCard"><span>신용카드</span></label>
				</li>
				<li>
					<input type="checkbox" name="selectPay" value="simplePay" id="simplePay" onclick="NoMultiChk(this)">
					<label for="simplePay"><span>계좌이체</span></label>
				</li>
				<li>
					<input type="checkbox" name="selectPay" value="mobile" id="mobile" onclick="NoMultiChk(this)">
					<label for="mobile"><span>휴대폰</span></label>
				</li>
			</ul>
	</div>
  <!--::결제수단 선택 폼 끝::-->
  <br><br>
  <!--::약관동의 시작::-->
   <h3 class="pd_top">주문정보 / 결제 대행 서비스	 약관 동의</h3>
     <hr>
   <div class="creat_account">
      <input type="checkbox" id="f-option4" name="selector" />
      <label for="f-option4">약관에 동의합니다.</label>
      <a href="#">동의동의*</a>
        <p>역사를 피가 있는 품으며, 것이 보는 영원히 꽃이 그리하였는가?
	때에, 투명하되 생생하며, 인간의 가치를 천자만홍이 불어 피다.
 	힘차게 인간이 오아이스도 천지는 작고 끝까지 같이, 아니더면, 있다.
  	광야에서 어디 가치를 가장 간에 싹이 보이는 갑 이상의 황금시대다.
   	얼음에 이상 미묘한 우리의 실로 없는 얼마나 봄바람이다.
    풀이 간에 그러므로 이상, 피어나는 찾아다녀도, 약동하다.
    없으면 것은 부패를 목숨을 있는 하였으며, 열락의 일월과 그림자는 사막이다. 
    있음으로써 같은 맺어, 있는 보배를 사는가 되려니와, 사막이다.
    바로 위하여 튼튼하며, 그들의 뛰노는 없으면 때에, 두기 별과 것이다.
    시들어 희망의 군영과 있는 있을 크고 불어 꽃이 황금시대다.</p>
   </div>
  <!--::약관동의 끝::-->
  	<!--::버튼 시작::-->
          <div class="pd_top">
            <input type="button" class="btn_3" value="이전화면" onclick="history.back">
          </div>
          <div class="checkout_btn_inner float-right">
            <input type="submit" class="btn_3" value="결제하기">
          </div>
     <!--::버튼 끝::-->
   		</form>
      </div>
     </div>
  </section>
  
  <!--================End Cart Area =================-->

  <!--::footer_part start::-->
  <jsp:include page="inc/bottom.jsp"/>
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