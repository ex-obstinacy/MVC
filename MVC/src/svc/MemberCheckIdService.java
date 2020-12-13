package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import dao.MemberDAO;

public class MemberCheckIdService {

	public boolean checkArticle(String id) {
		System.out.println("MemberCheckIdService - checkArticle()");
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		boolean chekcIdResult = memberDAO.checkArticle(id);
		
		close(con);
		
		return chekcIdResult;
	}

}
