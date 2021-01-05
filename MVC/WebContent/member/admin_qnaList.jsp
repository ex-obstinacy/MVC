<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.QnaBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	ArrayList<QnaBean> articleList = (ArrayList<QnaBean>)request.getAttribute("articleList");

	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
 
 %>

<!DOCTYPE html>
<html lang="zxx">

<head>

	<%
		if (id == null) {
	%>
	<script type="text/javascript">
		alert("로그인이 필요합니다.");
		location.href = "MemberLogin.me";
	</script>
	<%
		} else if (!id.equals("admin")) {
	%>
			<script type="text/javascript">
				alert("잘못된 접근입니다.");
				history.back();
			</script>
	<%
		}
	%>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>MVC</title>
    
       <style type="text/css">
    	/* div정리 */
		.btnDiv {text-align: center;}
		.btnDiv > div {display: inline-block;}
		.btnWrite {margin-right: 50px;}
		.search{margin-left: 50px;}
    
    </style>
    
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
                    <div class="row align-items-center latest_product_inner">

						<%
							if(articleList.size() != 0) {
						%>
						<table class="table">
							<%
								if(id!=null){
							%>
							<tr>
								<td align="center">번호</td>
								<td align="center">제 목</td>
								<td align="center">작성자</td>
								<td align="center">작성일</td>
								<td align="center">조회수</td>
							</tr>
					
							<%
								for(int i = 0; i < articleList.size(); i++) {
							%>
							<tr>
								<td align="center"><%=articleList.get(i).getNum() %></td>
								<td align="center">
								<%if(articleList.get(i).getRe_lev() != 0) { %>
								<%for(int j = 0; j <= articleList.get(i).getRe_lev() * 2; j++) { %>
								&nbsp;
								<%} %>
								└▶
								<%} %>
								&nbsp; <a href="QnaDetail.qn?num=<%=articleList.get(i).getNum() %>
															&page=<%=nowPage %>
															&re_ref=<%=articleList.get(i).getRe_ref() %>
															&re_lev=<%=articleList.get(i).getRe_lev() %>">
								 <%=articleList.get(i).getSubject() %>
								</a></td>
								<td align="center"><%=articleList.get(i).getMember_id() %></td>
								<td align="center"><%=sdf.format(articleList.get(i).getDate())%></td>
								<td align="center"><%=articleList.get(i).getReadcount() %></td>
							</tr>
							<%	}%>
							<%}%>
						</table>
						

	
							
						<div class="btnDiv">
								<div class="btnWrite">
									<input type="button" value="글쓰기" class="btn_3" onclick="location.href='QnaWriteForm.qn'">
								</div>
								<div>
								<%
									if(id!=null){
										if(nowPage <= 1) {
								%>
								<input type="button" value="이전" class="btn_3">&nbsp;
								<%
									} else {
								%>
								<input type="button" value="이전" class="btn_3" onclick="location.href='AdminQnAList.ad?page=<%=nowPage - 1 %>'">&nbsp;
								<%
									} for(int i = startPage; i <= endPage; i++) { 
										if(i == nowPage) { 
								%>
								[<%=i %>]&nbsp;
								<%
										} else { 
								%>
								<a href="AdminQnAList.ad?page=<%=i %>">[<%=i %>]</a>&nbsp;
								<%		} %>
								<%	} %>
								<%	if(nowPage >= maxPage) { %>
								<input type="button" value="다음" class="btn_3">
								<%	} else { %>
								<input type="button" value="다음" class="btn_3" onclick="location.href='AdminQnAList.ad?page=<%=nowPage + 1 %>'">
								<%	} %>
								<%
									}
								%>
							</div>
								<div class="search">
									<form action="QnaListSearch.qn" method="post">
										<input type="text" name="search" class="input_box" placeholder="Search..">
										<input type="submit" name="searchBtn" class="btn_3" value="검색">
									</form>
								</div>
						</div>

						<% 
							}else {
						%>
			
						<section id="emptyArea">
							<div class="container">등록된 글이 없습니다</div>
						</section>
						<section id="buttonArea">
							<div class="container">
								<input type="button" value="글쓰기" class="btn_3" onclick="location.href='QnaWriteForm.qn'">
							</div>
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