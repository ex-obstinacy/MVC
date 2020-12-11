package svc;

import vo.ReserveBean;
import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;

public class PayProService {

	public boolean reserveMovie(ReserveBean reservation) {
		System.out.println("PayProService - reserveMovie() !");
		boolean isReserveSuccess = false;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		int reserveCount = reserveDAO.reserveMovie(reservation);
		
		if(reserveCount > 0) {
			commit(con);
			isReserveSuccess = true;
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isReserveSuccess;
	}

	public String getTicketNum(ReserveBean reservation) {
		String ticketnum = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		ticketnum = reserveDAO.getTicketNum(reservation);
		
		close(con);
		
		return ticketnum;
	}

	

	





	

	

}
