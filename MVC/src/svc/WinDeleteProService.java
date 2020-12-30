package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.WinDAO;

public class WinDeleteProService {

	public boolean removeArticle(int num) {
		
		boolean isDeleteSuccess = false;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		int deleteCount = winDAO.deleteArticle(num);
		
		// 5. 글 삭제 결과에 대한 판별 작업 수행
		// => deleteCount 가 0보다 크면 commit 수행, isDeleteSuccess 를 true 변경
		// => 아니면 rollback 수행
		if(deleteCount > 0) {
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