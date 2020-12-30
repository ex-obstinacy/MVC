package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import vo.MemberBean;
import vo.MovBean;
import vo.MovCommentBean;

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
			pstmt.setInt(15, movBean.getTicketing());
			
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
		
		ArrayList<MovBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;
		
		try {
			// 회원 조회
			String sql = "SELECT * FROM movie_board LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			articleList = new ArrayList<MovBean>();
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 BoardBean 객체 생성 및 데이터 저장
				MovBean article = new MovBean();
				article.setMovieCd(rs.getInt(1));
				article.setSubjet(rs.getString(2));
				article.setGenre(rs.getString(3));
				article.setOpenDt(rs.getDate(4));
				article.setShowTm(rs.getString(5));
				article.setDirector(rs.getString(6));
				article.setCast(rs.getString(7));
				article.setNationNm(rs.getString(8));
				article.setCompanys(rs.getString(9));
				article.setGrade(rs.getString(10));
				article.setPost(rs.getString(11));
				article.setStillCut(rs.getString(12));
				article.setTrailer(rs.getString(13));
				article.setContent(rs.getString(14));
				
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

	public MovBean selectArticle(int movieCd) {
		System.out.println("MovDAO - selectArticle()");
		
		MovBean article = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM movie_board WHERE movCode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieCd);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				article = new MovBean();
				article.setMovieCd(rs.getInt(1));
				article.setSubjet(rs.getString(2));
				article.setGenre(rs.getString(3));
				article.setOpenDt(rs.getDate(4));
				article.setShowTm(rs.getString(5));
				article.setDirector(rs.getString(6));
				article.setCast(rs.getString(7));
				article.setNationNm(rs.getString(8));
				article.setCompanys(rs.getString(9));
				article.setGrade(rs.getString(10));
				article.setPost(rs.getString(11));
				article.setStillCut(rs.getString(12));
				article.setTrailer(rs.getString(13));
				article.setContent(rs.getString(14));
				article.setTicketing(rs.getInt(15));
				
			}
			
		} catch (SQLException e) {
			System.out.println("selectArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(pstmt);
			close(rs);
			
		}
		
		return article;
	}

	public int deleteMov(String movieCd) {
		System.out.println("MovDAO - deleteMember()");
		
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "DELETE FROM movie_board WHERE movCode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieCd);
			deleteCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("deleteMember() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			// 자원 반환
			close(pstmt);
			
		}
		
		return deleteCount;
	}

	public int selectTicketing() {
		System.out.println("MovDAO - selectTicketing()");
		
		int sumTicketing = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT SUM(ticketing) FROM movie_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sumTicketing = rs.getInt(1);
				
			}
			
		} catch (SQLException e) {
			System.out.println("selectTicketing() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(pstmt);
			close(rs);
			
		}
		
		return sumTicketing;
	}

	// 댓글 등록
	public int insertMovCommentArticle(MovCommentBean movCommentBean) {
		System.out.println("MovDAO - insertMovCommentArticle()");
		
		int insertCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = 1;
		
		try {
			String sql = "SELECT MAX(num) FROM mb_comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1; // 새 글 번호 만들기
			}
			
			sql = "INSERT INTO mb_comment VALUES (?, ?, ?, now(), ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, movCommentBean.getMember_id());
			pstmt.setString(3, movCommentBean.getContent());
			pstmt.setInt(4, movCommentBean.getCmgrade());
			pstmt.setInt(5, movCommentBean.getMovie_board_movCode());
			
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

	public int selectMovCommentListCount(int movieCd) {
		System.out.println("MovDAO - selectMovCommentListCount()");
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM mb_comment WHERE movie_board_movCode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieCd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("selectMovCommentListCount() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(rs);
			close(pstmt);
			
		}
		
		return listCount;
	}

	public ArrayList<MovCommentBean> selectMovCommentArticleList(int page, int limit, int movieCd) {
		System.out.println("MovDAO - selectMovCommentArticleList()");
		
		ArrayList<MovCommentBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;
		
		try {
			// 회원 조회
			String sql = "SELECT * FROM mb_comment WHERE movie_board_movCode=? ORDER BY date DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieCd);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			articleList = new ArrayList<MovCommentBean>();
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 BoardBean 객체 생성 및 데이터 저장
				MovCommentBean article = new MovCommentBean();
				article.setNum(rs.getInt(1));
				article.setMember_id(rs.getString(2));
				article.setContent(rs.getString(3));
				article.setDate(rs.getTimestamp(4));
				article.setCmgrade(rs.getInt(5));
				article.setMovie_board_movCode(rs.getInt(6));
				
				// 1개 회원을 전체 회원 저장 객체(ArrayList)에 추가
				articleList.add(article);
			}
			
		} catch (SQLException e) {
			System.out.println("selectMovCommentArticleList() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(rs);
			close(pstmt);
			
		}
		
		return articleList;
	}

	public int deleteMovComment(int num) {
		System.out.println("MovDAO - deleteMovComment()");
		
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "DELETE FROM mb_comment WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			deleteCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("deleteMovComment() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			// 자원 반환
			close(pstmt);
			
		}
		
		return deleteCount;
	}

	public float selectCmgrade(int movieCd) {
		System.out.println("MovDAO - selectCmgrade()");
		
		float sumCmgrade = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT AVG(cmgrade) FROM mb_comment WHERE movie_board_movCode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieCd);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sumCmgrade = rs.getFloat(1);
				sumCmgrade = Float.parseFloat(String.format("%.1f", sumCmgrade));

			}
			
		} catch (SQLException e) {
			System.out.println("selectCmgrade() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(pstmt);
			close(rs);
			
		}
		
		return sumCmgrade;
	}

	// 현재 상영작 조회
	public ArrayList<MovBean> selectListCurrentMov() {
		System.out.println("MovDAO - selectListCurrentMov()");
		
		ArrayList<MovBean> currentMovList = null;
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try {
			int sumTicketing = 0;
			
			String sql = "SELECT SUM(ticketing) FROM movie_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sumTicketing = rs.getInt(1);
				
			}
			
			// 회원 조회
			sql = "SELECT DISTINCT m.movCode, m.grade, m.post, m.subject, m.ticketing FROM admin_reservation r JOIN movie_board m ON r.movie_board_movCode = m.movCode ORDER BY m.ticketing DESC limit 0,5";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			currentMovList = new ArrayList<MovBean>();
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 BoardBean 객체 생성 및 데이터 저장
				MovBean article = new MovBean();
				article.setMovieCd(rs.getInt(1));
				article.setGrade(rs.getString(2));
				article.setPost(rs.getString(3));
				article.setSubjet(rs.getString(4));
				article.setTicketing(rs.getInt(5));
				
				float bookingRate = (float) rs.getInt(5) / sumTicketing * 100;
				article.setBookingRate(Float.parseFloat(String.format("%.1f", bookingRate)));
				
				// 1개 회원을 전체 회원 저장 객체(ArrayList)에 추가
				currentMovList.add(article);
			}
			
		} catch (SQLException e) {
			System.out.println("selectListCurrentMov() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(rs);
			close(pstmt);
			
		}
		
		return currentMovList;
	}
	
	// 상영 예정작 조회
	public ArrayList<MovBean> selectListToBeMov() {
		System.out.println("MovDAO - selectListToBeMov()");
		
		ArrayList<MovBean> toBeMovList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 회원 조회
			String sql = "SELECT * FROM movie_board WHERE openDt > now() ORDER BY openDt limit 0,5";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			toBeMovList = new ArrayList<MovBean>();
			
			Date nowDate = new Date(System.currentTimeMillis());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			System.out.println(sdf.format(nowDate));
			
			while(rs.next()) {
				
				// 1개 게시물 정보를 저장할 BoardBean 객체 생성 및 데이터 저장
				MovBean article = new MovBean();
				article.setMovieCd(rs.getInt(1));
				article.setSubjet(rs.getString(2));
				article.setGenre(rs.getString(3));
				article.setOpenDt(rs.getDate(4));
				article.setShowTm(rs.getString(5));
				article.setDirector(rs.getString(6));
				article.setCast(rs.getString(7));
				article.setNationNm(rs.getString(8));
				article.setCompanys(rs.getString(9));
				article.setGrade(rs.getString(10));
				article.setPost(rs.getString(11));
				article.setStillCut(rs.getString(12));
				article.setTrailer(rs.getString(13));
				article.setContent(rs.getString(14));
				article.setTicketing(rs.getInt(15));
				
				// 1개 회원을 전체 회원 저장 객체(ArrayList)에 추가
				toBeMovList.add(article);
			}
			
		} catch (SQLException e) {
			System.out.println("selectListToBeMov() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(rs);
			close(pstmt);
			
		}
		
		return toBeMovList;
	}
	
}
