package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;

import dao.MemberDAO;
import dao.MovDAO;
import vo.MemberBean;
import vo.MovBean;

public class MovListService {

	public int getListCount() {
		System.out.println("MovListService - getListCount()");
		
		int listCount = 0;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		listCount = movDAO.selectListCount();
		
		close(con);
		
		return listCount;
	}

	public ArrayList<MovBean> getArticleList(int page, int limit) {
		System.out.println("MovListService - getArticleList()");
		
		ArrayList<MovBean> articleList = null;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		articleList = movDAO.selectArticleList(page, limit);
		
		close(con);
		
		return articleList;
	}

}
