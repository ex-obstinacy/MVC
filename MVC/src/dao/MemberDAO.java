package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import exception.LoginException;
import vo.MemberBean;
import vo.MemberShipBean;
import vo.MovCommentBean;

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
			String sql = "INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0, 0, 0, 0)";
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

	// 로그인 작업
	public boolean selectLoginMember(String id, String pass) throws LoginException {
		System.out.println("MemberDAO - selectLoginMember()");
		
		boolean isMember = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT pass FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (pass.equals(rs.getString(1))) {
					isMember = true;
					
				} else {
					throw new LoginException("패스워드 오류!");
					
				}
			} else {
				throw new LoginException("아이디 없음!");
				
			}
			
		} catch (SQLException e) {
			System.out.println("selectLoginMember() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(pstmt);
			close(rs);
			
		}
		
		return isMember;
	}

	// 회원정보 조회
	public MemberBean selectArticle(String id) {
		System.out.println("MemberDAO - selectArticle()");
		
		MemberBean article = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				article = new MemberBean();
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
	
	// 회원 삭제 작업
	public int deleteMember(String id) {
		System.out.println("MemberDAO - deleteMember()");
		
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "DELETE FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
	
	// 회원 정보 업데이트 작업
	public int updateMember(MemberBean memberBean) {
		System.out.println("MemberDAO - updateMember()");
		
		int updateCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			String sql = "UPDATE member "
					+ "SET pass=?, phone=?, birthday=?, gender=?, email=?, "
					+ "postcode=?, address=?, detailAddress=?, extraAddress=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberBean.getPass());
			pstmt.setString(2, memberBean.getPhone());
			pstmt.setDate(3, memberBean.getBirthday());
			pstmt.setString(4, memberBean.getGender());
			pstmt.setString(5, memberBean.getEmail());
			pstmt.setString(6, memberBean.getPostcode());
			pstmt.setString(7, memberBean.getAddress());
			pstmt.setString(8, memberBean.getDetailAddress());
			pstmt.setString(9, memberBean.getExtraAddress());
			pstmt.setString(10, memberBean.getId());
			updateCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("updateMember() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			// 자원 반환
			close(pstmt);
			
		}
		
		return updateCount;
	}

	// 회원 수 조회
	public int selectListCount() {
		System.out.println("MemberDAO - selectListCount()");
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// SELECT 구문을 사용하여 전체 회원 수 조회
			// => count() 함수 사용, 조회 대상 컬럼 1개 지정하거나 * 사용
			String sql = "SELECT COUNT(id) FROM member";
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

	// 전체 회원 정보 담기
	public ArrayList<MemberBean> selectArticleList(int page, int limit) {
		System.out.println("MemberDAO - selectArticleList()");
		
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

	// 멤버쉽 확인
	public MemberShipBean selectMemberShip(String id) {
		System.out.println("MemberDAO - selectMemberShip()");
		
		MemberShipBean memberShip = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT membership FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				memberShip = new MemberShipBean();
				memberShip.setPoint(rs.getInt(1));
				
			}
			
		} catch (SQLException e) {
			System.out.println("selectMemberShip() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(pstmt);
			close(rs);
			
		}
		
		
		
		
		return memberShip;
	}

	// 회원 가입시 아이디중복 확인
	public boolean checkArticle(String id) {
		System.out.println("MemberDAO - checkArticle()");
		
		boolean chekcIdResult = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT id FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				chekcIdResult = true;
			}
			
		} catch (SQLException e) {
			System.out.println("checkArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			close(pstmt);
			
		}
		
		return chekcIdResult;
	}

	public int selectMovCommentListCount(String id) {
		System.out.println("MemberDAO - selectMovCommentListCount()");
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM mb_comment WHERE member_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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

	public ArrayList<MovCommentBean> selectMovCommentArticleList(int page, int limit, String id) {
		System.out.println("MemberDAO - selectMovCommentArticleList()");
		
		ArrayList<MovCommentBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;
		
		try {
			// 회원 조회
			String sql = "SELECT m.movCode, m.post, m.subject, c.content, c.date, c.cmgrade "
					+ "FROM mb_comment c JOIN movie_board m ON m.movCode = c.movie_board_movCode "
					+ "WHERE c.member_id=? ORDER BY date DESC limit ?,?";
					
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			articleList = new ArrayList<MovCommentBean>();
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 BoardBean 객체 생성 및 데이터 저장
				MovCommentBean article = new MovCommentBean();
				article.setMovie_board_movCode(rs.getInt(1));
				article.setPost(rs.getString(2));
				article.setSubjet(rs.getString(3));
				article.setContent(rs.getString(4));
				article.setDate(rs.getTimestamp(5));
				article.setCmgrade(rs.getInt(6));
				
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

}
