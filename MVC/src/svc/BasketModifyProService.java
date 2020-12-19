package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoreDAO;
import vo.StoreBean;

public class BasketModifyProService {
	
	public boolean modifyBasketCount(int basketCount, int basketId) throws Exception {
		boolean isModifySuccess = true;
		
		System.out.println("check! BasketModifyProService - modifyBasketCount()");
		
		//1.(공통). Connection 객체 가져오기
		Connection con = getConnection();
				
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		StoreDAO storeDAO = StoreDAO.getInstance();
								
		// 3(공통). 가져온 Connection 객체를 DAO 객체에 전달하기
		storeDAO.setConnection(con);
				
		// 4. StoreDAO 클래스의 updateBasketCount() 메서드를 호출하여 상품 수량 변경
//		int updateCount = storeDAO.updateBasketCount(basketCount, goodsId, id);
		int updateCount = storeDAO.updateBasketCount(basketCount, basketId);
				
		// 5. 글 수정 결과에 대한 판별 작업 수행
		// => updateCount 가 0보다 크면 commit 수행, isModifySuccess 를 true 변경
		// => 아니면 rollback 수행
		if (updateCount > 0) {
			commit(con);
			isModifySuccess = true;
		} else {
			rollback(con);
		}
				
		// 6(공통). Connection 객체 반환하기
		close(con);
				
		// 7. 결과 리턴
		return isModifySuccess;
	}
	
}
