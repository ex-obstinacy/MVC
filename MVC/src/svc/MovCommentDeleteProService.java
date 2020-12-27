package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.MovDAO;

public class MovCommentDeleteProService {

	public boolean isDeleteMovComment(int num) {
		System.out.println("MovCommentDeleteProService - isDeleteMember()");
		
		boolean isDeleteSuccess = false;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		// 회원 삭제 DAO 구문
		int deleteCount = movDAO.deleteMovComment(num);
		
		// 삭제 유무 확인
		if (deleteCount > 0) {
			isDeleteSuccess = true;
			commit(con);
			
		} else {
			rollback(con);
			
		}
		
		close(con);
		
		return isDeleteSuccess;
		
	}

}
