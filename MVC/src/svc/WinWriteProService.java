package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.WinDAO;
import vo.WinBean;

import static db.JdbcUtil.*;

public class WinWriteProService {


	public boolean registArticle(WinBean article) {
		System.out.println("WinWriteProService - registArticle() !!");
		boolean isWriteSuccess = false;
		
		Connection con = getConnection(); // 메서드명만으로 접근 가능
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		int insertCount = winDAO.insertArticle(article);
		
		if(insertCount > 0) {
			commit(con); // DB 커밋 작업 수행
			isWriteSuccess = true; // 리턴할 작업 수행 결과를 true 로 설정
		} else {
			rollback(con);
		}
		
		// 6(공통). 사용이 완료된 Connection 객체 반환하기
		close(con);
		
		return isWriteSuccess;
	}

	public boolean hasEvent(int event_num) {
		boolean isEventExist = false;
		
		Connection con = getConnection(); // 메서드명만으로 접근 가능
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		int checkEvent = winDAO.hasEvent(event_num);
		
		if(checkEvent > 0) {
			commit(con); // DB 커밋 작업 수행
			isEventExist = true; // 리턴할 작업 수행 결과를 true 로 설정
		} else {
			rollback(con);
		}
		
		// 6(공통). 사용이 완료된 Connection 객체 반환하기
		close(con);
		
		return isEventExist;
	}

}
