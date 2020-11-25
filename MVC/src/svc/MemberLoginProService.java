package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import dao.MemberDAO;
import exception.LoginException;

public class MemberLoginProService {

	public boolean isLoginMember(String id, String pass) throws LoginException {
		System.out.println("MemberLoginProService! - isLoginMember()");
		
		boolean isMember = false;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		// 로그인 DAO 실행
		isMember = memberDAO.selectLoginMember(id, pass);
		
		close(con);
		
		return isMember;
	}
	

}
