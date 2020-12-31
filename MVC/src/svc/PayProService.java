package svc;

import vo.MovBean;
import vo.ReserveBean;
import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;

public class PayProService {

	public boolean reserveMovie(ReserveBean reservation, int payPrice) {
		System.out.println("PayProService - reserveMovie() !");
		boolean isReserveSuccess = false;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		int reserveCount = reserveDAO.reserveMovie(reservation, payPrice);
		
		if(reserveCount > 0) {
			commit(con);
			isReserveSuccess = true;
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isReserveSuccess;
	}


}
