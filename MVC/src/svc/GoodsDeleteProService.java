package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.StoreDAO;


public class GoodsDeleteProService {
	
	public boolean removeArticle(int goodsId) throws Exception {
		boolean isDeleteSuccess = true;
		
		System.out.println("check! GoodsDeleteProService - removeArticle()");
		
		//1.(공통). Connection 객체 가져오기
		Connection con = getConnection();
				
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		StoreDAO storeDAO = StoreDAO.getInstance();
								
		// 3(공통). 가져온 Connection 객체를 DAO 객체에 전달하기
		storeDAO.setConnection(con);
				
		// 4. StoreDAO 클래스의 deleteArticle() 메서드를 호출하여 글 수정
		//    => 파라미터 : goodsId, 리턴타입 : int(deleteCount)
		int deleteCount = storeDAO.deleteArticle(goodsId);		
				
		// 5. 글 삭제 결과에 대한 판별 작업 수행
		// => deleteCount 가 0보다 크면 commit 수행, isDeleteSuccess 를 true 변경
		// => 아니면 rollback 수행
		if (deleteCount > 0) {
			commit(con);
			isDeleteSuccess = true;
		} else {
			rollback(con);
		}
							
		// 6(공통). Connection 객체 반환하기
		close(con);
				
		// 7. 결과 리턴
		return isDeleteSuccess;
	}
}
