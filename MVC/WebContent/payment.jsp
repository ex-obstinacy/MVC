<%@page import="vo.StoreBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
StoreBean article = (StoreBean)request.getAttribute("article");

// int sale = (int)(article.getPrice() * article.getSale() * 0.01); //세일가 = 원가 * (세일 * 0.01) -> %로 나타낸거임
// int sumPrice = article.getPrice() - sale; // 할인 후 적용가 = 원가 - 세일가

//수정해야됨
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-3.5.1.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
<input type ="hidden" id="name" name="name" value ="<%=article.getName() %>" >
<%-- <input type ="hidden" id=sumPrice name="sumPrice" value ="<%=sumPrice %>" > --%>
<script>
	var name = document.getElementByName("name");
// 	var sumPrice = document.getElementByName("sumPrice");

var IMP = window.IMP;
IMP.init('imp14042333');
IMP.request_pay({
    pg : 'html5_inicis',
    pay_method : 'card',
    merchant_uid : 'merchant_' + new Date().getTime(),
    name : name, //상품명
    amount : sumPrice, /* 결제금액 */
    buyer_email : 'iamport@siot.do', /* 멤버빈 받아와서 할것 */
    buyer_name : '구매자이름', /* 멤버빈 받아와서 할것 */
    buyer_tel : '010-1234-5678', /* 멤버빈 받아와서 할것 */
}, function(rsp) {
    if ( rsp.success ) {
        var msg = '결제가 완료되었습니다.';
        msg += '고유ID : ' + rsp.imp_uid;
        msg += '상점 거래ID : ' + rsp.merchant_uid;
        msg += '결제 금액 : ' + rsp.paid_amount;
        msg += '카드 승인번호 : ' + rsp.apply_num;
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
    }

    alert(msg);
});
</script>
  </body>
</html>
