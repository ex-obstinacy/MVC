package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.QnaDAO;

public class QnaDeleteProService {

	// 원글 삭제 (답글까지 같이 삭제됨)
	public boolean removeArticle(int re_ref) {
		// 글 삭제 작업 요청 수행
		boolean isDeleteSuccess = false;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). QnaDAO 객체 가져오기
		QnaDAO qnaDAO = QnaDAO.getInstance();
		
		// 3(공통). QnaDAO 객체에 Connection 객체 전달
		qnaDAO.setConnection(con);
		
		
		// 4. QnaDAO 클래스의 deleteArticle() 메서드를 호출하여 글 삭제
		//    => 파라미터 : 글번호(num), 리턴타입 : int(deleteCount)
		int deleteCount = qnaDAO.deleteArticle(re_ref);
		
		// 5. 글 삭제 결과에 대한 판별 작업 수행
		// => deleteCount 가 0보다 크면 commit 수행, isDeleteSuccess 를 true 변경
		// => 아니면 rollback 수행
		if(deleteCount > 0) {
			commit(con);
			System.out.println("삭제성공");
			isDeleteSuccess = true;
		} else {
			rollback(con);
			System.out.println("삭제실패");
		}
		
		// 6(공통). Connection 객체 반환하기
		close(con);
		
		// 7. 결과 리턴
		return isDeleteSuccess;
	}

	
	// 답글 삭제 (답글만 삭제됨) 
	public boolean removeReplyArticle(int num) {
		// 글 삭제 작업 요청 수행
		boolean isDeleteSuccess = false;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). QnaDAO 객체 가져오기
		QnaDAO qnaDAO = QnaDAO.getInstance();
		
		// 3(공통). QnaDAO 객체에 Connection 객체 전달
		qnaDAO.setConnection(con);
		
		
		// 4. QnaDAO 클래스의 deleteArticle() 메서드를 호출하여 글 삭제
		//    => 파라미터 : 글번호(num), 리턴타입 : int(deleteCount)
		int deleteCount = qnaDAO.deleteReplyArticle(num);
		// 5. 글 삭제 결과에 대한 판별 작업 수행
		// => deleteCount 가 0보다 크면 commit 수행, isDeleteSuccess 를 true 변경
		// => 아니면 rollback 수행
		if(deleteCount > 0) {
			commit(con);
			isDeleteSuccess = true;
		} else {
			rollback(con);
		}
		
		// 6(공통). Connection 객체 반환하기
		close(con);
		
		// 7. 결과 리턴
		return isDeleteSuccess;
	}

}

