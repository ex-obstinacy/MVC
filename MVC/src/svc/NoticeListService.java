package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.NoticeDAO;
import vo.NoticeBean;

public class NoticeListService {

	// 전체 게시물 수를 조회하여 리턴하는 작업을 요청하는 getListCount() 정의
	public int getListCount() {
		System.out.println("NoticeListService - getListCount()");
		int listCount = 0;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). BoardDAO 객체 가져오기
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		
		// 3(공통). BoardDAO 객체에 Connection 객체 전달
		noticeDAO.setConnection(con);
		
		// 4. NoticeDAO 객체의 selectListCount() 메서드 호출하여
		//    전체 게시물 수 가져오기
		listCount = noticeDAO.selectListCount();
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		
		// 6. 전체 게시물 수 리턴
		return listCount;
	}

	// 게시물 목록 가져오기 작업 요청 수행
	public ArrayList<NoticeBean> getArticleList(int page, int limit) {
		System.out.println("NoticeListService - getArticleList()");
		
		ArrayList<NoticeBean> articleList = null;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). NoticeDAO 객체 가져오기
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		
		// 3(공통). NoticeDAO 객체에 Connection 객체 전달
		noticeDAO.setConnection(con);
		
		// 4. NoticeDAO 객체의 selectArticleList() 메서드를 호출하여
		//    게시물 목록 조회 결과를 ArrayList 객체로 리턴받기
		//    => 파라미터 : page, limit
		articleList = noticeDAO.selectArticleList(page, limit);
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		
		// 6. 조회된 게시물 목록 리턴
		return articleList;
	}
	
	
	
	
	
}
