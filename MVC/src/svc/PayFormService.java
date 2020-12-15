package svc;

import vo.MemberBean;
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

}
