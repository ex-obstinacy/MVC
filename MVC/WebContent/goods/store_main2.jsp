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
	
	StoreBean sb = new StoreBean();
%>  
<!DOCTYPE html>
<html lang="zxx">
<head>
<!-- 탭메뉴 -->
<style>
ul.store-tab{
	margin: 0px;
	padding: 50px 50px 50px 50px;
	list-style: none;
}

ul.store-tab li{
	background: none;
	color: #ffffff;
	display: inline-block;
	padding: 50px 50px 50px 50px;
	cursor: pointer;
	line-height:50px;
	height:50px;
	box-sizing: border-box;
}

</style>


<!-- 탭메뉴 끝 -->

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
                            <h2>TICKET & POPCORN <br>STORE</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->
	
    <!--================ 스토어 메인 상품 !!!! =================-->
  
        <div class="container">
            <div class="row">
                
                <div class="col-lg-9">

                    <div class="row align-items-center latest_product_inner">
                    	<ul class="store-tab"> 
						<li class="active"><a href="#package">패키지&nbsp;</a></li>
						<li class=""><a href="#ticket">관람권&nbsp;</a></li>
						<li class=""><a href="#snack">스낵음료&nbsp;</a></li>
						</ul>
                    <!--======= 패키지 카테고리 상품!!!!!! =======-->
                  <div id = "package">
                    <h3>패키지</h3>
                    <table>
                    <tr>
                    <%
                    int i = 0;
                    for(int j=0; j<articleList.size(); j++){
                    	%>
                 	  
                        <div class="col-lg-4 col-sm-6">
                            <td>
                        <a href="GoodsDetail.go?goodsId=<%=articleList.get(i).getGoodsId() %>&page=<%=nowPage %>">
                            <div class="single_product_item">
                            <img src="goodsUpload/<%=articleList.get(i).getFile()%>">
                                <div class="single_product_text">
                                    <h4><%=articleList.get(i).getName() %></h4>
                                    <h3><%=articleList.get(i).getPrice() %> 원</h3>
                                     <a href="#" class="add_cart">장바구니</a> 
                                    <a href="#" class="buy">구매하기</a> 
                                </div>
                            </div>
                        </a>
                            </td>
                        </div>
                   <%
                   i++; 
                  	 if(i%4 ==0){
                  	 %>
                    </tr>
                  	 <%
                  	 }
                   }
                  	 %>
                    </table>
                    </div> 
                 
                    <!--======= 관람권 카테고리 상품!!!!!! =======-->
                   <div id = "ticket">
                    <h3>관람권</h3>
                    <a href="#">
                    <table>
                    <tr>
                    <%
                    i = 0;
                    for(int j=0; j<articleList.size(); j++){%>
                        <div class="col-lg-4 col-sm-6">
                            <td>
                            <div class="single_product_item">
                            <img src="goodsUpload/<%=articleList.get(i).getFile()%>">
                                <div class="single_product_text">
                                    <h4><%=articleList.get(i).getName() %></h4>
                                    <h3><%=articleList.get(i).getPrice() %> 원</h3>
                                     <a href="#" class="add_cart">장바구니</a> 
                                    <a href="#" class="buy">구매하기</a> 
                                </div>
                            </div>
                            </td>
                        </div>
                   <%
                   i++; 
                  	 if(i%4 ==0){
                  	 %>
                    </tr>
                  	 <%
                  	 }
                   }
                  	 %>
                    </table>
                    </a>
                    </div> 
                    
                    <!--======= 스낵 카테고리 상품!!!!!! =======-->
                    <div id = "snack">
                    <h3>스낵음료</h3>
                    <a href="#">
                     <table>
                    <tr>
                    <%
                   i = 0;
                    for(int j=0; j<articleList.size(); j++){%>
                       <div class="col-lg-4 col-sm-6">
                            <td>
                            <div class="single_product_item">
                            <img src="goodsUpload/<%=articleList.get(i).getFile()%>">
                                <div class="single_product_text">
                                    <h4><%=articleList.get(i).getName() %></h4>
                                    <h3><%=articleList.get(i).getPrice() %> 원</h3>
                                     <a href="#" class="add_cart">장바구니</a> 
                                    <a href="#" class="buy">구매하기</a> 
                                </div>
                            </div>
                            </td>
                        </div>
                   <%
                   i++; 
                  	 if(i%4 ==0){
                  	 %>
                    </tr>
                  	 <%
                  	 }
                   }
                  	 %>
                    </table>
                    
                    </a>
                    </div>  
                        
                    </div>
                </div>
            </div>
        </div>
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