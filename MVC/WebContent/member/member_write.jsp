<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
    <!-- 우편번호 검색   -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function execPostCode() {
			new daum.Postcode({
				oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	            }
		    }).open();
		}
	</script>
	
</head>

<body>
    <!--::header part start::-->
    <jsp:include page="/inc/top.jsp"/>
    <!-- Header part end-->


    <!-- breadcrumb start-->
<!--     <section class="breadcrumb breadcrumb_bg"> -->
<!--     	<div class="container"> -->
<!--             <div class="row justify-content-center"> -->
<!--                 <div class="col-lg-8"> -->
<!--                     <div class="breadcrumb_iner"> -->
<!--                         <div class="breadcrumb_iner_item"> -->
<!--                             <h2>Tracking Order</h2> -->
<!--                             <p>Home <span>-</span> Tracking Order</p> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </section> -->
    <!-- breadcrumb start-->

    <!--================main_part Area =================-->
    <section class="login_part padding_top">
	    <form action="MemberWritePro.me" id="join" method="post" name="fr">
			<fieldset>
				<legend>필수 항목</legend>
				<label>아이디</label> <input type="text" name="id" class="id" id="myId" required="required" placeholder="6~10자 영문과 숫자 조합" min="6">
				<input type="button" value="ID확인" class="dup" id="chkId"><span id="reId"></span><br>
				<label>비밀번호</label> <input type="password" name="pass" id="pass" required="required" placeholder="8~12자 영문,숫자,특수문자" min="8"><br>
				<label>비밀번호 재확인</label> <input type="password" name="rePass" id="rePass" required="required" onblur="chkPass()"><span id="chkPass"></span><br><br>
				<label>이름</label> <input type="text" name="name" id="name" required="required"><br>
				<label>전화번호</label> <input type="text" name="phone" required="required"><br>
				<label>이메일</label> <input type="email" name="email" id="email" required="required"><br>
				<label>이메일 재확인</label> <input type="email" name="reEmail" id="reEmail" required="required"><br>
				<label>성별</label> <input type="radio" name="gender" value="male" id="male" required="required">남 <input type="radio" name="gender" value="female" id="female">여<br>
				<label>생년월일</label> <input type="date" name="birthday" id="birthday" required="required" placeholder="2000-12-20"><br>
			</fieldset>
	
			<fieldset>
				<legend>선택 항목</legend>
				<label>주소</label> <input type="text" name="postcode" id="postcode" class="id" placeholder="우편번호"> <input type="button" value="우편번호검색" class="dup" onclick="execPostCode()"><br>
				<label></label> <input type="text" name="address" id="address" placeholder="주소" size="46"><br>
				<label></label> <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"> <input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목"><br>
			</fieldset>
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="가입하기" class="submit">
				<input type="reset" value="취소" class="cancel">
			</div>
		</form>
    </section>
    <!--================main_part end =================-->

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