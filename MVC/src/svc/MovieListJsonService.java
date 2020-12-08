package svc;

import org.json.simple.JSONArray;

import dao.ReserveDAO;

import static db.JdbcUtil.*;

import java.sql.Connection;

public class MovieListJsonService {

	public JSONArray getMovieListJson() {
		
		JSONArray movieList = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		movieList = reserveDAO.getMovieList();
		
		close(con);
		
		return movieList;
		
	}

}
