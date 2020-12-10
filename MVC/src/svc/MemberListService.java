package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MemberDAO;

import static db.JdbcUtil.*;
import vo.MemberBean;

public class MemberListService {

	public int getListCount() {
		System.out.println("MemberListService - getListCount()");
		
		int listCount = 0;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		listCount = memberDAO.selectListCount();
		
		close(con);
		
		return listCount;
	}

	public ArrayList<MemberBean> getArticleList(int page, int limit) {
		System.out.println("MemberListService - getArticleList()");
		
		ArrayList<MemberBean> articleList = null;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		articleList = memberDAO.selectArticleList(page, limit);
		
		close(con);
		
		return articleList;
	}

}
