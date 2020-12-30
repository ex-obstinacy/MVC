package svc;

import vo.WinBean;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.WinDAO;

public class WinDetailService {

	public WinBean getArticle(int num) throws Exception {
		System.out.println("WinDetailService - getArticle() ");
		
		Connection con = getConnection();
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		WinBean article = winDAO.selectArticle(num);
		
		if(article != null) { // 게시물 상세 내용이 리턴되었을 경우(= 조회 성공)
			int updateCount = winDAO.updateReadcount(num);
			
			// 조회수 증가가 성공했을 경우 commit, 실패했을 경우 rollback 수행
			if(updateCount > 0) {
				commit(con);
			} else {
				rollback(con);
			}
		}
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		
		return article;
	}

}
