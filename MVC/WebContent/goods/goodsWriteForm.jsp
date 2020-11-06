<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodsWriteForm</title>
</head>
<body>

<script type="text/javascript">
function ck() {
	if(document.fr.ctg.options[0].selected == true){
		 //document.ctg.sel.selectedIndex == 0
		 alert("카테고리 목록을 선택하세요")
		 document.fr.ctg.focus();
		 return;
	 }
	document.fr.submit()
}

</script>
<%
		//세션값 가져오기
// 		String id = (String)session.getAttribute("id");
// 		if(id==null){
// 			id="";
// 			}
// 		MemberDAO mdao = new MemberDAO();
// 		MemberBean mb = mdao.getMember(id);
		
		//세션값이 admin 일때만 상품등록창 보이게하기
// 		if(id.equals("admin")){
			//상품등록창 주소
// 		}
%>
<% 
//한글 처리
request.setCharacterEncoding("utf-8"); %>

<!-- 상품 등록 -->
<article>
	<h2>상품정보 등록하기</h2>
	<form action="goodsWritePro.jsp" method="post" name="fr" onsubmit="return check()" enctype="multipart/form-data">
		<table border="1">
			<tr>
			 <td>카테고리</td>
			 <td><select name="ctg">
			 		<option value="">카테고리선택</option>
 					<option value="pack">package</option>
 					<option value="ticket">ticket</option>
  					<option value="snack">snack</option>
 				  </select></td>
			</tr>
			<tr>
			 <td>상품이름</td>
			 <td><input type="text" name="name" required></td>
			</tr>
			<tr>
			 <td>상품가격</td>
			 <td><input type="text" name="price" required></td>
			</tr>
			<tr>
			 <td>할인율</td>
			 <td><input type="text" name="sale" required></td>
			</tr>
			<tr>
			 <td>재고수량</td>
			 <td><input type="text" name="stockcount" required></td>
			</tr>
			<tr>
			 <td>판매수량</td>
			 <td><input type="text" name="sellcount" required></td>
			</tr>
			<tr>
			 <td>상품구성</td>
			 <td><input type="text" name="component" required></td>
			</tr>
			<tr>
			 <td>이미지파일</td>
			 <td><input type="file" name="img" required></td>
			</tr>
			<tr>
			 <td>상세내용</td>
			 <td><textarea name="content" rows="10" cols="20" required></textarea></td>
			</tr>
		</table>
		<input type="submit" value="상품등록">
		<input type="reset" value="취소">
	</form>
</article>
		
</body>
</html>