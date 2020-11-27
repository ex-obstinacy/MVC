<%@page import="vo.ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// int movienum = Integer.parseInt(request.getParameter("movienum")); 영화번호 전달
ArrayList<ReserveBean> seatList = (ArrayList<ReserveBean>)request.getAttribute("seatList");

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
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	window.onload = function(){	
		document.getElementById("seatForm").reset();
	}
	
	window.onpageshow = function (event) {
		document.getElementById("seatForm").reset();
	}
	
	
	// 어른 수 빼기
	function adultMinus(){
		var selectCount = $("input:checkbox[name=seat]:checked").length;
				
		document.getElementById("adultvalue").value = parseInt(document.getElementById("adultvalue").value) - 1;
		document.getElementById("peopleNum").value = parseInt(document.getElementById("peopleNum").value) - 1;
		
		if(document.getElementById("adultvalue").value < 0){
			document.getElementById("adultvalue").value = 0;
			document.getElementById("peopleNum").value = parseInt(document.getElementById("peopleNum").value) + 1;
		}
		
		if(document.getElementById("peopleNum").value < 0){
			document.getElementById("peopleNum").value = 0;
		}
		
		if(document.getElementById("peopleNum").value < selectCount){
			alert("현재 선택한 좌석보다 인원이 적습니다.")
			document.getElementById("adultvalue").value = parseInt(document.getElementById("adultvalue").value) + 1;
			document.getElementById("peopleNum").value = parseInt(document.getElementById("peopleNum").value) + 1;
		}
		
		if(document.getElementById("peopleNum").value <= 0){
			$(".blackBox").css("display","block");
		}
	}
	// 어른 수 더하기	
	function adultPlus(){
		document.getElementById("adultvalue").value = parseInt(document.getElementById("adultvalue").value) + 1;
		document.getElementById("peopleNum").value = parseInt(document.getElementById("peopleNum").value) + 1;
		
		if(document.getElementById("peopleNum").value >= 1){
			$(".blackBox").css("display","none");
		}
	}
	
	// 아이 수 빼기
	function kidsMinus(){
		var selectCount = $("input:checkbox[name=seat]:checked").length;
		
		document.getElementById("kidsvalue").value = parseInt(document.getElementById("kidsvalue").value) - 1;
		document.getElementById("peopleNum").value = parseInt(document.getElementById("peopleNum").value) - 1;
		
		if(document.getElementById("kidsvalue").value < 0){
			document.getElementById("kidsvalue").value = 0;
			document.getElementById("peopleNum").value = parseInt(document.getElementById("peopleNum").value) + 1;
		}
		
		if(document.getElementById("peopleNum").value < 0){
			document.getElementById("peopleNum").value = 0;
		}
		
		if(document.getElementById("peopleNum").value < selectCount){
			alert("현재 선택한 좌석보다 인원이 적습니다.")
			document.getElementById("kidsvalue").value = parseInt(document.getElementById("kidsvalue").value) + 1;
			document.getElementById("peopleNum").value = parseInt(document.getElementById("peopleNum").value) + 1;
		}
		
		if(document.getElementById("peopleNum").value <= 0){
			$(".blackBox").css("display","block");
		}
		
	}
	// 아이 수 더하기
	function kidsPlus(){
		document.getElementById("kidsvalue").value = parseInt(document.getElementById("kidsvalue").value) + 1;
		document.getElementById("peopleNum").value = parseInt(document.getElementById("peopleNum").value) + 1;
		
		if(document.getElementById("peopleNum").value >= 1){
			$(".blackBox").css("display","none");
		}
	}	
	
	// 선택한 사람 수 만큼 좌석선택 제한								
	var count = 0;		// 현재 선택된 좌석 수 저장하는 변수 count
	function CountChecked(field){ 					
		var maxCount = document.getElementById("peopleNum").value; // 사용자가 선택한 총 인원수 maxCount
		
		
		if (field.checked) {						
			count += 1;		
		}
		else {										
			count -= 1;							
		}
		
		if(maxCount == 0){
			alert("인원을 선택해주세요.")
			field.checked = false;						
			count -= 1;	
			return false;
		}
		
		if (count > maxCount) {			
			alert("좌석은 " + maxCount +"개까지만 선택가능합니다!");	
			field.checked = false;						
			count -= 1;	
		}
		
		
	}
	
	// 예약된 좌석 선택 금지시키기
	$(document).ready(function() {
			
		var seatList = new Array();
		var disableList = new Array();
		$("input[type=checkbox]").each(function(index, item){
			seatList.push($(item).val());	
		});
		
		$("input[name=disableSeat]").each(function(index, item){
			disableList.push($(item).val());
		});
				
		for(var j = 0; j < disableList.length; j++){
			for(var i = 0; i < seatList.length; i++){
				if(disableList[j] == seatList[i]){
					$("input[type=checkbox][value=" + disableList[j] + "]").attr("disabled",true);
				}
			}
		}
		
		$("label").click(function(){
			if($(this).siblings("input").attr("disabled") == "disabled"){
				alert("이미 예약된 좌석입니다.");
			}
		})
	});
	
	// 결제버튼 클릭시 인원선택 없을시 인원선택
	function peopleCheck(){
		var maxCount = document.getElementById("peopleNum").value;
		if(maxCount == 0){
			alert("인원을 먼저 선택해주세요");
			return false;
		}
		
		if(maxCount > count){
			alert("선택하신 인원수 만큼 좌석을 선택해주세요");
			return false;
		}
	}


</script>

<body>
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<%-- <jsp:include page="../inc/sub_visual.jsp"/> --%>
<div class="container">
	<form action="PayForm.re?movienum=1" name="selectSeat" method="post" id="seatForm"><!-- 영화번호 전달 -->
		<input type="hidden" name="moivenum" value="1"><!-- 영화번호 전달 -->
		<div id="peopleBoard">
			<input type="hidden" value="0" id="peopleNum" name="peopleNum"> <!-- 총 인원수(선택수 제한하는데 필요) -->
			<h2>인원/좌석 선택</h2>
			<div class="adultNum">				
				<h3>성인</h3>
				<div class="numBox">
					<button class="peopleIcon lbtn" type="button" onclick="adultMinus()">-</button>
					<input type="text" name="adultNum" value="0" id="adultvalue" readonly>
					<button class="peopleIcon rbtn" type="button" onclick="adultPlus()">+</button>
				</div>		
			</div><!-- .adultNum -->
			
			<div class="kidsNum">
				<h3>청소년, 아동</h3>
				<div class="numBox">
					<button class="peopleIcon lbtn" type="button" onclick="kidsMinus()">-</button>
					<input type="text" name="kidsNum" value="0" id="kidsvalue" readonly>
					<button class="peopleIcon rbtn" type="button" onclick="kidsPlus()">+</button>
				</div>		
			</div><!-- .kidsNum -->
			
			<p class="cautionMsg">관람인원을 먼저 선택하고, 좌석을 선택해주세요.</p>	
		</div><!-- #peopleBoard -->
		
		<div id="seatBox">	
			<div class="blackBox"></div>
			<!-- 예약된좌석 input hidden으로 가져오기 -->
			<div class="disableBox">
				<%
					for(int i=0; i < seatList.size(); i++){
						%>							
							<input type="hidden" name="disableSeat" value="<%=seatList.get(i).getSeatnum() %>" >
						<%
					}
				%>
			</div><!-- .disableBox -->
			
			
			
			<div class="screenBox">SCREEN</div><!-- .screenBox -->
			
			<section id="seatSec1">
				<table>
					<tr>
						<td><input type="checkbox" name="seat" value="A01" id="A01" onclick="CountChecked(this)"><label for="A01">A01</label></td>
						<td><input type="checkbox" name="seat" value="A02" id="A02" onclick="CountChecked(this)"><label for="A02">A02</label></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="seat" value="B01" id="B01" onclick="CountChecked(this)"><label for="B01">B01</label></td>
						<td><input type="checkbox" name="seat" value="B02" id="B02" onclick="CountChecked(this)"><label for="B02">B02</label></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="seat" value="C01" id="C01" onclick="CountChecked(this)"><label for="C01">C01</label></td>
						<td><input type="checkbox" name="seat" value="C02" id="C02" onclick="CountChecked(this)"><label for="C02">C02</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="D01" id="D01" onclick="CountChecked(this)"><label for="D01">D01</label></td>
						<td><input type="checkbox"name="seat" value="D02" id="D02" onclick="CountChecked(this)"><label for="D02">D02</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="E01" id="E01" onclick="CountChecked(this)"><label for="E01">E01</label></td>
						<td><input type="checkbox"name="seat" value="E02" id="E02"onclick="CountChecked(this)"><label for="E02">E02</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="F01" id="F01"onclick="CountChecked(this)"><label for="F01">F01</label></td>
						<td><input type="checkbox"name="seat" value="F02" id="F02"onclick="CountChecked(this)"><label for="F02">F02</label></td>
					</tr>
				</table>
			</section>
			
			<section id="seatSec2">
				<table>
					<tr>
						<td><input type="checkbox"name="seat" value="A03" id="A03" onclick="CountChecked(this)"><label for="A03">A03</label></td>
						<td><input type="checkbox"name="seat" value="A04" id="A04" onclick="CountChecked(this)"><label for="A04">A04</label></td>
						<td><input type="checkbox"name="seat" value="A05" id="A05" onclick="CountChecked(this)"><label for="A05">A05</label></td>
						<td><input type="checkbox"name="seat" value="A06" id="A06" onclick="CountChecked(this)"><label for="A06">A06</label></td>
						<td><input type="checkbox"name="seat" value="A07" id="A07" onclick="CountChecked(this)"><label for="A07">A07</label></td>
						<td><input type="checkbox"name="seat" value="A08" id="A08" onclick="CountChecked(this)"><label for="A08">A08</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="B03" id="B03" onclick="CountChecked(this)"><label for="B03">B03</label></td>
						<td><input type="checkbox"name="seat" value="B04" id="B04" onclick="CountChecked(this)"><label for="B04">B04</label></td>
						<td><input type="checkbox"name="seat" value="B05" id="B05" onclick="CountChecked(this)"><label for="B05">B05</label></td>
						<td><input type="checkbox"name="seat" value="B06" id="B06" onclick="CountChecked(this)"><label for="B06">B06</label></td>
						<td><input type="checkbox"name="seat" value="B07" id="B07" onclick="CountChecked(this)"><label for="B07">B07</label></td>
						<td><input type="checkbox"name="seat" value="B08" id="B08" onclick="CountChecked(this)"><label for="B08">B08</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="C03" id="C03" onclick="CountChecked(this)"><label for="C03">C03</label></td>
						<td><input type="checkbox"name="seat" value="C04" id="C04" onclick="CountChecked(this)"><label for="C04">C04</label></td>
						<td><input type="checkbox"name="seat" value="C05" id="C05" onclick="CountChecked(this)"><label for="C05">C05</label></td>
						<td><input type="checkbox"name="seat" value="C06" id="C06" onclick="CountChecked(this)"><label for="C06">C06</label></td>
						<td><input type="checkbox"name="seat" value="C07" id="C07" onclick="CountChecked(this)"><label for="C07">C07</label></td>
						<td><input type="checkbox"name="seat" value="C08" id="C08" onclick="CountChecked(this)"><label for="C08">C08</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="D03" id="D03" onclick="CountChecked(this)"><label for="D03">D03</label></td>
						<td><input type="checkbox"name="seat" value="D04" id="D04" onclick="CountChecked(this)"><label for="D04">D04</label></td>
						<td><input type="checkbox"name="seat" value="D05" id="D05" onclick="CountChecked(this)"><label for="D05">D05</label></td>
						<td><input type="checkbox"name="seat" value="D06" id="D06" onclick="CountChecked(this)"><label for="D06">D06</label></td>
						<td><input type="checkbox"name="seat" value="D07" id="D07" onclick="CountChecked(this)"><label for="D07">D07</label></td>
						<td><input type="checkbox"name="seat" value="D08" id="D08" onclick="CountChecked(this)"><label for="D08">D08</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="E03" id="E03" onclick="CountChecked(this)"><label for="E03">E03</label></td>
						<td><input type="checkbox"name="seat" value="E04" id="E04" onclick="CountChecked(this)"><label for="E04">E04</label></td>
						<td><input type="checkbox"name="seat" value="E05" id="E05" onclick="CountChecked(this)"><label for="E05">E05</label></td>
						<td><input type="checkbox"name="seat" value="E06" id="E06" onclick="CountChecked(this)"><label for="E06">E06</label></td>
						<td><input type="checkbox"name="seat" value="E07" id="E07" onclick="CountChecked(this)"><label for="E07">E07</label></td>
						<td><input type="checkbox"name="seat" value="E08" id="E08" onclick="CountChecked(this)"><label for="E08">E08</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="F03" id="F03" onclick="CountChecked(this)"><label for="F03">F03</label></td>
						<td><input type="checkbox"name="seat" value="F04" id="F04" onclick="CountChecked(this)"><label for="F04">F04</label></td>
						<td><input type="checkbox"name="seat" value="F05" id="F05" onclick="CountChecked(this)"><label for="F05">F05</label></td>
						<td><input type="checkbox"name="seat" value="F06" id="F06" onclick="CountChecked(this)"><label for="F06">F06</label></td>
						<td><input type="checkbox"name="seat" value="F07" id="F07" onclick="CountChecked(this)"><label for="F07">F07</label></td>
						<td><input type="checkbox"name="seat" value="F08" id="F08" onclick="CountChecked(this)"><label for="F08">F08</label></td>
					</tr>
				</table>
			</section>
			
			<section id="seatSec3">
				<table>
					<tr>
						<td><input type="checkbox"name="seat" value="A09" id="A09" onclick="CountChecked(this)"><label for="A09">A09</label></td>
						<td><input type="checkbox"name="seat" value="A10" id="A10" onclick="CountChecked(this)"><label for="A10">A10</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="B09" id="B09" onclick="CountChecked(this)"><label for="B09">B09</label></td>
						<td><input type="checkbox"name="seat" value="B10" id="B10" onclick="CountChecked(this)"><label for="B10">B10</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="C09" id="C09" onclick="CountChecked(this)"><label for="C09">C09</label></td>
						<td><input type="checkbox"name="seat" value="C10" id="C10" onclick="CountChecked(this)"><label for="C10">C10</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="D09" id="D09" onclick="CountChecked(this)"><label for="D09">D09</label></td>
						<td><input type="checkbox"name="seat" value="D10" id="D10" onclick="CountChecked(this)"><label for="D10">D10</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="E09" id="E09" onclick="CountChecked(this)"><label for="E09">E09</label></td>
						<td><input type="checkbox"name="seat" value="E10" id="E10" onclick="CountChecked(this)"><label for="E10">E10</label></td>
					</tr>
					<tr>
						<td><input type="checkbox"name="seat" value="F09" id="F09" onclick="CountChecked(this)"><label for="F09">F09</label></td>
						<td><input type="checkbox"name="seat" value="F10" id="F10" onclick="CountChecked(this)"><label for="F10">F10</label></td>
					</tr>
				</table>
			</section>
			<ul class="seatInfo">
				<li>
					<span></span>
					<p>예매 완료</p>
				</li>
				<li>
					<span></span>
					<p>선택 좌석</p>
				</li>
				<li>
					<span></span>
					<p>선택가능</p>
				</li>
			</ul><!-- .seatInfo -->
			
			<div class="btnBox">
				<input type="reset" value="다시 선택하기" class="btn_cancel">
				<input type="submit" value="결제하기" onclick="return peopleCheck()" class="btn_submit">
			</div><!-- .btnBox -->
		</div><!-- #seatBox -->
		
		
	</form>
</div><!-- .container -->

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