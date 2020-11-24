package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;
import vo.StoreBean;

public class StoreListService {

	public int getListCount() {
		System.out.println("StoreListService - getListCount()");
		int listCount = 0;
		
		//1.(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		StoreDAO storeDAO = StoreDAO.getInstance();
				
		// 3(공통). 가져온 Connection 객체를 DAO 객체에 전달하기
		storeDAO.setConnection(con);
		
		//4. storeDAO 객체의 selectListCount() 메서드를 호출하여 
		//	 전체 게시물 수 가져오기
		listCount = storeDAO.selectListCount();
		
		//5.(공통). 사용이 완료된 Connection 객체를 반환하기
		close(con);
		
		//6. 전체 게시물 수 리턴
		return listCount;
	}
	
	public ArrayList<StoreBean> getArticleList(int page, int limit) throws Exception {
		System.out.println("StoreListService - getArticleList()");
		
		ArrayList<StoreBean> articleList = null;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). stroeDAO 객체 가져오기
		StoreDAO storeDAO = StoreDAO.getInstance();
		
		// 3(공통). storeDAO 객체에 Connection 객체 전달
		storeDAO.setConnection(con);
		
		// 4. storeDAO 객체의 selectArticleList() 메서드를 호출하여
		//    게시물 목록 조회 결과를 ArrayList 객체로 리턴받기
		//    => 파라미터 : page, limit
		articleList = storeDAO.selectArticleList(page, limit);
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		
		// 6. 조회된 게시물 목록 리턴
		return articleList;
	}

}
