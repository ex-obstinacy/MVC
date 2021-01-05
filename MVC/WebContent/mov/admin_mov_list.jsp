<%@page import="vo.MovBean"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	ArrayList<MovBean> articleList = (ArrayList<MovBean>) request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
%>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>MVC</title>
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
        
    <!-- 영화 삭제 -->
    <script type="text/javascript">
		function chDelete(movieCd){
             var check = confirm("삭제하시겠습니까?");

             if(check){
            	 location.href="AdminMovDeletePro.mo?movieCd=" + movieCd;
            	 
             }
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
    <section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                            
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a href="AdminMovList.mo">영화</a>
                                    </li>
                                    <li>
                                    	<a href="CinemaAddForm.re">영화관</a>
                                    </li>
                                    <li>
                                    	<a href="MovieAddForm.re">영화관 - 영화</a><br>
                                    </li>
                                    <li>
                                        <a href="GoodsList.go">스토어</a>
                                    </li>
                                    <li>
                                        <a href="AdminNoticeList.ad">공지사항</a>
                                    </li>
                                    <li>
                                        <a href="AdminQnAList.ad">1대1 문의</a>
                                    </li>
                                    <li>
                                        <a href="AdminMemberList.ad">회원 목록</a>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                    </div>
                </div>
          <!--================ 메뉴 영역 =================-->          
                
                <div class="col-lg-9">
                    <div class="row align-items-center"><!-- 삭제 class(latest_product_inner) -->

						<!-- 게시판 리스트 -->
						<section id="listForm" class="checkout_area padding_top">
							<div class="container">
								<div class="cart_inner">
									<div class="table-responsive">
										<table class="table">
											<%
												if (articleList != null && listCount > 0) {
											%>
											<tr align="center">
												<th>제목</th>
												<th>영화 코드</th>
												<th>장르</th>
												<th>개봉일</th>
												<th width="80">상영시간</th>
												<th>감독</th>
												<th width="80">제작국가</th>
												<th></th>
											</tr>
											<%
												for (int i = 0; i < articleList.size(); i++) {
											%>
											<tr>
												<td align="center"><a href="AdminMovDetail.mo?movieCd=<%=articleList.get(i).getMovieCd() %>&page=<%=nowPage %>"><%=articleList.get(i).getSubjet() %></a></td>
												<td align="center"><%=articleList.get(i).getMovieCd() %></td>
												<td align="center"><%=articleList.get(i).getGenre() %></td>
												<td align="center"><%=articleList.get(i).getOpenDt() %></td>
												<td><%=articleList.get(i).getShowTm() %></td>
												<td><%=articleList.get(i).getDirector() %></td>
												<td align="center"><%=articleList.get(i).getNationNm() %></td>
												<td><input type="button" value="삭제" onclick="chDelete('<%=articleList.get(i).getMovieCd() %>')"></td>
											</tr>
											<%
												}
											%>
										</table>
									</div>
								</div>
							</div>
						</section>
						<section id="pageList" style="text-align: center; width: 100%;">
							<div class="container" style="width: 100%">
								<input type="button" value="등록" class="btn_3" onclick="location.href='AdminMovWrite.mo'" style="margin-right: 50px">
								
								<%
									if (nowPage <= 1) {
								%>
								<input type="button" value="이전" class="btn_3">&nbsp;
								<%
									} else {
								%>
								<input type="button" value="이전" class="btn_3" onclick="location.href='AdminMovList.mo?page=<%=nowPage - 1%>'">&nbsp;
								<%
									}
								%>
					
								<%
									for (int i = startPage; i <= endPage; i++) {
									if (i == nowPage) {
								%>
								[<%=i%>]&nbsp;
								<%
									} else {
								%>
								<a href="AdminMovList.mo?page=<%=i%>">[<%=i%>]
								</a>&nbsp;
								<%
									}
								%>
								<%
									}
								%>
					
								<%
									if (nowPage >= maxPage) {
								%>
								<input type="button" value="다음" class="btn_3">
								<%
									} else {
								%>
								<input type="button" value="다음" class="btn_3"
									onclick="location.href='AdminMovList.mo?page=<%=nowPage + 1%>'">
								<%
									}
								%>
							</div>
						</section>
						<%
							} else {
						%>
						<section id="emptyArea">
							<div class="container">등록된 글이 없습니다</div>
							<input type="button" value="등록" class="btn_3" onclick="location.href='AdminMovWrite.mo'">
						</section>
						<%
							}
						%>
                    
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