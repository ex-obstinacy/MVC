<%@page import="vo.StoreBean"%>
<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
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
              <h2>상품 목록</h2>
              <p>란희 <span>-</span> GoodsList</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- breadcrumb start-->
  
	<!-- 게시판 리스트 -->
	<section id="listForm" class="checkout_area padding_top">
		<div class="container">
      	  <div class="cart_inner">
            <div class="table-responsive">
		<h2>상품 목록</h2>
		<table class="table">
			<%
			if(articleList != null && listCount > 0) {
			%>
				<tr>
					<th>상품번호</th>
					<th>카테고리</th>
					<th>상품이름</th>
					<th>상품가격</th>
					<th>할인율</th>
					<th>구성품</th>
					<th>판매량</th>
					<th>상품이미지</th>
					<th>내용</th>
					<th>관리</th>
				</tr>
				<%
				for(int i = 0; i < articleList.size(); i++) {
				%>
				<tr>
					<td align="center"><%=articleList.get(i).getGoodsId() %></td>
					<td align="center"><%=articleList.get(i).getCtg() %></td>
					<td align="center"><%=articleList.get(i).getName() %></td>
					<td align="center"><%=articleList.get(i).getPrice() %></td>
					<td align="center"><%=articleList.get(i).getSale() %></td>
					<td align="center"><%=articleList.get(i).getComponent() %></td>
					<td align="center"><%=articleList.get(i).getSellCount() %></td>
					<td align="center"><%=articleList.get(i).getFile() %></td>
					<td align="center"><%=articleList.get(i).getContent()%></td>
					<td><input type="button" value="수정" onclick="location.href='GoodsModifyForm.go?goodsId=<%=articleList.get(i).getGoodsId()%>&page=<%=nowPage%>'">
					<input type="button" value="삭제" onclick="location.href='GoodsDeleteForm.go?goodsId=<%=articleList.get(i).getGoodsId()%>&page=<%=nowPage%>'"></td>
				</tr>
				
				<%}%>
		</table>
		  </div>
        </div>
      </div>
	</section>
	<section id="buttonArea">
  	  <div class="container">
		<input type="button" value="상품등록" class="btn_3" onclick="location.href='GoodsWriteForm.go'" >
	  </div>
	</section>
	<section id="pageList">
	  <div class="container">
	<%if(nowPage <= 1) {%>
			<input type="button" value="이전" class="btn_3">&nbsp;
	<%} else {%>
			<input type="button" value="이전" class="btn_3" onclick="location.href='GoodsList.go?page=<%=nowPage - 1 %>'">&nbsp;
	<%} %>
	
	<%for(int i = startPage; i <= endPage; i++) { 
			if(i == nowPage) { %>
				[<%=i %>]&nbsp;
			<%} else { %>
					<a href="GoodsList.go?page=<%=i %>">[<%=i %>]</a>&nbsp;
			<%} %>
	<%} %>
	
	<%if(nowPage >= maxPage) { %>
			<input type="button" value="다음" class="btn_3">
	<%} else { %>
			<input type="button" value="다음" class="btn_3" onclick="location.href='GoodsList.go?page=<%=nowPage + 1 %>'">
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