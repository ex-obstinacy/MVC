package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import dao.MemberDAO;
import vo.MemberBean;

public class MemberInfoService {

	public MemberBean getArticle(String id) {
		System.out.println("MemberInfoService - getArticle()");
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		MemberBean article = memberDAO.selectArticle(id);
		
		close(con);
		
		return article;
	}

}
