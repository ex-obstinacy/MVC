package svc;

import vo.PreviewBean;
import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.NoticeDAO;
import dao.PreviewDAO;


public class PreviewModifyProService {

	public static boolean modifyArticle(PreviewBean article) throws Exception {
		
		boolean isModifySuccess = true;


		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2(공통). PreviewDAO 객체 가져오기
		PreviewDAO previewDAO = PreviewDAO.getInstance();
		
		// 3(공통). PreviewDAO 객체에 Connection 객체 전달
		previewDAO.setConnection(con);

		// 4. PreviewDAO 클래스의 updateArticle() 메서드를 호출하여 글 수정
		//    => 파라미터 : PreviewBean, 리턴타입 : int(updateCount)
		int updateCount = previewDAO.updateArticle(article);
		
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
