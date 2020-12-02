package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;

public class CinemaDeleteProService {

	public boolean removeCinema(String cinema_name) {
		
		boolean isDeleteSuccess = false;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		int deleteCount = reserveDAO.deleteCinema(cinema_name);
		if(deleteCount > 0) {
			// 삭제성공
			commit(con);
			isDeleteSuccess = true;
		} else {
			// 삭제실패
			rollback(con);
		}
		
		close(con);
		
		return isDeleteSuccess;
		
	}

}
