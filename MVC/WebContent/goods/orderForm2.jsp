<%@page import="java.util.ArrayList"%>
<%@page import="vo.StoreBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
////// 장바구니에서 넘어옴 //////
ArrayList<StoreBean> basketList = (ArrayList<StoreBean>)request.getAttribute("basketList");

String member_id = (String)session.getAttribute("id");

int totalPrice = 0; //할인 전 총 상품금액
int sale2 = 0; // 총 할인가격
int sumPrice = 0; // 할인 후 상품금액

String orderNum = (String)request.getAttribute("orderNum");
String[] reserveNum = (String [])request.getAttribute("reserveNum");

%>
<!DOCTYPE html>
<html lang="zxx">

<head>
	<style type="text/css">
	.oldprice {text-decoration : line-through;
			   color: #BDBDBD;}

	</style>
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

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script><!-- 아임포트 결제 js -->

<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">

function NoMultiChk(chk){ // 결제수단 중복체크 불가
    var obj = document.getElementsByName("payMethod");
    for(var i=0; i < obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

//결제 API (아임포트) 구현
IMP.init("imp14042333"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.   
function requestPay() {
         var payMethod=$("input:checkbox[name='payMethod']:checked").val();
         var selector=$("input:checkbox[name='selector']:checked").val();
         var orderNum = $("input:hidden[name='orderNum']").val();
         var name=$('.name').text();
		 var sumPrice = document.getElementById("sumPrice");
		 sumPrice.value = Number(sumPrice.value);
		 var queryString = $('#orderForm').serialize();
         
         if(payMethod == null){
            alert("결제수단을 선택해주세요.");
            return false;
         }
         
         if(selector == null){
        	 alert("약관에 동의해주십시요.");
        	 return false;
         }
         
         // IMP.request_pay(param, callback) 호출
         IMP.request_pay({ // param
             pg: "html5_inicis",
             pay_method:payMethod,
             merchant_uid: orderNum, // 상품 번호
             name: name, // 상품명
             amount: 100, // 상품가격
//              amount: sumPrice.value, // 상품가격
             buyer_email: "gildong@gmail.com",
         }, function (rsp) { // callback
            if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                // jQuery로 HTTP 요청
                jQuery.ajax({
                    url: "http://localhost:8080/MVC/OrderPro2.go", // 가맹점 서버
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    data: queryString
                }).done(function (data) {
                  // 가맹점 서버 결제 API 성공시 로직

         		   //ㅇㅕ기 넣으면 왜 안넘어가지 !!!!?!?????
         				   
                })
                
                ///추가////  
//                    var check_count = document.getElementsByName("goodsRow").length;
         		   var goodsRow = document.getElementsByName("goodsRow");
//          		   var checked =0 ; //체크된 갯수 파악 위한 초기 변수
         		   
         		   // 체크박스 값 확인
//          			for(var i=0; i<check_count; i++){
//          				   alert(goodsRow[i].value);
//          			}
//                   alert("결제성공");
                	document.orderResult.submit();
               	///추가////
               	
               	
              } else {
                alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
              }
//          location.href = "OrderPro2.go";
         });
         
}

</script>

  <!--::header part start::-->
   <jsp:include page="../inc/top.jsp"/>
<!-- 서브비주얼 -->
<jsp:include page="/inc/sub_store1.jsp"/>

  <!--================Cart Area =================-->
  <section class="cart_area">
    <div class="container">
      <div class="cart_inner">
        <h3>구매상품 정보</h3>
         <hr>
        <form action="OrderPro2.go" name="orderResult" method="post" id="orderForm">
          <table class="table">
          <%
          if(basketList != null){
           %>
            <thead>
              <tr>
                <th scope="col"></th>
                <th scope="col">상품</th>
                <th scope="col">수량</th>
                <th scope="col">합계</th>
              </tr>
            </thead>
            <%
         for(int i= 0; i < basketList.size(); i++){
            int goodsPrice = basketList.get(i).getPrice() * basketList.get(i).getBasketCount(); // 상품 개 당 가격
            totalPrice += goodsPrice; // 할인 전 상품금액 += 상품 개 당 가격
            int sale = (int)(basketList.get(i).getPrice() * basketList.get(i).getSale() * basketList.get(i).getBasketCount() * 0.01); // 할인가격
            sale2 += sale; // 총 할인가격 += 할인가격
            int nowPrice = goodsPrice - sale; // 할인 후 상품금액 = 할인 전 상품금액 - 할인금액
            sumPrice = totalPrice - sale2; // 할인 후 총 상품금액 = 할인 전 총 상품금액 - 총 할인가격
            int goods_goodsId = basketList.get(i).getGoods_goodsId();
         %>
            <tbody>
              <tr>
                <td></td>
                <td>
                  <div class="media">
                    <div class="d-flex">
					<!-- Pro로 넘길 값 -->
                    <input type="hidden" value=<%=goods_goodsId %> name="goodsRow" class="goodsSelect">
                    <input type="hidden" value=<%=reserveNum[i] %> name="reserveNum">
                    <input type="hidden" value="<%=orderNum %>" name="orderNum">
                    <!-- Pro로 넘길 값 -->
                      <img src="goodsUpload/<%=basketList.get(i).getFile() %>" alt="상품이미지" width="250" />
                    </div>
                    <div class="media-body">
                      <p class="name"><%=basketList.get(i).getName() %></p>
                      <p><%=basketList.get(i).getComponent() %></p>
                    </div>
                  </div>
                </td>
                <td>
                  <div class="product_count">
                    <p><%=basketList.get(i).getBasketCount() %>개</p>
                  </div>
                </td>
                <td>
                  <%if(sale == 0){ %>
                  <h5><%=goodsPrice %>원</h5> <%} else { %>
                  <h5 class=oldprice><%=goodsPrice %>원</h5>
                  <h5><%=nowPrice %>원</h5> <%} %>
                </td>
              </tr>
            <%   
         }
         %>
           
           <%  
          }
          %>  
              
              
              <tr>
                <td></td>
                <td></td>
                <td>
                  <h5>총 상품금액</h5>
                  <h5>할인금액</h5>
                  <h3>총 결제예정금액</h3>
                </td>
                <td>
                  <h5><%=totalPrice %>원</h5>
                  <h5><%=sale2%>원</h5>
                  <h3><%=sumPrice %>원</h3>
                  <!-- Pro로 넘길 값 -->
                  <input type="hidden" value="<%=sumPrice %>" name="sumPrice" id="sumPrice">
                  <input type="hidden" value="<%=totalPrice %>" name="totalPrice" id="totalPrice">
                  <!-- Pro로 넘길 값 -->
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
               <input type="checkbox" name="payMethod" value="card" id="card" onclick="NoMultiChk(this)">
               <label for="card"><span>신용카드</span></label>
            </li>
            <li>
               <input type="checkbox" name="payMethod" value="trans" id="trans" onclick="NoMultiChk(this)">
               <label for="trans"><span>계좌이체</span></label>
            </li>
            <li>
               <input type="checkbox" name="payMethod" value="phone" id="phone" onclick="NoMultiChk(this)">
               <label for="phone"><span>휴대폰</span></label>
            </li>
         </ul>
   </div>
  <!--::결제수단 선택 폼 끝::-->
  <br><br>
  <!--::약관동의 시작::-->
   <h3 class="pd_top">주문정보 / 결제 대행 서비스    약관 동의</h3>
     <hr>
   <div class="creat_account">
      <input type="checkbox" id="f-option4" name="selector" />
      <label for="f-option4">약관에 동의합니다.</label>
<!--       <a href="#">동의동의*</a> -->
        <pre>
        
[전자금융거래 기본약관]


제1조 (목적)

이 약관은 MVC(주)(이하 '회사'라 합니다)가 제공하는 전자지급결제대행서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다.


제2조 (용어의 정의)

이 약관에서 정하는 용어의 정의는 다음과 같습니다.

1.'전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스(이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.

2.'전자지급결제대행서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.

3.'이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.

4.'접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, 회사에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.

5.'거래지시'라 함은 이용자가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 회사에 대하여 전자금융거래의 처리를 지시하는 것을 말합니다.

6.'오류'라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다.


제3조 (약관의 명시 및 변경)

1. 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.

2. 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.

3. 회사가 약관을 변경하는 때에는 그 시행일 1개월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.


제4조 (전자지급결제대행서비스의 종류)

회사가 제공하는 전자지급결제대행서비스는 지급결제수단에 따라 다음과 같이 구별됩니다.

1. 신용카드결제대행서비스: 이용자가 결제대금의 지급을 위하여 제공한 지급결제수단이 신용카드인 경우로, 회사가 전자결제시스템을 통하여 신용카드 지불정보를 송,수신하고 결제대금의 정산을 대행하거나 매개하는 서비스를 말합니다.

2. 계좌이체대행서비스: 이용자가 결제대금을 회사의 전자결제시스템을 통하여 금융기관에 등록한 자신의 계좌에서 출금하여 원하는 계좌로 이체할 수 있는 실시간 송금 서비스를 말합니다.

3. 가상계좌서비스: 이용자가 결제대금을 현금으로 결제하고자 하는 경우 회사의 전자결제시스템을 통하여 자동으로 이용자만의 고유한 일회용 계좌의 발급을 통하여 결제대금의 지급이 이루어지는 서비스를 말합니다.

4. 기타: 회사가 제공하는 서비스로서 지급결제수단의 종류에 따라 '휴대폰 결제대행서비스', 'ARS결제대행서비스', '상품권결제대행서비스'등이 있습니다.


제5조 (이용시간)

1. 회사는 이용자에게 연중무휴 1일 24시간 전자금융거래 서비스를 제공함을 원칙으로 합니다. 단, 금융기관 및 기타 결제수단 발행업자의 사정에 따라 달리 정할 수 있습니다.

2. 회사는 정보통신설비의 보수, 점검 기타 기술상의 필요나 금융기관 기타 결제수단 발행업자의 사정에 의하여 서비스 중단이 불가피한 경우, 서비스 중단 3일 전까지 게시가능한 전자적 수단을 통하여 서비스 중단 사실을 게시한 후 서비스를 일시 중단할 수 있습니다. 다만, 시스템 장애복구, 긴급한 프로그램 보수, 외부요인 등 불가피한 경우에는 사전 게시 없이 서비스를 중단할 수 있습니다.


제 16조 (약관 외 준칙 및 관할)


1. 이 약관에서 정하지 아니한 사항에 대하여는 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다.

2. 회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.</pre>
   </div>
  <!--::약관동의 끝::-->
     <!--::버튼 시작::-->
          <div class="pd_top">
            <input type="button" class="btn_3" value="이전화면" onclick="history.back()">
          </div>
          <div class="checkout_btn_inner float-right">
            <input type="button" class="btn_3" value="결제하기" onclick="requestPay()">
          </div>
          <!-- 가상 결제 완료 버튼 -->
<!--         <input type="submit" value="결제 완료"> -->
     <!--::버튼 끝::-->
         </form>
      </div>
     </div>
  </section>
  
  <!--================End Cart Area =================-->

  <!--::footer_part start::-->
  <jsp:include page="../inc/bottom.jsp"/>
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