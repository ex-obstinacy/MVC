package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MemberDAO;
import dao.MovDAO;
import vo.MemberBean;
import vo.MovBean;
import vo.ReserveBean;

public class MemberReserveListService {

	public int getReserveListCount(String id) {
		System.out.println("MemberReserveListService - getReserveListCount()");
		
		int listCount = 0;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		listCount = memberDAO.selectReserveListCount(id);
		
		close(con);
		
		return listCount;
	}

	public ArrayList<ReserveBean> getReserveList(int page, int limit, String id) {
		System.out.println("MemberReserveListService - getArticleList()");
		
		ArrayList<ReserveBean> articleList = null;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		articleList = memberDAO.selectReserveList(page, limit, id);
		
		close(con);
		
		return articleList;
	}
	
	

}
