<%@page import="store.StoreDAO"%>
<%@page import="store.StoreBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
 String uploadPath = request.getRealPath("/upload"); //goods 파일(물리적)업로드 경로
 System.out.println(uploadPath); //업로드 경로 Console창 출력
 
	//파일크기 제한 10MB
	int maxSize = 10*1024*1024;
	//한글처리 "utf-8"
	//동일파일이름은 자동으로 다른이름으로 처리 new DefaultFileRenamePolicy()
	MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	
	String ctg = multi.getParameter("ctg");
	String name = multi.getParameter("name");
	int price = Integer.parseInt(multi.getParameter("price"));
	int sale = Integer.parseInt(multi.getParameter("sale"));
	int stockcount = Integer.parseInt(multi.getParameter("stockcount"));
	int sellcount = Integer.parseInt(multi.getParameter("sellcount"));
	String component = multi.getParameter("component");
	String img = multi.getFilesystemName("img");
	String content = multi.getParameter("content");
	Timestamp date = new Timestamp(System.currentTimeMillis());
	
	//StoreBean sb 객체생성
	StoreBean sb = new StoreBean();
	
	//sb에 set메서드 호출 <= 파라미터값 저장
	sb.setCtg(ctg);
	sb.setName(name);
	sb.setPrice(price);
	sb.setSale(sale);
	sb.setStockcount(stockcount);
	sb.setSellcount(sellcount);
	sb.setComponent(component);
	sb.setImg(img);
	sb.setContent(content);
	sb.setDate(date);
	
	//StoreDAO sdao 객체생성
	StoreDAO sdao = new StoreDAO();
	//inserStore(sb) 메서드호출
	sdao.insertGoods(sb);

%>

	<script type="text/javascript">
	alert("상품등록 완료");
// 	location.href=".jsp";
	</script>
	
</body>
</html>