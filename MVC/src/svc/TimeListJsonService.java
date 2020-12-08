package svc;

import java.sql.Connection;

import org.json.simple.JSONArray;

import dao.ReserveDAO;
import static db.JdbcUtil.*;

public class TimeListJsonService {

	public JSONArray getTimeListJson() {
		
		JSONArray timeList = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		timeList = reserveDAO.getTimeList();
		
		close(con);
		
		return timeList;
		
	}

}
