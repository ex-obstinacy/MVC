package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import dao.MovDAO;
import vo.MovBean;

public class AdminMovInfoService {

	public MovBean getArticle(String movieCd) {
		System.out.println("AdminMovInfoService - getArticle()");
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		MovBean article = movDAO.selectArticle(movieCd);
		
		close(con);
		
		return article;
	}

}
