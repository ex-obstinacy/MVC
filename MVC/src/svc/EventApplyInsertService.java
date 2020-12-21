package svc;

import vo.ApplyBean;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.ApplyDAO;


public class EventApplyInsertService {

	public boolean registArticle(ApplyBean applyBean) {
		
		System.out.println("EventApplyInsertService ! - registArticle() ");
		
		boolean isInsertSuccess = false;  
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		// 1(공통). DB  작업에 필요한 Connection 객체 가져오기
//		Connection con = JdbcUtil.getConnection();
		// => static import 로 선언된 메서드는 클래스명을 붙일 수 없다!
		Connection con = getConnection(); // 메서드명만으로 접근 가능
		
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		ApplyDAO applyDAO = ApplyDAO.getInstance();
		
		// 3(공통). 가져온 Connection 객체를 DAO 객체에 전달하기
		applyDAO.setConnection(con);
		
		// 4. BoardDAO 객체의 insertArticle() 메서드를 호출하여 글 등록 처리
		// => 파라미터 : BoardBean, 리턴타입 : int(insertCount)
		int insertCount = applyDAO.insertArticle(applyBean);
		
		// 5. 리턴받은 글 등록 결과를 판별
		// => 0보다 클 경우 성공 commit, 0 일 경우 실패 rollback 작업 수행
		if (insertCount > 0) {
			commit(con); // DB 커밋 작업 수행
			isInsertSuccess = true; // 리턴할 작업 수행 결과를 true 로 설정
			
		} else {
			rollback(con);
			
		}
		
		// 6(공통). 사용이 완료된 Connection 객체 반환하기
		close(con);
		
		return isInsertSuccess;
	}

}
