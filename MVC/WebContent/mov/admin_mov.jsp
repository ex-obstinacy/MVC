<%@page import="vo.MovBean"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.soap.movie.MovieAPIServiceImplService"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.soap.movie.MovieInfoResult"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	// MovBean 객체 가져오기
	MovBean article = (MovBean)request.getAttribute("article");
	
	String nowPage = request.getParameter("page");
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
    
</head>

<body>
    <!--::header part start::-->
    <jsp:include page="../inc/top.jsp"/>
    <!-- Header part end-->

    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
<!--     <section class="breadcrumb breadcrumb_bg"> -->
<!--         <div class="container"> -->
<!--             <div class="row justify-content-center"> -->
<!--                 <div class="col-lg-8"> -->
<!--                     <div class="breadcrumb_iner"> -->
<!--                         <div class="breadcrumb_iner_item"> -->
<!--                             <h2>영화 등록</h2> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </section> -->
    <!-- breadcrumb start-->
    
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
                    	<table class="table">
                    		<tr>
                    			<td width="80">제목</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getSubjet() %>"></td>
                    			<td width="80">영화 코드</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getMovieCd() %>"></td>
                    		</tr>
                    		<tr>
                    			<td>장르</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getGenre() %>"></td>
                    			<td>개봉일</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getOpenDt() %>"></td>
                    		</tr>
                    		<tr>
                    			<td>상영시간</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getShowTm() %>"></td>
                    			<td>감독</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getDirector() %>"></td>
                    		</tr>
                    		<tr>
                    			<td>출연</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getCast() %>"></td>
                    			<td>제작국가</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getNationNm() %>"></td>
                    		</tr>
                    		<tr>
                    			<td>영화사</td>
                    			<td><input type="text" readonly="readonly" class="single-input" value="<%=article.getCompanys() %>"></td>
                    			<td>관람등급</td>
                    			<td>
                    				<% if (article.getGrade().equals("ALL")) { %>
                    				전체관람가
                    				<% } else if (article.getGrade().equals("12")) { %>
                    				12세이상관람가
                    				<% } else if (article.getGrade().equals("15")) { %>
                    				15세이상관람가
                    				<%} else { %>
                    				청소년관람불가
                    				<%} %>
                    			</td>
                    		</tr>
                    		<tr>
                    			<td>포스터</td>
                    			<td><img src="movUpload/<%=article.getPost() %>" width="100"></td>
                    			<td>스틸컷</td>
                    			<td>
                    				<% for (String stillCut: article.getStillCutFileName()) { %>
                    				<img src="movUpload/<%=stillCut %>" width="100">
                    				<% } %>
                    			</td>
                    		</tr>
                    		<tr>
                    			<td>트레일러</td>
                    			<td colspan="3"><%=article.getTrailer() %></td>
                    		</tr>
                    		<tr>
                    			<td colspan="4">
                    				<textarea class="single-textarea" placeholder="영화정보" name="content"><%=article.getContent() %></textarea>
                    			</td>
                    		</tr>
                    		<tr>
                    			<td colspan="4">
                    				<input type="button" value="목록" class="genric-btn primary circle" onclick="location.href='AdminMovList.mo?page=<%=nowPage %>'">
                    			</td>
                    		</tr>
                    		
                    	</table>
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