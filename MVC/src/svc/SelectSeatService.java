package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ReserveDAO;
import vo.ReserveBean;
import static db.JdbcUtil.*;

public class SelectSeatService {

	public ArrayList<ReserveBean> getSeatList(int movienum) throws Exception {
		ArrayList<ReserveBean> seatList = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		seatList = reserveDAO.getSeatList(movienum);
		
		close(con);
		
		return seatList;
	}

	

}
