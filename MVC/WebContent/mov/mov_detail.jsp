<%@page import="vo.PageInfo"%>
<%@page import="vo.MovCommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.MovBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	// MovBean 객체 가져오기
	MovBean article = (MovBean)request.getAttribute("article");
	
	ArrayList<MovCommentBean> articleList = (ArrayList<MovCommentBean>) request.getAttribute("articleList");
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
  <link rel="stylesheet" href="css/slick.css"/>
	<link rel="stylesheet" href="css/slick-theme.css"/>
	
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>

	<script src="js/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	
	<script type="text/javascript">
	
	var ratingPoint = 10;
	
	$(document).ready(function(){ 
		// 스틸컷 슬라이더
		$('.stillcut_slider').slick({
			  slidesToShow: 1,
			  slidesToScroll: 1,
			  autoplay: true,
			  autoplaySpeed: 4000,
			  speed: 300,
			  infinite: true,
			  dots : true,
			  dotsClass : "slick-dots",
			  nextArrow:$('.next'),
			  prevArrow:$('.prev'),
		});
		
		$('.start_btn').click(function(){   // 스틸컷 슬라이더 시작
			$('.stillcut_slider').slick('slickPlay'); 
			$(this).css('display','none');
			$('.stop_btn').css('display','block');
		});
		
		$('.stop_btn').click(function(){ // 스틸컷 슬라이더 정지
			$('.stillcut_slider').slick('slickPause');    
			$(this).css('display','none');
			$('.start_btn').css('display','block');
		});
		
		// 영화상세 탭메뉴
		$('ul.detail_tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');

			$('ul.detail_tabs li').removeClass('current');
			$('.tab-content').removeClass('current');

			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
		});
		
		// 트레일러 팝업창 띄우기
		$(".trailer_thumb").click(function(){ //레이어 팝업 열기 버튼 클릭 시
			$(this).next("div").css("display","block");
			$('.black_bg').css("display","block");
			$(this).next("div").children("iframe")[0].contentWindow.postMessage('{"event":"command","func":"' + 'playVideo' + '","args":""}', '*');
		});
		
		$(".close_btn").click(function(){ //닫기
			$(".trailer_popup").css("display","none");
			$('.black_bg').css("display","none");
			$(this).next("iframe")[0].contentWindow.postMessage('{"event":"command","func":"' + 'stopVideo' + '","args":""}', '*');
		});
		
		
		$('#writeComment').submit(function() {
// 			alert(ratingPoint);
			$('#cmgrade').attr('value', ratingPoint);
		});
		
		// 평점 별 채우기
		$(".star_box li").click(function(){
			var starArr = $(".star_box li").get();
			var checkIndex = $(this).text();
			
			$(".star_box li").removeClass("checked");
			
			for(var i = 0; i < checkIndex; i++){
				$(starArr[i]).attr("class", "checked");
			}
			
		});
		

		
	});
	
	
		function deleteMovComment(movieCd, nowPage, num){
	        var check = confirm("삭제하시겠습니까?");
	
	        if(check){
	       	 location.href="MovCommentDeletePro.mo?movieCd=" + movieCd + "&page=" + nowPage + "&num=" + num;
	       	 
	        }
	    }
		
		function rating(rating) {
			ratingPoint = rating;
// 			alert(rating);
			var element = document.getElementById('rating_point');
			element.innerHTML = ratingPoint;
					
		}
	
	</script>
</head>

<body>
	<div class="black_bg"></div><!-- .black_bg(트레일러 영상 시작시 검은배경) -->
  <!--::header part start::-->
	<jsp:include page="/inc/top.jsp"/>
  <!-- Header part end-->

<!-- <div id="sub_content" class="mov_detail"> -->
	<div class="stillcut_box">
		<div class="stillcut_pager">
			<button class="prev">prev</button>
			<button class="next">next</button>
		</div>
		<ul class="stillcut_slider">
			<%
			for (int i=0; i < article.getStillCutFileName().length; i++) {
			%>
			<li><img src="movUpload/<%=article.getStillCutFileName()[i] %>"></li>
			<%
			}
			
			%>
		
<!-- 			<li><img src="img/sub/mov_detail/stillcut1.jpg"></li> -->
<!-- 			<li><img src="img/sub/mov_detail/stillcut2.jpg"></li> -->
<!-- 			<li><img src="img/sub/mov_detail/stillcut3.jpg"></li> -->
<!-- 			<li><img src="img/sub/mov_detail/stillcut4.jpg"></li> -->
<!-- 			<li><img src="img/sub/mov_detail/stillcut5.jpg"></li> -->
<!-- 			<li><img src="img/sub/mov_detail/stillcut6.jpg"></li> -->
<!-- 			<li><img src="img/sub/mov_detail/stillcut7.jpg"></li> -->
		</ul>
		<div class="stillcut_control">
			<span class="start_btn">start</span>
			<span class="stop_btn">stop</span>
		</div>
	</div><!-- .stillcut_Box -->
	
	<div class="container">
		<section class="detail_box1">
			<img src="movUpload/<%=article.getPost() %>">
			<div class="detail_top">
				<h2 class="grade_<%=article.getGrade() %>">
					<%=article.getSubjet() %>
				</h2>
				<ul class="detail_info1">
					<li>
						<span>관람객 평점</span>
						<strong><%=article.getTotalRating() %></strong>
					</li>
					<li>
						<span>예매율</span>
						<strong><%=article.getBookingRate() %> %</strong>
					</li>
				</ul><!-- .detail_info1 -->
				
				<div class="detail_info2">
					<dl>
						<dt>장르</dt>
						<dd>
							<span><%=article.getGenre() %></span>
							<span><%=article.getOpenDt() %> 개봉</span>
							<span><%=article.getShowTm() %>분</span>
						</dd>
					</dl>
					<dl>
						<dt>감독</dt>
						<dd>
							<span><%=article.getDirector() %></span>
						</dd>
					</dl>
					<dl>
						<dt>출연</dt>
						<dd>
							<span><%=article.getCast() %></span>
						</dd>
					</dl>
				</div><!-- .detail_info2 -->
				<a href="http://localhost:8080/MVC/ReserveMain.re?movieCd=<%=article.getMovieCd() %>" class="genric-btn primary circle">예매하기</a>
			</div><!-- .detail_top -->
		</section><!-- .detail_box1 -->
		
		<section class="detail_box2">
			<ul class="detail_tabs">
				<li class="tab-_ink current" data-tab="tab-1">영화정보</li>
				<li class="tab_link" data-tab="tab-2">평점 및 관람평</li>
			</ul><!-- .detail_tabs -->
			
			<div id="tab-1" class="tab-content current">
				<div class="story_cont">
					<h3>줄거리</h3>
					<p><%=article.getContent() %></p>
				</div><!-- .story_cont -->
				<div class="trailer_cont">
					<h3>트레일러</h3>
					<!-- iframe 가져오고나서 src 주소값 뒤에 ?enablejsapi=1 꼭 붙여야함 ! -->
					<ul>
					<%
						for (int i = 0; i < article.getTrailerFileName().length;i++) {
					%>
						<li>
							<div class="trailer_thumb">
								<img src="movUpload/<%=article.getStillCutFileName()[i] %>">
							</div>
							<div class="trailer_popup">
								<button class="close_btn">X</button>
								<iframe src="<%=article.getTrailerFileName()[i] %>?enablejsapi=1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
							</div>
						</li>
					<%
						}
					%>
					</ul>
				</div><!-- .trailer_cont -->
			</div>
			<div id="tab-2" class="tab-content">
				<div class="formdiv">
					<form action="MovCommentWritePro.mo" method="post" id="writeComment">
						<input type="hidden" name="movie_board_movCode" value="<%=article.getMovieCd()%>">
						<input type="hidden" name="cmgrade" id="cmgrade" value="10">
						<table class="mov_comment">
							<colgroup>
								<col width="20%"/>
								<col width="70%"/>
								<col width=""/>
							</colgroup>
							<tr>
								<td align="center">
									<div class="rating"><span id="rating_point">0</span>점</div>
									<ul class="star_box">
									<%
									for (int i = 1; i < 11; i++) {
									%>
<%-- 									<i class='fas fa-star' onclick="rating(<%=i %>)"></i> --%>
										<li onclick="rating(<%=i %>)"><%=i %></li>
									<%	
									}
									%>
									</ul>
								</td>
								<td><textarea placeholder="리뷰를 작성해주세요" name="content" class="single-textarea"></textarea></td>
								<td align="center"><input type="submit" value="관람평 작성" class="genric-btn primary circle"></td>
							</tr>
						</table>
						<table class="comment_list">
							<colgroup>
								<col width="90%"/>
								<col width=""/>
							</colgroup>
							<tr>
								<th colspan="2">총 <b><%=listCount %></b>건</th>
							</tr>
							<%for (int i = 0; i < articleList.size(); i++) { %>
							<tr>
								<td>
									<span class="comment_star"><%=articleList.get(i).getCmgrade() %></span>
									<div>
										<span class="comment_id"><%=articleList.get(i).getMember_id() %></span>
										<span class="comment_content"><%=articleList.get(i).getContent() %></span>
										<span class="comment_date"><%=articleList.get(i).getDate() %></span>
									</div>									
								</td>
								<td>
									<%if (articleList.get(i).getMember_id().equals(id)) { %>
									<input type="button" value="삭제" class="genric-btn primary circle" onclick="deleteMovComment('<%=article.getMovieCd() %>', '<%=nowPage %>', '<%=articleList.get(i).getNum() %>')">
									<%} %>
								</td>
							</tr>
							<%} %>
						</table>
					</form>
					<section id="pageList">
						<div class="container">
							<%
								if (nowPage <= 1) {
							%>
							<input type="button" value="이전" class="btn_3">&nbsp;
							<%
								} else {
							%>
							<input type="button" value="이전" class="btn_3" onclick="location.href='MovDetail.mo?movieCd=<%=article.getMovieCd() %>&page=<%=nowPage - 1%>'">&nbsp;
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
							<a href="MovDetail.mo?movieCd=<%=article.getMovieCd() %>&page=<%=i%>">[<%=i%>]
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
								onclick="location.href='MovDetail.mo?movieCd=<%=article.getMovieCd() %>&page=<%=nowPage + 1%>'">
							<%
								}
							%>
						</div>
					</section>
				</div>
			</div>
			
			
		</section><!-- .detail_box2 -->
	</div><!-- .container -->
	
<!-- </div>#sub_content -->

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
  <script src="js/stellar.js"></script>
  <script src="js/price_rangs.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
</body>

</html>