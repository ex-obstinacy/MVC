package dao;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;

import vo.ApplyBean;
import vo.WinBean;


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

	public boolean isOverlapApply(String member_id, int event_num) {

		boolean isOverlap = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from apply where member_id=? and event_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, event_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("이미 응모한 이벤트입니다.");
				isOverlap = false;
			}else {
				isOverlap = true;
			}
			
		} catch (SQLException e) {
			System.out.println("isOverlapApply 오류 ! -" + e.getMessage());
			e.printStackTrace();
		}
		// 자원 반환
		// 주의! DAO 클래스 내에서 Connection 객체 반환 금지!
		close(rs);
		close(pstmt);
		
		return isOverlap;
	}

	public ArrayList<ApplyBean> selectArticleList(int event_num) {
		
		ArrayList<ApplyBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 게시물 조회
			// 참조글번호(board_re_ref) 번호를 기준으로 내림차순 정렬,
			// 순서번호(board_re_seq) 번호를 기준으로 오름차순 정렬
			// 조회 시작 게시물 번호(startRow)부터 limit 갯수만큼 조회
			String sql = "SELECT num, date, win, member_id, event_num FROM apply "
					+ "where event_num = ? ";
					
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, event_num);
			rs = pstmt.executeQuery();
			
			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			articleList = new ArrayList<ApplyBean>();
			
			// 읽어올 게시물이 존재할 경우 다음 작업 반복
			// => NoticeBean 객체를 생성하여 레코드 데이터 모두 저장 후
			//    NoticeBean 객체를 다시 ArrayList 객체에 추가
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 NoticeBean 객체 생성 및 데이터 저장
				ApplyBean article = new ApplyBean();
				article.setNum(rs.getInt("num"));
				article.setDate(rs.getTimestamp("date"));
				article.setWin(rs.getInt("win"));
				article.setMember_id(rs.getString("member_id"));
				article.setEvent_num(rs.getInt("event_num"));
	
				
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

	// win -> 1 로 update 하는 메서드
	public int updateArticle(int win_member_num) {
		
		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "UPDATE apply SET win=1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, win_member_num);
			updateCount = pstmt.executeUpdate();
//			ApplyBean article = new ApplyBean();
		} catch (Exception e) {
			System.out.println("updateArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return updateCount;
	}

	public ArrayList<WinBean> getWinMemberInfo(Set<Integer> win_members) {
		
		ArrayList<WinBean> winMemberList = null;
		WinBean win_member = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 가져온 당첨자들num을 하나씩 쪼개기
			Iterator<Integer> ite = win_members.iterator();
			winMemberList = new ArrayList<WinBean>();
			
			while(ite.hasNext()) {
				// 당첨자 1명 꺼내서 정보 저장하기
				int o = (int) ite.next();
//				System.out.println("당첨자번호 : " + o)

				String sql = "SELECT * FROM apply WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, o);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					win_member = new WinBean();
					win_member.setMember_id(rs.getString("member_id"));
					win_member.setEvent_num(rs.getInt("event_num"));
					winMemberList.add(win_member);
				}
//				System.out.println(winMemberList);
			}
			
		} catch (Exception e) {
			System.out.println("getWinMemberInfo() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return winMemberList;
	}



}
