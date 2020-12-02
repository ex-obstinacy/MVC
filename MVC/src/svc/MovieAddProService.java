package svc;

import vo.ReserveBean;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;

public class MovieAddProService {

	public boolean addMovie(ReserveBean movie) {
		
		boolean isMovieAddSuccess = false;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		// 영화 등록 DAO
		int addCount = reserveDAO.insertMovie(movie);
		
		if(addCount > 0) {
			// 영화 등록 성공
			isMovieAddSuccess = true;
			commit(con);
		} else {
			// 영화 등록 실패
			rollback(con);
		}
		
		close(con);
		
		return isMovieAddSuccess;
	}

}
