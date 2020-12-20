package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import vo.MovBean;

import static db.JdbcUtil.*;

public class MovDAO {
	
	private MovDAO() {}
	
	private static MovDAO instance = new MovDAO();

	public static MovDAO getInstance() {
		return instance;
		
	}
	// ==========================================================================
	
	Connection con; // Connection 객체를 전달받아 저장할 멤버변수

	// 외부(Service 클래스)로부터 Connection 객체를 전달받아
	// 멤버변수에 저장하는 setConnection() 메서드 정의
	public void setConnection(Connection con) {
		this.con = con;
		
	}

	// 영화 등록
	public int insertArticle(MovBean movBean) {
		System.out.println("MovDAO - insertArticle()");
		
		int insertCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			// 전달받은 memberBean 객체 내의 데이터를 사용하여 INSERT 작업 수행
			String sql = "INSERT INTO movie_board VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			// memberBean 객체로부터 데이터를 꺼내서 쿼리문 ? 대체
			pstmt.setInt(1, movBean.getMovieCd());
			pstmt.setString(2, movBean.getSubjet());
			pstmt.setString(3, movBean.getGenre());
			pstmt.setDate(4, movBean.getOpenDt());
			pstmt.setString(5, movBean.getShowTm());
			pstmt.setString(6, movBean.getDirector());
			pstmt.setString(7, movBean.getCast());
			pstmt.setString(8, movBean.getNationNm());
			pstmt.setString(9, movBean.getCompanys());
			pstmt.setString(10, movBean.getGrade());
			pstmt.setString(11, movBean.getPost());
			pstmt.setString(12, movBean.getStillCut());
			pstmt.setString(13, movBean.getTrailer());
			pstmt.setString(14, movBean.getContent());
			pstmt.setString(15, movBean.getTicketing());
			
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
