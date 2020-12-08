package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;

public class MovieNumFindService {

	public int findMovieNum(String movie, String local, String cinema, String date, String time) {
		
		int movienum = 0;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		movienum = reserveDAO.findMovieNum(movie, local, cinema, date, time);
		
		close(con);
		
		return movienum;
	}
	
	
	
	
	

}
