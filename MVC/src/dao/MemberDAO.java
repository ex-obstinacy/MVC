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
	 * 싱글톤 디자인 패턴을 활용한 MemberDAO 인스턴스 작업
	 * 1. 외부에서 인스턴스 생성이 불가능하도록 생성자 호출을 막기 위해
	 *    private 접근제한자를 적용하는 생성자 정의  
	 * 2. 직접 DAO 클래스의 인스턴스를 생성하여 멤버변수(instance)로 저장
	 *    => 접근제한자 private 로 설정하여 외부에서 접근 불가능하도록 지정
	 *    => 생성자를 리턴하는 static 메서드 getInstance() 에서
	 *       멤버변수에 접근할 수 있도록 static 멤버변수로 선언
	 * 3. 생성된 인스턴스를 외부로 리턴하기 위해 Getter 메서드(getInstance) 정의
	 *    => 파라미터 : 없음, 리턴타입 : MemberDAO
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
	
	// 회원 등록 작업
	public int insertArticle(MemberBean memberBean) {
		System.out.println("MemberDAO - insertArticle()");
		
		// Service 클래스로부터 memberBean 객체를 전달받아
		// DB의 member 테이블에 INSERT 작업 수행하고 결과(int타입)를 리턴
		
		int insertCount = 0; // INSERT 작업 수행 결과를 저장할 변수
		
		PreparedStatement pstmt = null;
		
		try {
			// 전달받은 memberBean 객체 내의 데이터를 사용하여 INSERT 작업 수행
			String sql = "INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0, 0, 0)";
			pstmt = con.prepareStatement(sql);
			// memberBean 객체로부터 데이터를 꺼내서 쿼리문 ? 대체
			pstmt.setString(1, memberBean.getId());
			pstmt.setString(2, memberBean.getPass());
			pstmt.setString(3, memberBean.getName());
			pstmt.setString(4, memberBean.getPhone());
			pstmt.setDate(5, memberBean.getBirthday());
			pstmt.setString(6, memberBean.getGender());
			pstmt.setString(7, memberBean.getEmail());
			pstmt.setString(8, memberBean.getPostcode());
			pstmt.setString(9, memberBean.getAddress());
			pstmt.setString(10, memberBean.getDetailAddress());
			pstmt.setString(11, memberBean.getExtraAddress());
			
			// INSERT 구문 실행 결과값을 int형 변수 insertCount 에 저장
			insertCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			// 자원 반환
			close(pstmt);
			
		}
		
		return insertCount;
		
	}

}
