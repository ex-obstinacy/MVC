package svc;

import vo.ReserveBean;

import java.sql.Connection;

import dao.ReserveDAO;

import static db.JdbcUtil.*;

public class ReserveResultService {

	public ReserveBean getReserveInfo(String ticketnum) {
		ReserveBean reserveInfo = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		reserveInfo = reserveDAO.getReserveInfo(ticketnum);
		
		close(con);
		
		return reserveInfo;
	}

}
