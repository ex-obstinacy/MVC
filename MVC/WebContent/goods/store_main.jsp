<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.StoreBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	ArrayList<StoreBean> articleList = (ArrayList<StoreBean>)request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
%>  

<!DOCTYPE html>
<html lang="zxx">
<head>
<!-- 탭메뉴 -->
<style>
ul.store-tab{
	margin: 0px;
	padding: 0 50px 50px 10%;
	list-style: none;
}

ul.store-tab li{
	background: none;
	color: #ffffff;
	display: inline-block;
	padding: 0 50px 50px 80px;
	cursor: pointer;
	line-height:50px;
	height:50px;
	box-sizing: border-box;
}

.price{
	text-decoration : line-through;
}

</style>
<!-- 탭메뉴 끝 -->
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
</script>


    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>aranoz</title>
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
<!--     ::header part start:: -->
    <jsp:include page="/inc/top.jsp"/>
<!--     Header part end -->

<!--     서브비주얼 -->
	<jsp:include page="/inc/sub_store1.jsp"/>
	
    <!--================ 스토어 메인 상품 !!!! =================-->
  <section class="product_list">
        <div class="container">
			<div class="col-lg-12">
                <div class="section_tittle text-center">
                    <ul class="store-tab"> 
						<li class="active"><a href="#package"><span>패키지</span></a>&nbsp;</li>
						<li class="active"><a href="#ticket"><span>관람권</span>&nbsp;</a></li>
						<li class="active"><a href="#snack"><span>스낵음료</span>&nbsp;</a></li>
				    </ul>
                </div>
            </div>
                    <!--======= 패키지 카테고리 상품!!!!!! =======-->
            <div id = "package">
              <h3>패키지</h3>
                <table>
                  <tr>
                  <%
                  		int line = 0;
                  	
                  		for (int i = 0; i < articleList.size(); i++) {
                  			int sale = (int)(articleList.get(i).getPrice() * articleList.get(i).getSale() * 0.01); //세일가 = 원가 * (세일 * 0.01) -> %로 나타낸거임
                  			int sumPrice = articleList.get(i).getPrice() - sale; // 할인 후 적용가 = 원가 - 세일가
                  			
                  			if (articleList.get(i).getCtg().equals("package")) {
                  				line++;
                  %>
                  	<td>
                  		<div class="single_product_item">
                  			<a href="GoodsDetail.go?goodsId=<%=articleList.get(i).getGoodsId() %>&page=<%=nowPage %>"><img src="goodsUpload/<%=articleList.get(i).getFile()%>" width="250"></a>
                  			<div class="single_product_text">
                  				<h4><%=articleList.get(i).getName() %></h4>
                  				<h3 class = "price"><%=articleList.get(i).getPrice() %> 원</h3>
                  				<h4><%=sumPrice%> 원</h4>
                  				<a href="BasketAdd.go?goodsId=<%=articleList.get(i).getGoodsId()%>" class="add_cart">장바구니</a>
<!-- 								<input type="button"> -->
                  				<a href="OrderForm.go?goodsId=<%=articleList.get(i).getGoodsId()%>" class="buy">구매하기</a>
                  				
                  			</div>
                  		</div>
                  	</td>
                  <%
                  			}
                  			if (line % 4 == 0) {
                  %>
                  </tr>
                  <tr>	
                  <%
                  			}
                  		}
                  %>
                  </tr>
                </table>
             </div> 
                 
                    <!--======= 관람권 카테고리 상품!!!!!! =======-->
             <div id = "ticket">
               <h3>관람권</h3>
                    <table>
                    <tr>
                  <%
                  		line = 0;
                  	
                  		for (int i = 0; i < articleList.size(); i++) {
                  			int sale = (int)(articleList.get(i).getPrice() * articleList.get(i).getSale() * 0.01); //세일가 = 원가 * (세일 * 0.01) -> %로 나타낸거임
                  			int sumPrice = articleList.get(i).getPrice() - sale; // 할인 후 적용가 = 원가 - 세일가
                  			
                  			if (articleList.get(i).getCtg().equals("ticket")) {
                  				line++;
                  %>
                  	<td>
                  		<div class="single_product_item">
                  			<a href="GoodsDetail.go?goodsId=<%=articleList.get(i).getGoodsId() %>&page=<%=nowPage %>"><img src="goodsUpload/<%=articleList.get(i).getFile()%>" width="250"></a>
                  			<div class="single_product_text">
                  				<h4><%=articleList.get(i).getName() %></h4>
                  				<h3 class = "price"><%=articleList.get(i).getPrice() %> 원</h3>
                  				<h4><%=sumPrice%> 원</h4>
                  				<a href="BasketAdd.go?goodsId=<%=articleList.get(i).getGoodsId()%>" class="add_cart">장바구니</a>
                  				<a href="OrderForm.go?goodsId=<%=articleList.get(i).getGoodsId()%>" class="buy">구매하기</a>
                  				
                  			</div>
                  		</div>
                  	</td>
                  <%
                  			}
                  			if (line % 4 == 0) {
                  %>
                  </tr>
                  <tr>	
                  <%
                  			}
                  		}
                  %>
                  </tr>
                    </table>
             </div> 
                    
                    <!--======= 스낵 카테고리 상품!!!!!! =======-->
             <div id = "snack">
                    <h3>스낵음료</h3>
                     <table>
                    <tr>
                  <%
                  		line = 0;
                  	
                  		for (int i = 0; i < articleList.size(); i++) {
                  			int sale = (int)(articleList.get(i).getPrice() * articleList.get(i).getSale() * 0.01); //세일가 = 원가 * (세일 * 0.01) -> %로 나타낸거임
                  			int sumPrice = articleList.get(i).getPrice() - sale; // 할인 후 적용가 = 원가 - 세일가
                  			
                  			if (articleList.get(i).getCtg().equals("snack")) {
                  				line++;
                  %>
                  	<td>
                  		<div class="single_product_item">
                  			<a href="GoodsDetail.go?goodsId=<%=articleList.get(i).getGoodsId() %>&page=<%=nowPage %>"><img src="goodsUpload/<%=articleList.get(i).getFile()%>" width="250"></a>
                  			<div class="single_product_text">
                  				<h4><%=articleList.get(i).getName() %></h4>
                  				<h3 class = "price"><%=articleList.get(i).getPrice() %> 원</h3>
                  				<h4><%=sumPrice%> 원</h4>
                  				<a href="BasketAdd.go?goodsId=<%=articleList.get(i).getGoodsId()%>" class="add_cart">장바구니</a>
                  				<a href="OrderForm.go?goodsId=<%=articleList.get(i).getGoodsId()%>" class="buy">구매하기</a>
                  				
                  			</div>
                  		</div>
                  	</td>
                  <%
                  			}
                  			if (line % 4 == 0) {
                  %>
                  </tr>
                  <tr>	
                  <%
                  			}
                  		}
                  %>
                  </tr>
                    </table>
                  
             </div>  
                        
       </div>
   </section>
    <!--::footer_part start::-->
    <jsp:include page="/inc/bottom.jsp"/>
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