package svc;

import vo.ReserveBean;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;

public class MovieAddProService {
	
	// 영화 코드로 영화 제목 가져오기
	public String getMovieSubject(int movie_code) {
		
		String movie_subject = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		String subject = reserveDAO.getMovieSubject(movie_code);
		
		if(subject != null) {
			movie_subject = subject;
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return movie_subject;
	}
	
	// 영화 코드로 연령제한 가져오기
	public String getMovieGrade(int movie_code) {
		String movie_grade = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		String grade = reserveDAO.getMovieGrade(movie_code);
		
		if(grade != null) {
			movie_grade = grade;
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return movie_grade;
	}

	// 영화 등록하기
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
