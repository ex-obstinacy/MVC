package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;
import vo.ReserveBean;

public class CinemaAddProService {

	// 영화관 등록 요청 처리를 위한 registArticle() 메서드
	public boolean registArticle(ReserveBean reserveBean) {
		
		boolean isAddSuccess = false;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		int addCount = reserveDAO.addCinema(reserveBean);
		
		if(addCount > 0) {
			commit(con);
			isAddSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isAddSuccess;
		
	}
	
}
