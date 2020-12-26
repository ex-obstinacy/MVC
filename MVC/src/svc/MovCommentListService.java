package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MovDAO;
import vo.MovBean;
import vo.MovCommentBean;

public class MovCommentListService {

	public int getListCount(String movieCd) {
		System.out.println("MovCommentListService - getListCount()");
		
		int listCount = 0;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		listCount = movDAO.selectMovCommentListCount(movieCd);
		
		close(con);
		
		return listCount;
		
	}

	public ArrayList<MovCommentBean> getArticleList(int page, int limit, String movieCd) {
		System.out.println("MovCommentListService - getArticleList()");
		
		ArrayList<MovCommentBean> articleList = null;
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		articleList = movDAO.selectMovCommentArticleList(page, limit, movieCd);
		
		close(con);
		
		return articleList;
	}

}
