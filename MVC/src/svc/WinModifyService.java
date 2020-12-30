package svc;

import vo.WinBean;

import static db.JdbcUtil.*;

import java.sql.Connection;


import dao.WinDAO;

public class WinModifyService {

	public boolean modifyArticle(WinBean article) {
		
		boolean isModifySuccess = true;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		int updateCount = winDAO.updateArticle(article);
		
		if(updateCount > 0) {
			commit(con);
			isModifySuccess = true;
		} else {
			rollback(con);
		}
		
		// 6(공통). Connection 객체 반환하기
		close(con);
		
		// 7. 결과 리턴
		
	
		return isModifySuccess;
	}

}