package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import dao.MemberDAO;
import vo.MemberBean;

public class MemberUpdateProService {

	public boolean updateMember(MemberBean memberBean) {
		System.out.println("MemberUpdateProService - updateMember()");
		
		boolean isUpdateSuccess = false;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		int updateCount = memberDAO.updateMember(memberBean);
		
		if (updateCount > 0) {
			commit(con);
			isUpdateSuccess = true;
			
		} else {
			rollback(con);
			
		}
		
		return isUpdateSuccess;
	}

}
