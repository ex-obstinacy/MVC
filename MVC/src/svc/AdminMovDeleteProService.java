package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import dao.MovDAO;

public class AdminMovDeleteProService {

	public boolean isDeleteMember(String movieCd) {
		System.out.println("AdminMovDeleteProService - isDeleteMember()");
		
		boolean isDeleteSuccess = false;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		// 회원 삭제 DAO 구문
		int deleteCount = movDAO.deleteMov(movieCd);
		
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
