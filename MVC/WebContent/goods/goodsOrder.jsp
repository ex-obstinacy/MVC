<%@page import="vo.StoreBean"%>
<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	ArrayList<StoreBean> orderList = (ArrayList<StoreBean>)request.getAttribute("orderList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
	
	
%>                
<!DOCTYPE html>
<html>
<head>
 <!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title></title>
	<style type="text/css"></style>
    <title>goodsList</title>
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
    
    <script type="text/javascript">

		function useCk(reserveNum, status){
             var a = confirm("사용완료 하시겠습니까");
             if(a){
            	 location.href="GoodsUsePro.go?reserveNum="+reserveNum;
             }else{
                return false;
             }
         }
	</script>
	
	 
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
              <h2>구매내역</h2>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- breadcrumb start-->
  
	<!-- 게시판 리스트 -->
	<section id="listForm" class="cart_area">
		<div class="container">
      	  <div class="cart_inner">
            <div class="table-responsive">
		<h2>구매 목록</h2>
		<table class="table">
			<%
			if(orderList != null && listCount > 0) {
			%>
				<tr>
 					<th>구매자</th>
					<th>주문번호</th>
					<th>카테고리</th>
					<th>상품이름</th>
					<th>구성품</th>
					<th>교환권번호</th>
					<th>사용여부</th>
					<th>관리</th>
				</tr>
				<%
				for(int i = 0; i < orderList.size(); i++) {
				%>
				<tr>
					<td align="center"><%=orderList.get(i).getMember_id() %></td>
					<td align="center"><%=orderList.get(i).getOrderNum() %></td>
					<td align="center"><%=orderList.get(i).getCtg() %></td>
					<td align="center"><%=orderList.get(i).getName() %></td>
					<td align="center"><%=orderList.get(i).getComponent() %></td>
					<td align="center"><%=orderList.get(i).getReserveNum()%></td>
					<td align="center" id="status"><% if (orderList.get(i).isStatus()) { %>Y <% } else { %>N<% } %></td>
					<td><input type="button" value="사용완료" onclick="useCk('<%=orderList.get(i).getReserveNum()%>')"></td>
				</tr>
				
				<%}%>
		</table>
		  </div>
        </div>
      </div>
	</section>
	
	<section id="buttonArea">pageList
  	  <div class="container">
	  </div>
	</section>
	<section id="buttonArea">
	  <div class="container">
	<%if(nowPage <= 1) {%>
			<input type="button" value="이전" class="btn_3">&nbsp;
	<%} else {%>
			<input type="button" value="이전" class="btn_3" onclick="location.href='GoodsOrder.go?page=<%=nowPage - 1 %>'">&nbsp;
	<%} %>
	
	<%for(int i = startPage; i <= endPage; i++) { 
			if(i == nowPage) { %>
				[<%=i %>]&nbsp;
			<%} else { %>
					<a href="GoodsOrder.go?page=<%=i %>">[<%=i %>]</a>&nbsp;
			<%} %>
	<%} %>
	
	<%if(nowPage >= maxPage) { %>
			<input type="button" value="다음" class="btn_3">
	<%} else { %>
			<input type="button" value="다음" class="btn_3" onclick="location.href='GoodsOrder.go?page=<%=nowPage + 1 %>'">
	<%} %>
	  </div>
	</section>
	<%
	} else {
	%>
	<section id="emptyArea">
	<div class="container">등록된 글이 없습니다</div>
	</section>
	<%
	}
	%>
	
  <!-- ================ goodsList section end ================= -->

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