<%@page import="vo.StoreBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberShipBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	ArrayList<StoreBean> basketList = (ArrayList<StoreBean>)request.getAttribute("basketList");
	
	String member_id = (String)session.getAttribute("id");
	
	int totalPrice = 0; //할인 전 총 상품금액
	int sale2 = 0; // 총 할인가격
	int sumPrice = 0; // 할인 후 상품금액
%>

<!DOCTYPE html>
<html lang="zxx">

<head>
	<style type="text/css">
	#originPrice{ 
	font-size: 16px; font-family: 'Roboto', 'Noto Sans KR'; font-size: 13px; font-weight: bold; text-decoration: line-through; opacity: .4; vertical-align: middle;
	}
	
	#price{
	font-size : 18px;
	color: #000;
	line-weight:1.2em;
	}
	
	#name{
	font-family: 'Roboto', 'Noto Sans KR'; 
	font-size : 15px;
	color: #000;
	line-weight:1.2em;
	}
	
	#component{
	font-family: 'Roboto', 'Noto Sans KR'; 
	font-size : 15px;
	color: #666666;
	line-weight:1.2em;
	}
	
	#price2{
	font-family: 'Roboto', 'Noto Sans KR'; 
	font-size : 15px;
	color: #000;
	line-weight:1.2em;
	}
	
	
	</style>
	
	<%
		if (member_id == null) {
	%>
	<script type="text/javascript">
		alert("로그인이 필요합니다.");
		location.href = "MemberLogin.me";
	</script>
	<%
		}
	%>
	

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
	
		var chCount = 0;
	    
		//체크박스 전체 선택 및 해제
	   $(document).ready(function(){
	      $('#ch_all').click(function(){
	         if($("#ch_all").prop("checked")){
	            $("input[type=checkbox]").prop("checked",true);
	         } else {
	            $("input[type=checkbox]").prop("checked",false); 
	         }
	      });
	   })   ;
	   
		//선택상품 주문
	  function orderOptional(){
		   var check_count = document.getElementsByName("checkRow").length;
		   var checkRow = document.getElementsByName("checkRow");
		   var checked =0 ; //체크된 갯수 파악 위한 초기 변수
		   
// 		   var basketIds = new Array();
		   // 체크박스 값 확인
			for(var i=0; i<check_count; i++){
			   if(checkRow[i].checked==true){
				   checked += 1;
// 				   basketIds[i]=checkRow[i].value;
// 				   alert(basketIds[i]);
// 				   alert(checkRow[i].value);
			   }
			}
		   
		   // 값 넘기기
		   if(checked == 0){
			   alert("상품을 선택하여 주십시오.");
			   return false;
		   } else {
			   document.basketform.submit();
		   }
		   
	  }
		
		//전체상품주문
	  function orderAll() {
	         $("input[type=checkbox]").prop("checked",true);
	         document.basketform.submit();
	      }
	
	// 수량변경 button
	function CountChg(basketId) {
		location.href = "BasketModifyPro.go?basketId="+basketId+"&basketCount="+chCount;
		         
	}
	// 수량이 변경될때마다 basketCount check 후 chCount에 담는 함수
	function countChk(count) {
// 		alert(count.value);
		chCount = count.value;
// 		alert(chCount);
	}
	
	</script> 
</head>

<body>
<!--::header part start::-->
    <jsp:include page="../inc/top.jsp"/>
<!-- Header part end-->
	    <!--     서브비주얼 -->
	<jsp:include page="/inc/sub_main1.jsp"/>

    <!--================ 메뉴 영역 =================-->
    <section class="cart_area">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                            
                            </div>
                            <div class="side_menu">
								<h3>마이페이지</h3>
								<ul class="list side_list">
									<li><a href="MemberMain.me">나의 등급</a></li>
									<li><a href="MemberReserveList.me">예매내역</a></li>
									<li><a href="MemberOrderList.me">결제내역</a></li>
									<li class="active"><a href="BasketList.go">장바구니</a></li>
									<li><a href="MemberMovComment.me">리뷰내역</a></li>
									<li><a href="MemberQnADetail.me">1:1문의</a></li>
									<li><a href="MemberInfo.me">My 정보</a></li>
									<li><a href="MemberDelete.me">회원 탈퇴</a></li>
								</ul>
							</div><!-- .side_menu -->
                        </aside>
                    </div>
                </div>
          <!--================ 메뉴 영역 =================-->                      
   <div class="col-lg-9">
     <div class="row align-items-center latest_product_inner">
<!--         <section class="cart_area"> -->
    <div class="container">
      <div class="cart_inner">
        <h2 class="member_title">장바구니</h2><!-- .member_title -->
         <%
          if(basketList.size() != 0 && basketList.size() >0){
           %>
         <form action="OrderForm2.go" name="basketform" method="post">
          <table class="table">
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
            int nowPrice = goodsPrice - sale; // 할인 후 상품금액 = 할인 전 상품금액 - 할인금액
            sumPrice = totalPrice - sale2; // 할인 후 총 상품금액 = 할인 전 총 상품금액 - 총 할인가격
            
            int basketId = basketList.get(i).getBasketId();
            
         %>
            <tbody>
              <tr>
                <td><input type="checkbox" name="checkRow" class="checkSelect" value=<%=basketId %>></td> <!-- 체크박스 개별 선택 및 해제 -->
                <td>
                  <div class="media"> <!-- 상품 박스 -->
                    <div class="d-flex"> <!-- 상품 이미지 테두리 -->
                      <img src="goodsUpload/<%=basketList.get(i).getFile() %>" alt=""  width="250" />
                    </div>
                    <div class="media-body"> <!-- 상품 설명 바디 -->
                      <p id = name><b><%=basketList.get(i).getName() %></b> </p>
                      <p id = component><b><%=basketList.get(i).getComponent() %></b></p>
                      <p id = price2><b><%=basketList.get(i).getPrice() %>원</b></p>
                    </div>
                  </div>
                </td>
                <td>
                  <div class="product_count"> <!-- 수량변경 버튼 모양 -->
                    <input type="number" name="basketCount" id=basketCount value="<%=basketList.get(i).getBasketCount() %>" min="0" max="100" onchange="countChk(this)">
                  </div>
                  <div>
                  <input type="button" value="수량변경" id="countChg" onclick="CountChg(<%=basketId%>)">
                  <input type="button" value="X" id="delete" onclick="location.href='BasketDeletePro.go?basketId=<%=basketId%>'"> <!-- 휴지통모양 혹은 x -->
                  </div>
                </td>
                <td>
                <%if(sale == 0){ %>
                  <h5 id ="price"><%=goodsPrice %>원</h5> <%} else { %>
                  <h5 id ="price"><%=nowPrice %>원</h5>
                  <h5 id=originPrice><%=goodsPrice %>원</h5>
                  <%} %>
                </td>
              </tr>
         
         <%   
         }
         %>
              <tr>
                <td></td>
                <td></td>
                <td>
                  <h5>총 상품금액</h5>
                  <h5>할인금액</h5>
                  <h3>총 결제예상금액</h3>
                </td>
                <td>
                  <h5><%=totalPrice %>원</h5>
                  <h5><%=sale2 %>원</h5>
                  <h3><%=sumPrice %>원</h3>
                  <!-- Pro로 보낼 값 -->
                  <input type="hidden" name="totalPrice" value="<%=totalPrice %>">
                  <input type="hidden" name="sumPrice" value="<%=sumPrice %>">
                </td>
              </tr>
            </tbody>
          </table>
		  <!--::버튼 시작::-->
		    <div>        
		      <input type="button" class="btn_3" value="이전화면" onclick="history.back()">
		    </div>
		     <div class="checkout_btn_inner float-right">
		       <input type="button" class="btn_3" value ="선택상품주문" onclick="orderOptional()">
		       <input type="button" class="btn_3" value ="전체상품주문" onclick="orderAll()">
<!-- 		       <input type="submit" value ="개별선택 확인용(은주)"> -->
		     </div>
		  <!--::버튼 끝::-->      
         </form>
            <%  
          }
          %>
         <%
          if(basketList.size() == 0){
           %>
           <section class="emptyBasket">
            장바구니에 담긴 상품이 없습니다. <br>
            온라인 스토어에서 좀 더 저렴하게 스낵을 즐기세요! <br>
            <input type="button" class="btn_3" value="쇼핑하기" onclick="location.href='StoreList.go'" >
           </section>
           <%} %>
         
        </div>
      </div>
<!--   </section> -->
                	
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Category Product Area =================-->


    <!--::footer_part start::-->
    <jsp:include page="../inc/bottom.jsp"/>
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