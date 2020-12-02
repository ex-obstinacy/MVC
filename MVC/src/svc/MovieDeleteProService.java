package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;

public class MovieDeleteProService {

	public boolean removeMovie(int movie_num) {
		
		boolean isDeleteSuccess = false;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		int deleteCount = reserveDAO.deleteMovie(movie_num);
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
