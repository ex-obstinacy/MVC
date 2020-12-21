package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.MemberBean;
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

	public int selectListCount() {
		System.out.println("MovDAO - selectListCount()");
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// SELECT 구문을 사용하여 전체 회원 수 조회
			// => count() 함수 사용, 조회 대상 컬럼 1개 지정하거나 * 사용
			String sql = "SELECT COUNT(*) FROM movie_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("selectListCount() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(rs);
			close(pstmt);
			
		}
		
		return listCount;
	}

	public ArrayList<MovBean> selectArticleList(int page, int limit) {
		System.out.println("MovDAO - selectArticleList()");
		
		ArrayList<MemberBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;
		
		try {
			// 회원 조회
			String sql = "SELECT * FROM member LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			articleList = new ArrayList<MemberBean>();
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 BoardBean 객체 생성 및 데이터 저장
				MemberBean article = new MemberBean();
				article.setId(rs.getString(1));
				article.setPass(rs.getString(2));
				article.setName(rs.getString(3));
				article.setPhone(rs.getString(4));
				article.setBirthday(rs.getDate(5));
				article.setGender(rs.getString(6));
				article.setEmail(rs.getString(7));
				article.setPostcode(rs.getString(8));
				article.setAddress(rs.getString(9));
				article.setDetailAddress(rs.getString(10));
				article.setExtraAddress(rs.getString(11));
				article.setCoupon_1000(rs.getInt(12));
				article.setCoupon_2000(rs.getInt(13));
				article.setCoupon_3000(rs.getInt(14));
				article.setMembership(rs.getInt(15));
				article.setFree_ticket(rs.getInt(16));
				
				// 1개 회원을 전체 회원 저장 객체(ArrayList)에 추가
				articleList.add(article);
			}
			
		} catch (SQLException e) {
			System.out.println("selectArticleList() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(rs);
			close(pstmt);
			
		}
		
		return articleList;
	}
	

}
