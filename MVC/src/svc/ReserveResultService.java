package svc;

import vo.MovBean;
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

	public MovBean getMoviePost(int moviecode) {
		System.out.println("ReserveResultService !");
		MovBean mv = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		mv = reserveDAO.getMoviePost(moviecode);
		
		close(con);
		
		return mv;
	}

}
