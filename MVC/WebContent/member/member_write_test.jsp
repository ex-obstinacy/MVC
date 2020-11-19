<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

<!-- 아이디 유무 확인 -->
<script type="text/javascript">
// 	function chkId() {
// 		var id = document.fr.id.value;
// 		if (id == "") {
// 			alert("아이디 입력하세요");
// 			document.fr.id.focus();
// 			return;
// 		}
// 		window.open("chkId.jsp?id=" + id ,"","width = 400, height = 400");
// 	}
</script>

<!-- 비밀번호/이메일 확인 -->
<script type="text/javascript">
// 	function check() {
// 		if (document.fr.pass.value != document.fr.pass2.value) {
// 			alert("비밀번호가 불일치합니다");
// 			document.fr.pass2.focus();
// 			return false;
// 		}
// 		if (document.fr.email.value != document.fr.email2.value) {
// 			alert("이메일이 불일치합니다");
// 			document.fr.email2.focus();
// 			return false;
// 		}
		
// 	}
</script>

<script src="../script/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		// 아이디 중복 확인
		// id="myId" 가지고 dupCheck2.jsp
		// 디비연결 아이디 중복, 아이디 사용가능 출력
		// 출력결과를 받아서 div html() 넣기
		$('.dup').click(function() {
			$.ajax('dupCheck.jsp', {
				data: {
					id: $('#myId').val()
				},
				success: function(rdata) {
					$('#reId').html(rdata);
				}
			})
		});
		
		$('#rePass').keypress(function() {
			
		})
		
	});

	// 비밀번호 재확인
	function chkPass() {
			
		alert("준비");
			
		if (document.fr.pass.value != document.fr.rePass.value) {			
					
		}
			
	}
	
	
</script>


</head>
<body>
	
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
<%-- 		<jsp:include page=""></jsp:include> --%>
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 본문내용 -->
		<article>
		
			<h1>회원가입</h1>
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
					<input	type="reset" value="취소" class="cancel">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
<%-- 		<jsp:include page=""></jsp:include> --%>
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>