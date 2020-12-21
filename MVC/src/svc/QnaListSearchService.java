package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;


import dao.QnaDAO;
import vo.QnaBean;

public class QnaListSearchService {

	public int getListCount(String search) {
		System.out.println("QnaListSearchService - getListCount()");
		int listCount = 0;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). BoardDAO 객체 가져오기
		QnaDAO qnaDAO = QnaDAO.getInstance();
		
		// 3(공통). BoardDAO 객체에 Connection 객체 전달
		qnaDAO.setConnection(con);
		
		// 4. NoticeDAO 객체의 selectListCount() 메서드 호출하여
		//    전체 게시물 수 가져오기
		listCount = qnaDAO.selectListCount(search);
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		
		// 6. 전체 게시물 수 리턴
		return listCount;
	}

	public ArrayList<QnaBean> getArticleList(int page, int limit, String search) {
		System.out.println("QnaListSearchService - getArticleList()");
		
		ArrayList<QnaBean> articleList = null;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). NoticeDAO 객체 가져오기
		QnaDAO qnaDAO = QnaDAO.getInstance();
		
		// 3(공통). NoticeDAO 객체에 Connection 객체 전달
		qnaDAO.setConnection(con);
		
		// 4. NoticeDAO 객체의 selectArticleList() 메서드를 호출하여
		//    게시물 목록 조회 결과를 ArrayList 객체로 리턴받기
		//    => 파라미터 : page, limit
		articleList = qnaDAO.selectArticleList(page, limit, search);
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		
		// 6. 조회된 게시물 목록 리턴
		return articleList;
	}

	public ArrayList<QnaBean> getUserArticleList(String id, int page, int limit, String search) {

		ArrayList<QnaBean> articleList = null;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). NoticeDAO 객체 가져오기
		QnaDAO qnaDAO = QnaDAO.getInstance();
		
		// 3(공통). NoticeDAO 객체에 Connection 객체 전달
		qnaDAO.setConnection(con);
		
		// 4. NoticeDAO 객체의 selectArticleList() 메서드를 호출하여
		//    게시물 목록 조회 결과를 ArrayList 객체로 리턴받기
		//    => 파라미터 : page, limit
		articleList = qnaDAO.selectUserArticleList(id, page, limit, search);
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		
		// 6. 조회된 게시물 목록 리턴
		return articleList;
	}

}
