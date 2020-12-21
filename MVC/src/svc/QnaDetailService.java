package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.QnaDAO;
import vo.QnaBean;

import static db.JdbcUtil.*;
public class QnaDetailService {

	// 게시물 1개에 대한 상세 내용을 요청하는 getArticle() 메서드 정의
	public QnaBean getArticle(int num) throws Exception{
		System.out.println("QnaDetailService - getArticle()");
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). QnaDAO 객체 가져오기
		QnaDAO qnaDAO = QnaDAO.getInstance();
		
		// 3(공통). QnaDAO 객체에 Connection 객체 전달
		qnaDAO.setConnection(con);
		
		// 4. QnaDAO 객체의 selectArticle() 메서드를 호출하여
		//    게시물 1개 상세내용 조회 결과를 QnaBean 객체로 리턴받기
		//    => 파라미터 : 글번호(num), 리턴타입 : QnaBean
		QnaBean article = qnaDAO.selectArticle(num);
		System.out.println("view 페이지 조회 시 num : " + num);
		// 게시물 상세 내용 조회가 성공했을 경우 
		// QnaDAO 객체의 updateReadCount() 메서드 호출하여
		// 해당 게시물 조회수(readcount)를 1만큼 증가시키기
		// => 파라미터 : 글번호(num), 
		//    리턴타입 : int(UPDATE 실행 결과(updateCount))
		if(article != null) { // 게시물 상세 내용이 리턴되었을 경우(= 조회 성공)
			int updateCount = qnaDAO.updateReadcount(num);
			
			// 조회수 증가가 성공했을 경우 commit, 실패했을 경우 rollback 수행
			if(updateCount > 0) {
				commit(con);
			} else {
				rollback(con);
				System.out.println("오류");
			}
		}
		
		System.out.println();
		
		
		// 5(공통). Connection 객체 반환하기
		close(con);
		
		return article;
	}

}
