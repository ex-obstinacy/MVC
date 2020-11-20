package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoreDAO;
import vo.StoreBean;

public class GoodsWriteProService {
	// 글 쓰기(등록) 요청을 처리하기 위한 registArticle() 메서드 정의
		// => 파라미터 : 게시물 정보(BoardBean)
		// => 리턴타입 :  boolean(isWriteSuccess)
		public boolean registArticle(StoreBean storeBean) throws Exception {
			System.out.println("GoodsWriteProService - registArticle()");
			
			boolean isWriteSuccess = false; //글 등록 성공 여부를 리턴받아 저장
											//false는 실패! 이전 페이지로 back
			
			// 1(공통). DB 작업에 필요한 Connection 객체 가져오기
//			Connection con = JdbcUtil.getConnection();
			// static import로 선언된 메서드는 클래스명을 붙일 수 없다!
			Connection con = getConnection();
			
			// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
			StoreDAO storeDAO = StoreDAO.getInstance();
			
			// 3(공통). 가져온 Connection 객체를 DAO 객체에 전달하기
			storeDAO.setConnection(con);
			
			// 4. BoardDAO 객체의 insertArticle() 메서드를 호출하여 글 등록 처리
			// => 파라미터 : BoardBean, 리턴타입 : boolean(isWriteSuccess)
			int insertCount = storeDAO.insertArticle(storeBean);
			
			// 5. 리턴받은 글 등록 결과를 판별
			// => 0보다 클 경우 commit, 0일 경우 rollback 작업 수행
			if (insertCount > 0) {
//				JdbcUtil.commit(con);
				commit(con);
				isWriteSuccess = true;
			} else if(insertCount == 0) {
//				JdbcUtil.rollback(con);
				rollback(con);
			}
			
			// 6(공통). 사용이 완료된 Connection 객체를 반환하기
//			JdbcUtil.close(con);
			close(con);
			
			// 7. 글 등록 성공 여부 리턴 => BoardWriteProAction 클래스로 전달
			return isWriteSuccess;
		}
}
