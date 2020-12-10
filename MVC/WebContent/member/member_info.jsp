<%@page import="vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	//session 객체에 저장된 id 값 가져와서 변수에 저장
	String id = (String)session.getAttribute("id");
 
	// MemberBean 객체 가져오기
	MemberBean article = (MemberBean)request.getAttribute("article");
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
    
    <!-- member CSS -->
    <link rel="stylesheet" href="css/member.css">
    
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
	
	<!-- 아이디/비밀번호 검사   -->
	<script type="text/javascript">
		// submit 전 최종 상태(아이디, 패스워드 규칙 일치 여부) 저장할 전역변수 설정
		var checkPasswdResult = true, retryPasswdResult = true, retryEmailResult = true; 
	
		// -------------------------------------------------------------------------------
		
		// 회원 패스워드에 대한 정규표현식(4 ~ 16자리 영문, 숫자, 특수문자 조합) 체크를 위해
		// 패스워드 폼을 전달받아 입력받은 패스워드에 대한 유효성 검사
		function checkPasswd(passwdForm) { // 파라미터 this 로 전달된 ID 입력폼을 매개변수에 저장
			var passwd = passwdForm.value; // ID 입력폼의 입력값을 가져와서 변수에 저장
			
			// 패스워드 입력 항목의 체크 결과 메세지 출력에 필요한 <div> 태그의 element 가져오기
			var element = document.getElementById('checkPasswdResult');
			
			var lengthRegex = /^[A-Za-z0-9!@#$%]{4,16}$/;
			// upperCaseRegex(대문자), lowerCaseRegex(소문자), digitRegex(숫자), 
			// specRegex(특수문자 !@#$%) 정규표현식 작성
			var upperCaseRegex = /[A-Z]/;
			var lowerCaseRegex = /[a-z]/;
			var digitRegex = /[0-9]/;
			var specRegex = /[!@#$%]/;
			
			// 길이 체크(lengthRegex)를 통과할 경우에만 각 항목에 대한 체크 실시
			if(lengthRegex.exec(passwd)) {
				// 대문자, 소문자, 숫자, 특수문자 체크하여 카운팅(복잡도 체크)
				var count = 0;
				// 각 항목별 체크 후 true 일 경우 count 1씩 증가시킴
				if(upperCaseRegex.exec(passwd)) count++;
				if(lowerCaseRegex.exec(passwd)) count++;
				if(digitRegex.exec(passwd)) count++;
				if(specRegex.exec(passwd)) count++;
				
// 				element.innerHTML = "사용 가능 " + count;
	
				// 점수(count) 에 따른 안전도 출력
				if(count == 4) {
					element.innerHTML = "사용 가능(안전)";
					checkPasswdResult = true; // 전역변수 true 로 변경
				} else if(count == 3) {
					element.innerHTML = "사용 가능(보통)";
					checkPasswdResult = true; // 전역변수 true 로 변경
				} else if(count == 2) {
					element.innerHTML = "사용 가능(위험)";
					checkPasswdResult = true; // 전역변수 true 로 변경
				} else {
					element.innerHTML = "사용 불가(두 가지 이상 조합)";
					checkPasswdResult = false; // 전역변수 false 로 변경
				}
	
			} else {
				element.innerHTML = "사용 불가";
				checkPasswdResult = false; // 전역변수 false 로 변경
			}
			
		}
		
		// 비밀번호 재확인
		function retryPasswd(retryPasswdForm) {
			var passwd = document.getElementById('chPass').value;
			var retryPasswd = retryPasswdForm.value;
			var element = document.getElementById('retryPasswdResult');
			if (passwd != retryPasswd) {
				element.innerHTML = "비밀번호가 일치하지 않습니다.";
				
			} else {
				element.innerHTML = "";
				retryPasswdResult = true;
				
			}
			
		}
		
		// 이메일 재확인
		function retryEmail(retryEmailForm) {
			var email = document.getElementById('chEmail').value;
			var retryEmail = retryEmailForm.value;
			var element = document.getElementById('retryEmailResult');
			if (email != retryEmail) {
				element.innerHTML = "이메일이 일치하지 않습니다.";
				
			} else {
				element.innerHTML = "";
				retryEmailResult = true;
				
			}
			
		}
		
		// 아이디, 패스워드 정규표현식 체크 후 정상이면 true 리턴(submit), 아니면 false 리턴
		// 비밀번호, 이메일 일치 유무 확인
		function check() {
			if (checkPasswdResult) {
				if (retryPasswdResult) {
					if (retryEmailResult) {
						return true;
							
					} else {
						alert('이메일 일치 확인 필수!');
						return false;
							
					}
						
				} else {
					alert('비밀번호 일치 확인 필수!');
					return false;
						
				}
					
			} else {
				alert('비밀번호 규칙 확인 필수!');
					return false;
					
			}
				
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
                            <h2><%=id %> 님</h2>
                            <p>반갑습니다! Welcome Back!</p>
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
                                        <a href="#">결제내역</a>
                                    </li>
                                    <li>
                                        <a href="#">장바구니</a>
                                    </li>
                                    <li>
                                        <a href="#">리뷰내역</a>
                                    </li>
                                    <li>
                                        <a href="#">1:1문의</a>
                                    </li>
                                    <li>
                                        <a href="MemberInfo.me">My 정보</a>
                                    </li>
                                    <li>
                                        <a href="MemberDelete.me">회원 탈퇴</a>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                    </div>
                </div>
          <!--================ 메뉴 영역 =================-->          
                
                <div class="col-lg-9">
                    <div class="row align-items-center latest_product_inner">
                    
                    
					    <form action="MemberUpdatePro.me" id="join" method="post" name="fr" class="container" onsubmit="return check()">
							<table>
								<tr>
									<td class=td_size>아이디</td>
									<td><%=article.getId() %></td>
								</tr>
								<tr>
									<td>비밀번호</td>
									<td><input type="password" name="pass" id="pass" required="required"></td>
								</tr>
								<tr>
									<td>변경할 비밀번호</td>
									<td><input type="password" name="chPass" id="chPass" onkeyup="checkPasswd(this)"><span id="checkPasswdResult"></span></td>
								</tr>
								<tr>
									<td>변경할 비밀번호 재확인</td>
									<td><input type="password" name="rePass" id="rePass" onkeyup="retryPasswd(this)"><span id="retryPasswdResult"></span></td>
								</tr>
								<tr>
									<td>이름</td>
									<td><%=article.getName() %></td>
								</tr>
								<tr>
									<td>전화번호</td>
									<td><input type="text" name="phone" required="required" value="<%=article.getPhone() %>" placeholder="ex.000-0000-0000"></td>
								</tr>
								<tr>
									<td>이메일</td>
									<td><input type="email" name="email" id="email" required="required" value="<%=article.getEmail() %>"></td>
								</tr>
								<tr>
									<td>변경할 이메일</td>
									<td><input type="email" name="chEmail" id="chEmail"></td>
								</tr>									
								<tr>
									<td>변경할 이메일 재확인</td>
									<td><input type="email" name="reEmail" id="reEmail" onkeyup="retryEmail(this)"><span id="retryEmailResult"></span></td>
								</tr>
								<tr>
									<td>성별</td>
									<td><input type="radio" name="gender" value="male" id="male" required="required" <% if(article.getGender().equals("male")) { %> checked="checked" <% } %>>남 
										<input type="radio" name="gender" value="female" id="female" <% if(article.getGender().equals("female")) { %> checked="checked" <% } %>>여</td>
								</tr>
								<tr>
									<td>생년월일</td>
									<td><input type="date" name="birthday" id="birthday" required="required" value="<%=article.getBirthday() %>"></td>
								</tr>
							</table>
							<table>
								<tr>
									<td rowspan="3" class=td_size>주소</td>
									<td><input type="text" name="postcode" id="postcode" class="id" placeholder="우편번호" value="<%=article.getPostcode() %>" readonly="readonly"> <input type="button" value="우편번호검색" class="genric-btn info circle" onclick="execPostCode()"></td>
								</tr>
								<tr>
									<td><input type="text" name="address" id="address" placeholder="주소" size="46" value="<%=article.getAddress() %>" readonly="readonly"></td>
								</tr>
								<tr>
									<td><input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="<%=article.getDetailAddress() %>"> <input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목" value="<%=article.getExtraAddress() %>" readonly="readonly"></td>
								</tr>
							</table>
							<div class="clear"></div>
							<div id="buttons">
								<input type="submit" value="정보수정" class="genric-btn primary circle">
								<input type="button" value="뒤로" class="genric-btn success circle" onclick="">
							</div>
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