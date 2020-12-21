package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.EventBean;


public class EventDAO {

	private EventDAO() {}
	
	private static EventDAO instance = new EventDAO();

	public static EventDAO getInstance() {
		return instance;
	}
	
	Connection con; // Connection 객체를 전달받아 저장할 멤버변수

	// 외부(Service 클래스)로부터 Connection 객체를 전달받아
	// 멤버변수에 저장하는 setConnection() 메서드 정의
	public void setConnection(Connection con) {
		this.con = con;
	}

	// 글 등록
	public int insertArticle(EventBean eventBean) {
		
		System.out.println("EventDAO - insertArticle()");
		
		int insertCount = 0; // INSERT 작업 수행 결과를 저장할 변수
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = 1; // 새 글 번호를 저장할 변수
		
		try {
			// 현재 게시물 번호(num) 중 가장 큰 번호를 조회하여
			// 해당 번호 + 1 값을 새 글 번호(num)으로 저장
			String sql ="SELECT MAX(num) FROM event";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 조회된 결과가 있을 경우 조회된 번호 + 1 값을 num 에 저장
				// => 조회 결과가 없을 경우 새 글 번호는 1번이므로 기본값 그대로 사용			
			
			if(rs.next()) {
				num = rs.getInt(1) + 1; // 새 글 번호 만들기
			}

			// 전달받은 NoticeBean 객체 내의 데이터를 사용하여 INSERT 작업 수행
			// => 컬럼 중 date 항목(작성일)은 now() 함수 사용
			sql = "INSERT INTO event(num,subject,content,readcount,date,file,member_id,thumbnail,apply) values(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			// NoticeBean 객체로부터 데이터를 꺼내서 쿼리문 ? 대체
			pstmt.setInt(1, num); // 글번호
			pstmt.setString(2, eventBean.getSubject());
			pstmt.setString(3, eventBean.getContent());
			pstmt.setInt(4, eventBean.getReadcount());
			pstmt.setTimestamp(5, eventBean.getDate());
			pstmt.setString(6, eventBean.getFile());
			pstmt.setString(7, eventBean.getMember_id());
			pstmt.setString(8, eventBean.getThumbnail());
			pstmt.setString(9, eventBean.getApply());
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

	// 전체 게시물 수 조회
	public int selectListCount() {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// SELECT 구문을 사용하여 전체 게시물 수 조회
		// => count() 함수 사용, 조회 대상 컬럼 1개 지정하거나 * 사용
		try {
			String sql = "SELECT COUNT(num) FROM event";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 조회 결과가 있을 경우(= 게시물이 하나라도 존재하는 경우)
			// => 게시물 수를 listCount 에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("selectListCount() 오류! - " + e.getMessage());
			e.printStackTrace();
		}finally {
			// 자원 반환
			// 주의! DAO 클래스 내에서 Connection 객체 반환 금지!
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}

	
	// 게시물 목록 조회
	public ArrayList<EventBean> selectArticleList(int page, int limit) {
		// 지정된 갯수만큼의 게시물 조회 후 ArrayList 객체에 저장한 뒤 리턴
		ArrayList<EventBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;
		
		try {
			// 게시물 조회
			// 참조글번호(board_re_ref) 번호를 기준으로 내림차순 정렬,
			// 순서번호(board_re_seq) 번호를 기준으로 오름차순 정렬
			// 조회 시작 게시물 번호(startRow)부터 limit 갯수만큼 조회
			String sql = "SELECT * FROM event "
					+ "ORDER BY num DESC "
					+ "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			articleList = new ArrayList<EventBean>();
			
			// 읽어올 게시물이 존재할 경우 다음 작업 반복
			// => NoticeBean 객체를 생성하여 레코드 데이터 모두 저장 후
			//    NoticeBean 객체를 다시 ArrayList 객체에 추가
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 NoticeBean 객체 생성 및 데이터 저장
				EventBean article = new EventBean();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setDate(rs.getTimestamp("date")); // 여기 timestap 
				article.setFile(rs.getString("file"));
				article.setMember_id(rs.getString("member_id"));
				article.setThumbnail(rs.getString("thumbnail"));
				article.setApply(rs.getString("apply"));
				// 레코드 저장 확인용 코드
//				System.out.println("제목 : " + article.getSubject());
				
				// 1개 게시물을 전체 게시물 저장 객체(ArrayList)에 추가
				articleList.add(article);
			}
			
			
		} catch (SQLException e) {
			System.out.println("selectArticleList() 오류! - " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return articleList;
	}

	
	// 글 상세 내용 조회
	public EventBean selectArticle(int num) {
		EventBean article = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM event WHERE num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			// 게시물이 존재할 경우 EventBean 객체를 생성하여 게시물 내용 저장
			if(rs.next()) {
				article = new EventBean();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setDate(rs.getTimestamp("date"));
				article.setFile(rs.getString("file"));
				article.setMember_id(rs.getString("member_id"));
				article.setThumbnail(rs.getString("thumbnail"));
				article.setApply(rs.getString("apply"));
			}
			
		} catch (SQLException e) {
			System.out.println("selectArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return article;
	}

	// 조회수 증가
	public int updateReadcount(int num) {
		// 글번호(num)에 해당하는 게시물의 조회수(readcount)를 1 증가

		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "UPDATE event SET readcount=readcount+1 "
					+ "WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			updateCount = pstmt.executeUpdate();
			
			// 임시 확인용
//			System.out.println("조회수 증가 결과 : " + updateCount);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return updateCount;
	}

	public int updateArticle(EventBean article) {
		// PreviewBean 객체에 저장된 수정 내용(작성자, 제목, 내용)을 사용하여
		// 글번호(num)에 해당하는 레코드를 수정 후 결과 리턴
		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "UPDATE event SET subject=?,content=?,file=?,thumbnail=?,apply=? WHERE num=?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, article.getSubject());
			pstmt.setString(2, article.getContent());
			pstmt.setString(3, article.getFile());
			pstmt.setString(4, article.getThumbnail());
			pstmt.setString(5, article.getApply());
			pstmt.setInt(6, article.getNum());
			updateCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return updateCount;
	}

	public int deleteArticle(int num) {
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "DELETE FROM event WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("deleteArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return deleteCount;
	}


	public int selectListCount(String search) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int listCount = 0 ;
		
		try {
			
			
			String sql = "SELECT COUNT(*) FROM event where subject like ?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1,"%"+search+"%");
			rs = pstmt.executeQuery();
			
			// 조회 결과가 있을 경우(= 게시물이 하나라도 존재하는 경우)
			// => 게시물 수를 listCount 에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("selectListCount() 오류! - " + e.getMessage());
			e.printStackTrace();
		}finally {
			// 자원 반환
			// 주의! DAO 클래스 내에서 Connection 객체 반환 금지!
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	
	public ArrayList<EventBean> selectArticleList(int page, int limit, String search) {

		ArrayList<EventBean> articleList = null;

		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
//		System.out.println("글 검색2");
		
		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;
		
		try {
			// 게시물 조회
			// 참조글번호(board_re_ref) 번호를 기준으로 내림차순 정렬,
			// 순서번호(board_re_seq) 번호를 기준으로 오름차순 정렬
			// 조회 시작 게시물 번호(startRow)부터 limit 갯수만큼 조회
			String sql = "SELECT * FROM event where subject like ? "
					+ "ORDER BY num DESC "
					+ "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%"+search+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			articleList = new ArrayList<EventBean>();
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 NoticeBean 객체 생성 및 데이터 저장
				EventBean article = new EventBean();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setDate(rs.getTimestamp("date")); // 여기 timestap 
				article.setFile(rs.getString("file"));
				article.setMember_id(rs.getString("member_id"));
				article.setThumbnail(rs.getString("thumbnail"));
				article.setApply(rs.getString("apply"));
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
				articleList.add(article);
			}
			
			
		} catch (SQLException e) {
			System.out.println("selectArticleList() 오류! - " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return articleList;
	}	
	
}