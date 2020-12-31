package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MemberDAO;
import dao.MovDAO;
import vo.MovCommentBean;

public class MemberMovCommentService {

	public int getListCount(String id) {
		System.out.println("MemberMovCommentService - getListCount()");
		
		int listCount = 0;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		listCount = memberDAO.selectMovCommentListCount(id);
		
		close(con);
		
		return listCount;
	}

	public ArrayList<MovCommentBean> getArticleList(int page, int limit, String id) {
		System.out.println("MemberMovCommentService - getArticleList()");
		
		ArrayList<MovCommentBean> articleList = null;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		articleList = memberDAO.selectMovCommentArticleList(page, limit, id);
		
		close(con);
		
		return articleList;
	}

}
