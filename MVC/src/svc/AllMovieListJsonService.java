package svc;

import java.sql.Connection;

import org.json.simple.JSONArray;

import dao.ReserveDAO;
import static db.JdbcUtil.*;

public class AllMovieListJsonService {

	public JSONArray getAllMovieListJson() {
		
		JSONArray allMovieList = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		allMovieList = reserveDAO.getAllMovieList();
		
		close(con);
		
		return allMovieList;
		
	}

}
