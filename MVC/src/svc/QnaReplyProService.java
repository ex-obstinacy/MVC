package svc;

import vo.QnaBean;
import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.QnaDAO;



public class QnaReplyProService {

	// 답변글 작성 요청
	public static boolean replyArticle(QnaBean article) {
		boolean isReplySuccess = false;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). QnaDAO 객체 가져오기
		QnaDAO qnaDAO = QnaDAO.getInstance();
		
		// 3(공통). QnaDAO 객체에 Connection 객체 전달
		qnaDAO.setConnection(con);
		
		// 4. QnaDAO 클래스의 insertReplyArticle() 메서드를 호출하여 답글 등록
		//    => 파라미터 : QnaBean, 리턴타입 : int(insertCount)
		int insertCount = qnaDAO.insertReplyArticle(article);
		
		// 5. 답글 등록 결과에 대한 판별 작업 수행
		// => insertCount 가 0보다 크면 commit 수행, isReplySuccess 를 true 변경
		// => 아니면 rollback 수행
		if(insertCount > 0) {
			commit(con);
			isReplySuccess = true;
		} else {
			rollback(con);
		}
		
		// 6(공통). Connection 객체 반환하기
		close(con);
		
		// 7. 결과 리턴
		return isReplySuccess;
	}
	
}