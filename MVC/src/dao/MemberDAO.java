package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import vo.MemberBean;
import static db.JdbcUtil.*;

public class MemberDAO {
	
	/*
	 * 싱글톤 디자인 패턴을 활용한 BoardDAO 인스턴스 작업
	 * 1. 외부에서 인스턴스 생성이 불가능하도록 생성자 호출을 막기 위해
	 *    private 접근제한자를 적용하는 생성자 정의  
	 * 2. 직접 DAO 클래스의 인스턴스를 생성하여 멤버변수(instance)로 저장
	 *    => 접근제한자 private 로 설정하여 외부에서 접근 불가능하도록 지정
	 *    => 생성자를 리턴하는 static 메서드 getInstance() 에서
	 *       멤버변수에 접근할 수 있도록 static 멤버변수로 선언
	 * 3. 생성된 인스턴스를 외부로 리턴하기 위해 Getter 메서드(getInstance) 정의
	 *    => 파라미터 : 없음, 리턴타입 : BoardDAO
	 *    => 외부에서 인스턴스 생성 없이도 호출 가능하도록 static 메서드로 정의
	 * 
	 */
	
	private MemberDAO() {}
	
	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
		return instance;
		
	}
	// ==========================================================================
	
	Connection con; // Connection 객체를 전달받아 저장할 멤버변수

	// 외부(Service 클래스)로부터 Connection 객체를 전달받아
	// 멤버변수에 저장하는 setConnection() 메서드 정의
	public void setConnection(Connection con) {
		this.con = con;
		
	}
	
	// 글 등록 작업
	public int insertArticle(MemberBean memberBean) {
		System.out.println("BoardDAO - insertArticle()");
		
		// Service 클래스로부터 BoardBean 객체를 전달받아
		// DB의 board 테이블에 INSERT 작업 수행하고 결과(int타입)를 리턴
		
		int insertCount = 0; // INSERT 작업 수행 결과를 저장할 변수
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = 1; // 새 글 번호를 저장할 변수
		
		try {
			// 현재 게시물 번호(board_num) 중 가장 큰 번호를 조회하여
			// 해당 번호 + 1 값을 새 글 번호(num)으로 저장
			String sql = "SELECT MAX(board_num) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 조회된 결과가 있을 경우 조회된 번호 +1 값을 num 에 저장
			// => 조회 결과가 없을 경우 새 글 번호는 1번이므로 기본값 그대로 사용
			if (rs.next()) {
				num = rs.getInt(1) + 1; // 새 글 번호 만들기
				
			}
			
			// 전달받은 BoardBean 객체 내의 데이터를 사용하여 INSERT 작업 수행
			// => 컬럼 중 board_date 항목(작성일)은 now() 함수 사용
			sql = "INSERT INTO board VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			// BoardBean 객체로부터 데이터를 꺼내서 쿼리문 ? 대체
			pstmt.setInt(1, num); // 글번호
			
			// INSERT 구문 실행 결과값을 int형 변수 insertCount 에 저장
			insertCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
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
