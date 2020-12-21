package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.MovDAO;
import vo.MovBean;

public class AdminMovWriteProService {

	public boolean registArticle(MovBean movBean) {
		System.out.println("AdminMovWriteProService - registArticle()");
		boolean isWriteSuccess = false;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		int insertCount = movDAO.insertArticle(movBean);
		
		if (insertCount > 0) {
			commit(con); // DB 커밋 작업 수행
			isWriteSuccess = true; // 리턴할 작업 수행 결과를 true 로 설정
			
		} else {
			rollback(con);
			
		}
		
		close(con);
		
		return isWriteSuccess;
	}

}
