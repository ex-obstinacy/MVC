package svc;

import java.sql.Connection;

import dao.StoreDAO;
import vo.StoreBean;

//import db.JdbcUtil;
import static db.JdbcUtil.*;

public class GoodsDetailService {
	
	// 게시물 1개에 대한 상세 내용을 요청하는 getArticle() 메서드 정의
	public StoreBean getArticle(int goodsId) throws Exception{
		System.out.println("GoodsDetailService - getArticle");
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		// 2(공통). StoreDAO 객체 가져오기
		StoreDAO storeDAO = StoreDAO.getInstance();
		// 3(공통). StoreDAO 객체에 Connection 객체 전달
		storeDAO.setConnection(con);
		// 4. storeDAO 객체의 selectArticle() 메서드를 호출하여
		//    게시물 1개 상세내용 조회 결과를 StoreBean 객체로 리턴받기
		//    => 파라미터 : 글번호(goodsId), 리턴타입 : StoreBean
		StoreBean article = storeDAO.selectArticle(goodsId);
		
		System.out.println("글제목 : " + article.getName());
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		//6.
		return article;
	}
	
}
