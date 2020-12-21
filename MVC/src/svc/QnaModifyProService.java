package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.QnaDAO;
import vo.QnaBean;

public class QnaModifyProService {

	public boolean modifyArticle(QnaBean article) throws Exception {
		// 글 수정 작업 요청 수행
		
		boolean isModifySuccess = true;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). QnaDAO 객체 가져오기
		QnaDAO qnaDAO = QnaDAO.getInstance(); 
		
		// 3(공통). QnaDAO 객체에 Connection 객체 전달
		qnaDAO.setConnection(con);
		
		// 4. QnaDAO 클래스의 updateArticle() 메서드를 호출하여 글 수정
		//    => 파라미터 : QnaBean, 리턴타입 : int(updateCount)
		int updateCount = qnaDAO.updateArticle(article);
		
		// 5. 글 수정 결과에 대한 판별 작업 수행
		// => updateCount 가 0보다 크면 commit 수행, isModifySuccess 를 true 변경
		// => 아니면 rollback 수행
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
