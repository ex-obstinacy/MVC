<%@page import="vo.MemberBean"%>
<%@page import="vo.ReserveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String member_id=(String)session.getAttribute("id");
int adultnum=Integer.parseInt(request.getParameter("adultNum"));
int kidsnum=Integer.parseInt(request.getParameter("kidsNum"));
String[] seatArr=request.getParameterValues("seat");

ReserveBean movie = (ReserveBean)request.getAttribute("movie");
MemberBean coupon = (MemberBean)request.getAttribute("coupon");

int coupon1000 = coupon.getCoupon_1000();
int coupon2000 = coupon.getCoupon_2000();
int coupon3000 = coupon.getCoupon_3000();
int membership = coupon.getMembership();

if(adultnum == 0){
	%>
		<script type="text/javascript">
			alert("잘못된 접근입니다.")
			history.back();
		</script>
	<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>MVC</title>
<link rel="icon" href="img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="css/all.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="css/magnific-popup.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="css/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="css/style.css">

<link rel="stylesheet" href="css/sub.css">
<link rel="stylesheet" href="css/common.css">

</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script><!-- 아임포트 결제 js -->

<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">	
	
	window.onload = function(){	
		var originPrice = document.getElementById("originPrice");
		var payPrice = document.getElementById("payPrice");
		originPrice.value = <%=adultnum*10000%> + <%=kidsnum*6000%> ;
		payPrice.value = originPrice.value;
	}
	
	function changeCoupon(coupon){
		var couponNum = document.getElementById(coupon).value;
		var useCoupon = document.getElementById("useCoupon");
		var originPrice = document.getElementById("originPrice");
		var salePrice = document.getElementById("salePrice");
		var payPrice = document.getElementById("payPrice");
				
		document.getElementById("useCoupon").name = coupon;
		if(coupon == "coupon_1000"){
			useCoupon.value = "1000원 할인 쿠폰";
			salePrice.value = "-" + 1000;
		} else if(coupon == "coupon_2000"){
			useCoupon.value = "2000원 할인 쿠폰";
			salePrice.value = "-" + 2000;
		} else if(coupon == "coupon_3000"){
			useCoupon.value = "3000원 할인 쿠폰";
			salePrice.value = "-" + 3000;
		}
		
		payPrice.value = Number(originPrice.value) + Number(salePrice.value);
		
		if(couponNum <= 0){
			alert("해당 쿠폰이 없습니다");
			$("option:eq(0)").prop("selected", true);
			document.getElementById("useCoupon").value = null;
			salePrice.value = "-0";
			payPrice.value = originPrice.value;
		}
		
		
		
	}
	
	function NoMultiChk(chk){ // 결제수단 중복체크 불가
	    var obj = document.getElementsByName("payMethod");
	    for(var i=0; i < obj.length; i++){
	        if(obj[i] != chk){
	            obj[i].checked = false;
	        }
	    }
	}
	
	// 결제 API (아임포트) 구현
	IMP.init("imp56648633"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.	
	
	function requestPay() {
				var payMethod=$("input:checkbox[name='payMethod']:checked").val();
				
		      // IMP.request_pay(param, callback) 호출
		      IMP.request_pay({ // param
		          pg: "html5_inicis",
		          pay_method:payMethod,
		          merchant_uid: "ORD20180131-0000011", // 상품 번호
		          name: <%=movie.getCinema_name()%>, // 상품명
		          amount: payPrice.value, // 상품가격
		          buyer_email: "gildong@gmail.com",
		          buyer_name: "홍길동",
		          buyer_tel: "010-4242-4242",
		          buyer_addr: "서울특별시 강남구 신사동",
		          buyer_postcode: "01181"
		      }, function (rsp) { // callback
		    	  if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
		    	      // jQuery로 HTTP 요청
		    	      jQuery.ajax({
		    	          url: "https://www.myservice.com/payments/complete", // 가맹점 서버
		    	          method: "POST",
		    	          headers: { "Content-Type": "application/json" },
		    	          data: {
		    	              imp_uid: rsp.imp_uid,
		    	              merchant_uid: rsp.merchant_uid
		    	          }
		    	      }).done(function (data) {
		    	        // 가맹점 서버 결제 API 성공시 로직
		    	      })
		    	    } else {
		    	      alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
		    	    }
		      });
	}
	 
	$(document).ready(function(){
		
		$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');
	
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
	
			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
		})
	
	});
	
	
</script>

<body>
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>

<section id="moviePayBox">
	<div class="container">
		<h2>결제</h2>
		<form action="PayPro.re" name="selectSeat" method="post" id="payForm">
			<%
				for(String seat : seatArr){
					%><input type="hidden" value="<%=seat%>" ><%
				}
			%><!-- 좌석값 받아오기  -->
			<input type="hidden" id="coupon_1000" name="coupon_1000" value="<%=coupon1000%>"><!-- 쿠폰 수량 가져오기 -->
			<input type="hidden" id="coupon_2000" name="coupon_2000" value="<%=coupon2000%>"><!-- 쿠폰 수량 가져오기 -->
			<input type="hidden" id="coupon_3000" name="coupon_3000" value="<%=coupon3000%>"><!-- 쿠폰 수량 가져오기 -->
			
			
			<div class="leftBox">
				<div class="movieCont">
					<h3>예매정보</h3>
					<span class="movieImg"><img src="img/littlepost.jpg"></span>
					<div class="movieInfo">			
						<h4 class="movieSubject"><%=movie.getMovie_subject() %></h4>
						<dl>
							<dt>일시</dt>
							<dd><%=movie.getShowdate() %>&nbsp; <%=movie.getShowtime()%></dd>
						</dl>
						<dl>
							<dt>영화관</dt>
							<dd><%=movie.getCinema_name() %>점</dd>
						</dl>	
						<dl>
							<dt>인원</dt>
							<dd>성인 : <%=adultnum %>명, &nbsp; 청소년 및 아동 : <%=kidsnum %>명</dd>
						</dl>
						<dl>
							<dt>좌석</dt>
							<dd><%
										for(String seat : seatArr){
											%><span class="selectedSeat"><%=seat%></span><%
										}
									%>
							</dd>
						</dl>
					</div><!-- .movieInfo -->
				</div><!-- .movieCont  -->
				
				<div class="couponCont">
					<h3>관람권/할인권 선택</h3>
					<ul class="tabs">
						<li data-tab="tab-1">
							관람권
						</li>
						<li data-tab="tab-2">
							할인권
						</li>
					</ul>
					<div class="tab-box">
						<div id="tab-1" class="tab-content">
							<dl >
								<dt>보유한 관람권</dt>
								<select id="movieTicket">
									<option value="">관람권 갯수 선택</option>
									<%
										for(int i = 0; i < membership; i++){
											%>
												<option><%=i%></option>
											<%
										}
									%>
								</select>
							</dl>
						</div>
						<div id="tab-2" class="tab-content">							
							<dl>
								<dt>보유한 할인권</dt>
								<dd>
									<select id="coupon_select" onchange="changeCoupon(this.value)">
										<option value="" >할인권 선택</option>
										<option value="coupon_1000" class="c1000">1000원 할인권(<%=coupon1000%>개)</option>
										<option value="coupon_2000" class="c2000">2000원 할인권(<%=coupon2000 %>개)</option>
										<option value="coupon_3000" class="c3000">3000원 할인권(<%=coupon3000 %>개)</option>
									</select>
								</dd>
							</dl>
							<dl>
								<dt>적용된 할인권</dt>
								<dd><input type="text" id="useCoupon" name="" value="" readonly><!-- 사용되는 쿠폰 --></dd>
							</dl>						
						</div>
						
						
					</div><!-- .tab-box -->
					
				</div><!-- .couponCont -->
				
				<div class="selectPayment">
					<h3>결제수단</h3>
					<ul>
						<li>
							<input type="checkbox" name="payMethod" value="card" id="card" onclick="NoMultiChk(this)">
							<label for="card"><span>신용카드</span></label>
						</li>
						<li>
							<input type="checkbox" name="payMethod" value="trans" id="trans" onclick="NoMultiChk(this)">
							<label for="trans"><span>계좌이체</span></label>
						</li>
						<li>
							<input type="checkbox" name="payMethod" value="phone" id="phone" onclick="NoMultiChk(this)">
							<label for="phone"><span>휴대폰</span></label>
						</li>
					</ul>
				</div>
			</div><!-- .leftBox -->
			
			<div class="rightBox">
				<table>
					<tr>
						<th>결제정보</th>
					</tr>
					<tr>
						<td>
							<p>성인 × <%=adultnum %>명 = <%=adultnum*10000 %>원</p>
							<p>청소년 및 아동 × <%=kidsnum %>명 = <%=kidsnum*6000 %>원</p>
						</td>
					</tr>
					<tr>
						<td>
							<dl>
								<dt>상품금액</dt>
								<dd><input type="text" value="" name="originPrice" id="originPrice" readonly>원</dd>
							</dl>
						</td>
					</tr>
					<tr>
						<td>
							<dl>
								<dt>할인금액</dt>
								<dd><input type="text" value="-0" name="salePrice" id="salePrice" readonly>원</dd>
							</dl>
						</td>
					</tr>
					<tr>
						<td>
							<dl>
								<dt>결제금액</dt>
								<dd><input type="text" value="" name="payPrice" id="payPrice" readonly>원</dd>
							</dl>
						</td>					
					</tr>
					<tr>
						<td>
							<input type="button" value="결제하기" id="payButton" onclick="requestPay()">
						</td>
					</tr>
				</table>
			
			</div><!-- .rightBox -->
			
		</form>
	</div><!-- .container -->
</section><!-- #moviePayForm -->

  
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

<!-- jquery plugins here-->
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