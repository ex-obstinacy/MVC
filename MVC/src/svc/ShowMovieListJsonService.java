package svc;

import org.json.simple.JSONArray;

import dao.ReserveDAO;

import static db.JdbcUtil.*;

import java.sql.Connection;

public class ShowMovieListJsonService {

	public JSONArray getShowMovieListJson() {
		
		JSONArray showMovieList = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		showMovieList = reserveDAO.getShowMovieList();
		
		close(con);
		
		return showMovieList;
		
	}

}
