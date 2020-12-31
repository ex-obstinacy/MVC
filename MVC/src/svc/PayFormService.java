package svc;

import vo.MemberBean;
import vo.MovBean;
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

	public MemberBean getMemberInfo(String member_id) {
		MemberBean memberInfo = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		memberInfo = reserveDAO.getMemberInfo(member_id);
		
		close(con);
		
		return memberInfo;
	}

	public String createTicketNum() {
		String ticketnum = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		ticketnum = reserveDAO.createTicketNum();
		
		close(con);
		
		return ticketnum;
	}

	public MovBean getMoviePost(int moviecode) {
		System.out.println("PayFormService !");
		MovBean mv = null;
		
		Connection con = getConnection();
		
		ReserveDAO reserveDAO = ReserveDAO.getInstance();
		
		reserveDAO.setConnection(con);
		
		mv = reserveDAO.getMoviePost(moviecode);
		
		close(con);
		
		return mv;
	}

}
