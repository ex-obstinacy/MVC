<%@page import="kr.or.kobis.kobisopenapi.consumer.soap.movie.MovieAPIServiceImplService"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.soap.movie.MovieInfoResult"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	// 파라메터 설정	//20126674 설국열차
	String movieCd = request.getParameter("movieCd")==null?"":request.getParameter("movieCd");						//영화코드
	// 발급키
	String key = "9e0587d5d88c9c3ac140d5daeeee18bd";	
	
	// KOBIS 오픈 API SOAP Client를 통해 호출
	MovieInfoResult movieInfoResult = new MovieAPIServiceImplService().getMovieAPIServiceImplPort().searchMovieInfo(key, movieCd);
	request.setAttribute("movieInfoResult",movieInfoResult);
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
    
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    <script>
    	
	    $(document).ready( function() {
	 
	        $("#stillCut").change(function () {
	            
	            var fileInput = document.getElementById("stillCut");
	            
	            var files = fileInput.files;
	            var file;
	            var fileName = files[0].name;
	            
	            for (var i = 1; i < files.length; i++) {
	                file = files[i];
// 	                alert(file.name);
	                fileName = fileName + "&" + file.name;
	                
	            }
// 	            alert(fileName);
	            document.getElementById('stillCutFileName').setAttribute('value', fileName);
	            
	        });
	 
	    });
	</script>
	
	<!-- 영화 코드 검색 -->
	<script type="text/javascript">
		function searchMov() {
			var movieCd = document.getElementById('movieCd').value;
			
			location.href="AdminMovWrite.mo?movieCd=" + movieCd;
			
		}
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
                            <h2>영화 등록</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->

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
                                        <a href="NoticeList.no">공지사항</a>
                                    </li>
                                    <li>
                                        <a href="QnaList.qn">1대1 문의</a>
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
	                    <form action="AdminMovWritePro.mo" method="post" enctype="multipart/form-data">
	                    	<table class="table">
	                    		<tr>
	                    			<td>제목</td>
	                    			<td><input type="text" class="single-input" name="subject" value="<c:out value="${movieInfoResult.movieInfo.movieNm}"/>"></td>
	                    			<td>영화 코드</td>
	                    			<td>
	                    				<input type="text" class="single-input" placeholder="영화진흥위원회 코드" name=movieCd id=movieCd value="<%=movieCd %>">
	                    				<input type="button" value="검색" onclick="searchMov()">
	                    			</td>
	                    		</tr>
	                    		<tr>
	                    			<td>장르</td>
	                    			<td><input type="text" class="single-input" name="genre" value="<c:forEach items="${movieInfoResult.movieInfo.genres.genre}" var="genre"><c:out value="${genre.genreNm}"/>  </c:forEach>"></td>
	                    			<td>개봉일</td>
	                    			<td><input type="date" class="single-input" name="openDt"></td>
	                    		</tr>
	                    		<tr>
	                    			<td>상영시간</td>
	                    			<td><input type="text" class="single-input" name="showTm" value="<c:out value="${movieInfoResult.movieInfo.showTm }"/>"></td>
	                    			<td>감독</td>
	                    			<td><input type="text" class="single-input" name="director" value="<c:forEach items="${movieInfoResult.movieInfo.directors.director}" var="director"><c:out value="${director.peopleNm}"/>  </c:forEach>"></td>
	                    		</tr>
	                    		<tr>
	                    			<td>출연</td>
	                    			<td><input type="text" class="single-input" name="cast" value="<c:forEach items="${movieInfoResult.movieInfo.actors.actor}" var="actor"><c:out value="${actor.peopleNm}"/>  </c:forEach>"></td>
	                    			<td>제작국가</td>
	                    			<td><input type="text" class="single-input" name="nationNm" value="<c:forEach items="${movieInfoResult.movieInfo.nations.nation}" var="nation"><c:out value="${nation.nationNm}"/>  </c:forEach>"></td>
	                    		</tr>
	                    		<tr>
	                    			<td>영화사</td>
	                    			<td><input type="text" class="single-input" name="companys" value="<c:forEach items="${movieInfoResult.movieInfo.companys.company}" var="company"><c:out value="${company.companyNm}"/>  </c:forEach>"></td>
	                    			<td>관람등급</td>
	                    			<td>
	                    				<div class="default-select" id="default-select_2">
											<select name="grade">
												<option value="ALL">전체관람가</option>
												<option value="12">12세이상관람가</option>
												<option value="15">15세이상관람가</option>
												<option value="18">청소년관람불가</option>
											</select>
										</div>
	                    			</td>
	                    		</tr>
	                    		<tr>
	                    			<td>포스터</td>
	                    			<td><input type="file" name="post"></td>
	                    			<td>스틸컷</td>
	                    			<td>
	                    				<input type="file" multiple="multiple" name="stillCut" id="stillCut">
	                    				<input type="hidden" name="stillCutFileName" id="stillCutFileName">
	                    			</td>
	                    		</tr>
	                    		<tr>
	                    			<td colspan="4">
	                    				<textarea class="single-textarea" placeholder="트레일러" name="trailer" id="trailer"></textarea>
	                    			</td>
	                    		</tr>
	                    		<tr>
	                    			<td colspan="4">
	                    				<textarea class="single-textarea" placeholder="영화정보" name="content" id="content"></textarea>
	                    			</td>
	                    		</tr>
	                    		<tr>
	                    			<td colspan="4">
	                    				<input type="submit" value="등록" class="genric-btn primary circle">
	                    				<input type="reset" value="취소" class="genric-btn success circle">
	                    			</td>
	                    		</tr>
	                    		
	                    	</table>
	                    </form>
                    
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