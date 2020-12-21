package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.StoreDAO;

public class GoodsUseProService {

	public boolean UseArticle(String reserveNum) {
		boolean isUseSuccess = true;
		
		System.out.println("check! GoodsUseProService - UseArticle()");
		
		Connection con = getConnection();
		StoreDAO storeDAO = StoreDAO.getInstance();
		storeDAO.setConnection(con);

		int UseCount = storeDAO.UseArticle(reserveNum);		
				
		// 5. 글 삭제 결과에 대한 판별 작업 수행
		// => deleteCount 가 0보다 크면 commit 수행, isDeleteSuccess 를 true 변경
		// => 아니면 rollback 수행
		if (UseCount > 0) {
			commit(con);
			isUseSuccess = true;
		} else {
			rollback(con);
		}
							
		// 6(공통). Connection 객체 반환하기
		close(con);
				
		// 7. 결과 리턴
		return isUseSuccess;
	}

}
