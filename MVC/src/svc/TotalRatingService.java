package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.MovDAO;

public class TotalRatingService {

	public float insertTotalRating(int movieCd) {
		System.out.println("TotalRatingService - insertTotalRating()");
		
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		float sumCmgrade = movDAO.selectCmgrade(movieCd);
		
		close(con);
		
		return sumCmgrade;
	}

}
