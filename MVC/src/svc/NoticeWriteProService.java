package svc;

import java.sql.Connection;

import dao.NoticeDAO;
import vo.NoticeBean;

//import db.JdbcUtil;
// => JdbcUtil 클래스의 static 메서드들을 좀 더 쉽게 호출하기 위해
//    static import 기능을 활용할 수 있음
//    => import static 패키지명.클래스명.static메서드명;
//import static db.JdbcUtil.getConnection; // getConnection() 메서드를 등록
// => 모든 static 메서드를 등록하기 위해서는 메서드명 대신 만능문자(*) 사용
import static db.JdbcUtil.*;
// => db.JdbcUtil 클래스 내의 모든 static 메서드가 import 됨

// Action 클래스로부터 요청받은 작업에 대한 데이터 등을 전달받아
// Model(DAO 클래스)을 통해 실제 작업 처리를 요청하고
// 처리 결과를 리턴받아 해당 결과에 대한 판별을 통해
// 결과값으로 처리할 데이터를 리턴
public class NoticeWriteProService {
	
	// 글 쓰기(등록) 요청을 처리하기 위한 registArticle() 메서드 정의
	// => 파라미터 : 게시물 정보(BoardBean)
	// => 리턴타입 : boolean(isWriteSuccess)
	public boolean registArticle(NoticeBean noticeBean) throws Exception {
		System.out.println("NoticeWriteProService - registArticle()");
		
		boolean isWriteSuccess = false; // 글 등록 성공 여부를 저장
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		// 1(공통). DB 작업에 필요한 Connection 객체 가져오기
//		Connection con = JdbcUtil.getConnection();
		// => static import 로 선언된 메서드는 클래스명을 붙일 수 없다!
		Connection con = getConnection(); // 메서드명만으로 접근 가능
		
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		
		// 3(공통). 가져온 Connection 객체를 DAO 객체에 전달하기
		noticeDAO.setConnection(con);
		
		// 4. BoardDAO 객체의 insertArticle() 메서드를 호출하여 글 등록 처리
		// => 파라미터 : BoardBean, 리턴타입 : int(insertCount)
		int insertCount = noticeDAO.insertArticle(noticeBean);
		
		// 5. 리턴받은 글 등록 결과를 판별
		// => 0보다 클 경우 성공 commit, 0 일 경우 실패 rollback 작업 수행
		if(insertCount > 0) {
			commit(con); // DB 커밋 작업 수행
			isWriteSuccess = true; // 리턴할 작업 수행 결과를 true 로 설정
		} else {
			rollback(con);
		}
		
		// 6(공통). 사용이 완료된 Connection 객체 반환하기
		close(con);

		// 7. 글 등록 성공 여부 리턴 => BoardWriteProAction 클래스로 전달
		return isWriteSuccess;
	}
	
}




















