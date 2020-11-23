package svc;

import vo.ReserveBean;
import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ReserveDAO;

public class PayFormService {

	public ReserveBean getMovie(int movienum) {
		System.out.println("PayFormService !");
		ReserveBean movie = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		movie = reserveDAO.getMovie(movienum);
		
		close(con);
		
		return movie;
	}

}
