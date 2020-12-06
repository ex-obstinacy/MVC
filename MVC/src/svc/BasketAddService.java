package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import dao.StoreDAO;
import vo.StoreBean;

public class BasketAddService {
	
	//특정 상품을 장바구니 항목으로 추가하는 메서드를 호출하는 부분.
	//상품 추가 요청을 처리하기 위해 addBasket() 메서드 정의
	// => 파라미터 : 게시물 정보(StoreBean)
	// => 리턴타입 :  boolean(isBasketAddSuccess)
	public boolean addBasket(int goodsId, String id) {
		System.out.println("BasketAddService - addBasket()");
		System.out.println("BasketAddService - id : " + id);
		//글 등록 성공 여부를 리턴받아 저장 , false는 실패! 이전 페이지로 back
		boolean isBasketAddSuccess = false;

		Connection con = getConnection();
		StoreDAO storeDAO = StoreDAO.getInstance();
		storeDAO.setConnection(con);
		
		//StoreDAO 객체의 addBasket() 메서드를 호출하여 글 등록 처리
		// => 파라미터 : StoreBean, 리턴타입 : boolean(isBasketAddSuccess)
		int addCount = storeDAO.addBasket(goodsId, id);
		
		// 리턴받은 글 등록 결과를 판별 => 0보다 클 경우 commit, 0일 경우 rollback 작업 수행
		if(addCount > 0) {
			isBasketAddSuccess = true;
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isBasketAddSuccess;
	}
	
	//장바구니 추가 될 상품 정보 얻어오는 부분
	public ArrayList<StoreBean> selectBasketList(int goodsId) {
		System.out.println("BasketAddService - getBasket()");
		ArrayList<StoreBean> basket = null;
		
		//1.(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		StoreDAO storeDAO = StoreDAO.getInstance();
				
		// 3(공통). 가져온 Connection 객체를 DAO 객체에 전달하기
		storeDAO.setConnection(con);
		
		//4. storeDAO 객체의 selectArticle() 메서드를 호출하여 상품 상세내용 가져오기
		basket = storeDAO.getBaksetList(goodsId);
		//5.(공통). 사용이 완료된 Connection 객체를 반환하기
		close(con);
		
		return basket;
	}

	

} //메인메서드
