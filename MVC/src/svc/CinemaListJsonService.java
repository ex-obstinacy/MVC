package svc;

import java.sql.Connection;

import org.json.simple.JSONArray;

import dao.ReserveDAO;

import static db.JdbcUtil.*;

public class CinemaListJsonService {

	public JSONArray getCinemaListJson() {
		
		JSONArray cinemaList = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		cinemaList = reserveDAO.getCinemaList();
		
		close(con);
		
		return cinemaList;
		
	}

}
