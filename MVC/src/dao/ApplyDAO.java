package dao;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.ApplyBean;

public class ApplyDAO {

	private ApplyDAO() {}
	
	private static ApplyDAO instance = new ApplyDAO();
	
	public static ApplyDAO getInstance() {
		return instance;
	}
	
	Connection con; // Connection 객체를 전달받아 저장할 멤버변수
	
	// 외부(Service 클래스)로부터 Connection 객체를 전달받아
	// 멤버변수에 저장하는 setConnection() 메서드 정의
	public void setConnection(Connection con) {
		this.con = con;
	}

	public int insertArticle(ApplyBean applyBean) {
		
		System.out.println("ApplyDAO - insertArticle");
		
		int insertCount = 0 ;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = 1; // 새 글 번호를 저장할 변수

		
	try {
		// 현재 게시물 번호(num) 중 가장 큰 번호를 조회하여
		// 해당 번호 + 1 값을 새 글 번호(num)으로 저장
		String sql ="SELECT MAX(num) FROM apply";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		// 조회된 결과가 있을 경우 조회된 번호 + 1 값을 num 에 저장
			// => 조회 결과가 없을 경우 새 글 번호는 1번이므로 기본값 그대로 사용			
		
		if(rs.next()) {
			num = rs.getInt(1) + 1; // 새 글 번호 만들기
		}

		// 전달받은 NoticeBean 객체 내의 데이터를 사용하여 INSERT 작업 수행
		// => 컬럼 중 date 항목(작성일)은 now() 함수 사용
		sql = "INSERT INTO apply(num,date,win,member_id,event_num) values(?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		// ApplyBean 객체로부터 데이터를 꺼내서 쿼리문 ? 대체
		pstmt.setInt(1, num); // 회원번호
		pstmt.setTimestamp(2, applyBean.getDate());
		pstmt.setInt(3, applyBean.getWin());
		pstmt.setString(4, applyBean.getMember_id());
		pstmt.setInt(5, applyBean.getEvent_num());
		
		// -------------------------------------------------------------------
		// 서비스 클래스를 통해 실제 글 등록 작업 수행을 위한 요청
		// BoardWriteProService 클래스의 인스턴스 생성 후
		// registArticle() 메서드를 호출하여 글 등록 작업 수행 요청
		// => 파라미터 : BoardBean, 리턴타입 : boolean(isWriteSuccess)
		
		// INSERT 구문 실행 결과값을 int형 변수 insertCount 에 저장
		insertCount = pstmt.executeUpdate();
		
	} catch (SQLException e) {
		System.out.println("insertArticle() 오류! - " + e.getMessage());
		e.printStackTrace();
	} finally {
		// 자원 반환
		// 주의! DAO 클래스 내에서 Connection 객체 반환 금지!
		close(rs);
		close(pstmt);
	}
	
	return insertCount;
	}

}
