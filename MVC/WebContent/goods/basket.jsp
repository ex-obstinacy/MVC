<%@page import="vo.StoreBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
ArrayList<StoreBean> basketList = (ArrayList<StoreBean>)request.getAttribute("basketList");

// int goodsId = Integer.parseInt(request.getParameter("goodsId"));
String member_id = (String)session.getAttribute("id");

int totalPrice = 0; //할인 전 총 상품금액
int sale2 = 0; // 총 할인가격
int sumPrice = 0; // 할인 후 상품금액
%>
<!DOCTYPE html>
<html lang="zxx">
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>장바구니</title>
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
  
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
   $(document).ready(function(){
      
      //체크박스 전체 선택 및 해제
      $('#ch_all').click(function(){
         if($("#ch_all").prop("checked")){
            $("input[type=checkbox]").prop("checked",true);
         } else {
            $("input[type=checkbox]").prop("checked",false); 
         }
      });
   })   ;
   

</script> 
  
</head>

<body>
  <!--::header part start::-->
   <jsp:include page="../inc/top.jsp"/>
  <!-- Header part end-->


  <!--================Home Banner Area =================-->
  <!-- breadcrumb start-->
  <section class="breadcrumb breadcrumb_bg">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="breadcrumb_iner">
            <div class="breadcrumb_iner_item">
              <h2>장바구니</h2>
              <p>Home <span>-</span>장바구니</p>
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
        <h3>장바구니상품 정보</h3>
         <hr>
         <!-- 장바구니 -> 구매하기로 갈 때 멤버아이디는 ..?  -->
<%--         <form action="OrderForm.go?goodsId=<%=goodsId %>" name="basket" method="post" id="basketForm"> --%>
		<form action="OrderForm.go" name="basket" method="post" id="basketForm">
          <table class="table">
         <%
          if(basketList != null){
           %>
            <thead>
              <tr>
                <th scope="col" class="checkbox"><input type="checkbox" id="ch_all"></th> <!-- 체크박스 전체 선택 및 해제 -->
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
            sumPrice = totalPrice - sale2; // 할인 후 상품금액 = 할인 전 상품금액 - 총 할인가격
            
         %>
            <tbody>
              <tr>
                 <td><input type="checkbox" name="checkRow"></td> <!-- 체크박스 개별 선택 및 해제 -->
                <td>
                  <div class="media"> <!-- 상품 박스 -->
                    <div class="d-flex"> <!-- 상품 이미지 테두리 -->
                      <img src="goodsUpload/<%=basketList.get(i).getFile() %>" alt=""  width="250" />
                    </div>
                    <div class="media-body"> <!-- 상품 설명 바디 -->
                      <p><%=basketList.get(i).getName() %> </p>
                      <p><%=basketList.get(i).getComponent() %></p>
                      <p><%=basketList.get(i).getPrice() %>원</p>
                    </div>
                  </div>
                </td>
                <td>
                  <div class="product_count"> <!-- 수량변경 버튼 모양 -->
                    <input type="number" value="<%=basketList.get(i).getBasketCount() %>" min="0" max="10">
                  </div>
                  <div>
                  <input type="button" value="수량변경">
                  <input type="button" value="X" id="delete"> <!-- 휴지통모양 혹은 x -->
                  </div>
                </td>
                <td>
                  <h5><%=goodsPrice %>원</h5>
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
                  <h5><%=sale2 %>원</h5>
                  <h3><%=sumPrice %>원</h3>
                </td>
              </tr>
            </tbody>
          </table>
  <!--::버튼 시작::-->
      <div>        
      <input type="button" class="btn_3" value="이전화면" onclick="history.back">
    </div>
     <div class="checkout_btn_inner float-right">
       <input type="submit" class="btn_3" value="선택상품주문">
<%--        <a href="OrderForm.go?goodsId=<%=goodsId%>" class="btn_3">전체상품주문</a> --%>
       <input type="submit" class="btn_3" value="전체상품주문">
     </div>
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