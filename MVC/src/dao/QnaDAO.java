package dao;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.QnaBean;

public class QnaDAO {

	private QnaDAO() {
	}

	private static QnaDAO instance = new QnaDAO();

	public static QnaDAO getInstance() {
		return instance;
	}

	Connection con; // Connection 객체를 전달받아 저장할 멤버변수

	// 외부(Service 클래스)로부터 Connection 객체를 전달받아
	// 멤버변수에 저장하는 setConnection() 메서드 정의
	public void setConnection(Connection con) {
		this.con = con;
	}

	// 글 등록 작업
	public int insertArticle(QnaBean qnaBean) {
		// Service 클래스로부터 NoticeBean 객체를 전달받아
		// DB의 board 테이블에 INSERT 작업 수행하고 결과(int타입)를 리턴
//		System.out.println("QnaDAO - insertArticle()");
		int insertCount = 0; // INSERT 작업 수행 결과를 저장할 변수

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num = 1; // 새 글 번호를 저장할 변수

		try {
			// 현재 게시물 번호(num) 중 가장 큰 번호를 조회하여
			// 해당 번호 + 1 값을 새 글 번호(num)으로 저장
			String sql = "SELECT MAX(num) FROM qna";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			// 조회된 결과가 있을 경우 조회된 번호 + 1 값을 num 에 저장
			// => 조회 결과가 없을 경우 새 글 번호는 1번이므로 기본값 그대로 사용

			if (rs.next()) {
				num = rs.getInt(1) + 1; // 새 글 번호 만들기
			}

			// 전달받은 NoticeBean 객체 내의 데이터를 사용하여 INSERT 작업 수행
			// => 컬럼 중 date 항목(작성일)은 now() 함수 사용
			sql = "INSERT INTO qna(num,subject,content,readcount,date,file,re_ref,re_lev,re_seq,member_id,p_member_id) values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			// NoticeBean 객체로부터 데이터를 꺼내서 쿼리문 ? 대체
			pstmt.setInt(1, num); // 글번호
			
			pstmt.setString(2, qnaBean.getSubject());
			pstmt.setString(3, qnaBean.getContent());
			pstmt.setInt(4, qnaBean.getReadcount());
			pstmt.setTimestamp(5, qnaBean.getDate());
			pstmt.setString(6, qnaBean.getFile());
			pstmt.setInt(7, num);
			pstmt.setInt(8, qnaBean.getRe_lev());
			pstmt.setInt(9, qnaBean.getRe_seq());
			pstmt.setString(10, qnaBean.getMember_id());
			pstmt.setString(11, qnaBean.getMember_id());
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

		try {
			// SELECT 구문을 사용하여 전체 게시물 수 조회
			// => count() 함수 사용, 조회 대상 컬럼 1개 지정하거나 * 사용
			String sql = "SELECT COUNT(num) FROM qna";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			// 조회 결과가 있을 경우(= 게시물이 하나라도 존재하는 경우)
			// => 게시물 수를 listCount 에 저장
			if (rs.next()) {
				listCount = rs.getInt(1);
			}

		} catch (SQLException e) {
			System.out.println("selectListCount() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			// 자원 반환
			// 주의! DAO 클래스 내에서 Connection 객체 반환 금지!
			close(rs);
			close(pstmt);
		}

		return listCount;
	}

	// 게시물 목록 조회
	public ArrayList<QnaBean> selectArticleList(int page, int limit) {
		// 지정된 갯수만큼의 게시물 조회 후 ArrayList 객체에 저장한 뒤 리턴
		
//		System.out.println("selectArticleList1 확인 (기본)");
		
		ArrayList<QnaBean> articleList = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;

		try {
			// 게시물 조회
			// 참조글번호(board_re_ref) 번호를 기준으로 내림차순 정렬,
			// 순서번호(board_re_seq) 번호를 기준으로 오름차순 정렬
			// 조회 시작 게시물 번호(startRow)부터 limit 갯수만큼 조회
			String sql = "SELECT * FROM qna " + "ORDER BY re_ref DESC,re_seq ASC " + "LIMIT ?,?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();

			// ArrayList 객체 생성(while문 위에서 생성 필수!)
			articleList = new ArrayList<QnaBean>();

			// 읽어올 게시물이 존재할 경우 다음 작업 반복
			// => BoardBean 객체를 생성하여 레코드 데이터 모두 저장 후
			// BoardBean 객체를 다시 ArrayList 객체에 추가
			// => 단, 패스워드(board_pass) 는 제외
			while (rs.next()) {
				// 1개 게시물 정보를 저장할 BoardBean 객체 생성 및 데이터 저장
				QnaBean article = new QnaBean();
				article.setNum(rs.getInt("num"));
				
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setFile(rs.getString("file"));
				article.setRe_ref(rs.getInt("re_ref"));
				article.setRe_lev(rs.getInt("re_lev"));
				article.setRe_seq(rs.getInt("re_seq"));
				article.setDate(rs.getTimestamp("date"));
				
				article.setMember_id(rs.getString("member_id"));
				article.setP_member_id(rs.getNString("p_member_id"));
//				System.out.println("원글쓴이 : "+article.getP_member_id());

				// 레코드 저장 확인용 코드
//				System.out.println("제목 : " + article.getBoard_subject());

				// 1개 게시물을 전체 게시물 저장 객체(ArrayList)에 추가
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

	// qna 상세 내용 조회
	public QnaBean selectArticle(int num) {
		// 글번호(num)에 해당하는 레코드를 SELECT
		// 조회 결과가 있을 경우 QnaBean 객체에 저장한 뒤 리턴
		QnaBean article = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT * FROM qna WHERE num=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			// 게시물이 존재할 경우 QnaBean 객체를 생성하여 게시물 내용 저장
			if (rs.next()) {
				article = new QnaBean();
				article.setNum(rs.getInt("num"));
				
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setFile(rs.getString("file"));
				article.setRe_ref(rs.getInt("re_ref"));
				article.setRe_lev(rs.getInt("re_lev"));
				article.setRe_seq(rs.getInt("re_seq"));
				article.setDate(rs.getTimestamp("date"));
				article.setMember_id(rs.getString("member_id"));
				article.setP_member_id(rs.getString("p_member_id"));
				System.out.println("num : " + num);
				System.out.println("re_ref : " + num);
				System.out.println("re_lev : " + num);
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
			String sql = "UPDATE qna SET readcount=readcount+1 " + "WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			updateCount = pstmt.executeUpdate();

			// 임시 확인용
//			System.out.println("조회수 증가 결과 : " + updateCount);
		} catch (SQLException e) {
			System.out.println("updateReadcount() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return updateCount;
	}

	// 글수정
	public int updateArticle(QnaBean article) {
		// QnaBean 객체에 저장된 수정 내용(작성자, 제목, 내용)을 사용하여
		// 글번호(num)에 해당하는 레코드를 수정 후 결과 리턴

		int updateCount = 0;

		PreparedStatement pstmt = null;

		try {
			String sql = "UPDATE qna SET subject=?,content=?,file=? WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article.getSubject());
			pstmt.setString(2, article.getContent());
			pstmt.setString(3, article.getFile());
			pstmt.setInt(4, article.getNum());
			updateCount = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("updateArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return updateCount;
	}

	// 답글 삭제(답글만 삭제)
	public int deleteReplyArticle(int num) {
		int deleteCount = 0;
		PreparedStatement pstmt = null;

		try {
			
			String sql = 
					"DELETE FROM qna WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("deleteReplyArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return deleteCount;
	}
	
	// 원글 삭제 (해당하는 답글도 같이 삭제)
	public int deleteArticle(int re_ref) {
		
		int deleteCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			String sql = 
					"DELETE FROM qna where re_ref=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("deleteArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return deleteCount;
	}


	// 답글 등록
	public int insertReplyArticle(QnaBean article) {
		int insertCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 현재 게시물 목록의 최대 글번호(board_num)를 조회하여
			// 조회된 번호 + 1 값을 새 글 번호(num)에 저장
			int num = 1; // 답글의 새 글 번호

			String sql = "SELECT MAX(num) FROM qna";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) { // 등록된 게시물이 하나라도 존재할 경우
				num = rs.getInt(1) + 1; // 새 글 번호 = 현재 가장 큰 번호 + 1
			}

//			System.out.println("답글 번호 : " + num);

			/*
			 * 답변글 작성 시 글목록에서 표시되는 정렬 방법 SELECT * FROM board ORDER BY board_re_ref
			 * DESC,board_re_seq ASC => board_re_ref 기준 내림차순, board_re_seq 기준 오름차순 정렬
			 * 
			 * ---------------------------------------------------------------- 원본번호 새번호
			 * 참조글번호 순서번호 들여쓰기 | | board_num | num | board_re_ref | board_re_seq |
			 * board_re_lev |
			 * ---------------------------------------------------------------- | 없음 3 3 0 0
			 * | 없음 2 2 0 0 | 없음 1 1 0 0
			 * ---------------------------------------------------------------- >>> 3번 게시물에
			 * 대한 답글 작성 시(답글 번호를 4번이라고 가정) <<< => 원본글 3번의 참조글번호를 답글의 참조글번호로 설정 => 원본글 참조글번호와
			 * 같고, 순서번호가 더 큰 게시물이 없으므로 답글의 순서번호는 원본글의 순서번호 + 1 로 설정(1로 설정) => 들여쓰기 레벨도 원본글
			 * 들여쓰기레벨 + 1 로 설정(1로 설정)
			 * ---------------------------------------------------------------- 원본번호 새번호
			 * 참조글번호 순서번호 들여쓰기 | | board_num | num | board_re_ref | board_re_seq |
			 * board_re_lev |
			 * ---------------------------------------------------------------- | 없음 3 3 0 0
			 * | 3 4 3 1 1 | 없음 2 2 0 0 | 없음 1 1 0 0
			 * ----------------------------------------------------------------
			 * 
			 * >>> 3번 게시물에 대한 답글 작성 시(답글 번호를 5번이라고 가정) <<< => 원본글 3번의 참조글번호를 답글의 참조글번호로 설정
			 * => 원본글 참조글번호와 같고, 순서번호가 더 큰 게시물이 4번 글이므로 4번 글의 순서번호를 + 1 시킴(1 -> 2로 변경됨) 새
			 * 답글의 순서번호는 원본글의 순서번호 + 1 로 설정(1로 설정) => 들여쓰기 레벨도 원본글 들여쓰기레벨 + 1 로 설정(1로 설정)
			 * ---------------------------------------------------------------- 원본번호 새번호
			 * 참조글번호 순서번호 들여쓰기 | | board_num | num | board_re_ref | board_re_seq |
			 * board_re_lev |
			 * ---------------------------------------------------------------- | 없음 3 3 0 0
			 * 3 5 3 1 1 | 3 4 3 2 1 | 없음 2 2 0 0 | 없음 1 1 0 0
			 * ----------------------------------------------------------------
			 *
			 * >>> 3번 게시물에 대한 답글 작성 시(답글 번호를 6번이라고 가정) <<< => 원본글 3번의 참조글번호를 답글의 참조글번호로 설정
			 * => 원본글 참조글번호와 같고, 순서번호가 더 큰 게시물이 4,5번 글이므로 4번, 5번 글의 순서번호를 + 1 시킴(1 -> 2, 2
			 * -> 3 으로 변경됨) 새 답글의 순서번호는 원본글의 순서번호 + 1 로 설정(1로 설정) => 들여쓰기 레벨도 원본글 들여쓰기레벨 + 1
			 * 로 설정(1로 설정) ----------------------------------------------------------------
			 * 원본번호 새번호 참조글번호 순서번호 들여쓰기 | | board_num | num | board_re_ref | board_re_seq |
			 * board_re_lev |
			 * ---------------------------------------------------------------- | 없음 3 3 0 0
			 * 3 6 3 1 1 3 5 3 2 1 | 3 4 3 3 1 | 없음 2 2 0 0 | 없음 1 1 0 0
			 * ---------------------------------------------------------------- >>> 3번에 대한
			 * 답글인 5번에 대한 답글을 작성할 경우(7번이라고 가정) => 원본글 5번의 참조글번호(3)를 자신의 참조글번호로 사용 => 원본글 5번과
			 * 동일한 참조글번호 중 순서번호가 큰 4번글 순서번호 + 1 (3 -> 4) => 새 답글의 순서번호는 원본글 5번 순서번호(2) + 1 로
			 * 설정 => 새 답글의 들여쓰기레벨은 원본들 5번 들여쓰기레벨(1) + 1 로 설정
			 * ---------------------------------------------------------------- 원본번호 새번호
			 * 참조글번호 순서번호 들여쓰기 | | board_num | num | board_re_ref | board_re_seq |
			 * board_re_lev |
			 * ---------------------------------------------------------------- | 없음 | 3 | 3
			 * | 0 | 0 | | 3 | 6 | 3 | 1 | 1 | | 3 | 5 | 3 | 2 | 1 | 5 7 3 3 2 | 없음 | 4 | 3
			 * | 4 | 1 | | 없음 | 2 | 2 | 0 | 0 | | 없음 | 1 | 1 | 0 | 0 |
			 * ----------------------------------------------------------------
			 */

			int re_ref = article.getRe_ref(); // 기존글 참조번호
			int re_lev = article.getRe_lev(); // 기존글 들여쓰기 값
			int re_seq = article.getRe_seq(); // 기존글 순서번호

			// 기존 답글들에 대한 순서 번호 증가
			// => board_re_ref 가 전달받은 값과 같고
			// board_re_seq 가 전달받은 값보다 큰 게시물들의
			// board_re_seq 번호를 1씩 증가시키기
			sql = "UPDATE qna SET re_seq=re_seq+1 " + "WHERE re_ref=? AND re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setInt(2, re_seq);
			pstmt.executeUpdate();

			// 새 답글에 대한 순서 번호와 들여쓰기 레벨 설정
			// => 순서번호와 들여쓰기레벨은 기존 글 순서번호, 들여쓰기레벨 + 1
			re_lev += 1;
			re_seq += 1;

			// 답변글에 대한 INSERT 작업 수행
			sql = "INSERT INTO qna VALUES(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getContent());
			pstmt.setInt(4, 0);
			pstmt.setString(5, ""); // 파일업로드 생략
			pstmt.setInt(6, re_ref);
			pstmt.setInt(7, re_lev);
			pstmt.setInt(8, re_seq);
			pstmt.setTimestamp(9, article.getDate());
			pstmt.setString(10, article.getMember_id());
			pstmt.setNString(11, article.getP_member_id());
			insertCount = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("insertReplyArticle() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return insertCount;
	}

	// 글 검색
	public int selectListCount(String search) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int listCount = 0;

		System.out.println("글 검색1");

		try {

			String sql = "SELECT COUNT(*) FROM qna where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();

			// 조회 결과가 있을 경우(= 게시물이 하나라도 존재하는 경우)
			// => 게시물 수를 listCount 에 저장
			if (rs.next()) {
				listCount = rs.getInt(1);
			}

		} catch (SQLException e) {
			System.out.println("selectListCount() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			// 자원 반환
			// 주의! DAO 클래스 내에서 Connection 객체 반환 금지!
			close(rs);
			close(pstmt);
		}

		return listCount;
	}

	
	// 글 검색 (로그인한 id가 damin 일때 
	public ArrayList<QnaBean> selectArticleList(int page, int limit, String search) {

		
		
		ArrayList<QnaBean> articleList = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

//		System.out.println("글 검색 2 ");

		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;

		try {
			// 게시물 조회
			// 참조글번호(board_re_ref) 번호를 기준으로 내림차순 정렬,
			// 순서번호(board_re_seq) 번호를 기준으로 오름차순 정렬
			// 조회 시작 게시물 번호(startRow)부터 limit 갯수만큼 조회
			String sql = "SELECT * FROM qna where subject like ? " + "ORDER BY re_ref DESC,re_seq ASC " + "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();

			articleList = new ArrayList<QnaBean>();

			while (rs.next()) {
				// 1개 게시물 정보를 저장할 NoticeBean 객체 생성 및 데이터 저장
				QnaBean article = new QnaBean();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setDate(rs.getTimestamp("date")); // 여기 timestap
				article.setFile(rs.getString("file"));
				article.setRe_ref(rs.getInt("re_ref"));
				article.setRe_lev(rs.getInt("re_lev"));
				article.setRe_seq(rs.getInt("re_seq"));
				article.setMember_id(rs.getString("member_id"));
				article.setP_member_id(rs.getString("p_member_id"));
				// ArrayList 객체 생성(while문 위에서 생성 필수!)
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

	// 글 목록 조회 (일반회원일때)
	public ArrayList<QnaBean> selectUserArticleList(String id, int page, int limit) {

		System.out.println("QnaDAO - selectArticleList2확인()");

		// 이거를 컨트롤러 어디서 호출하는거
//		이해못함
		// 얘 selectArticleList2 함수 인자 보면 페이지,리미트,아이디를 받아오는데
		// 얘를 어디서 호출ㅇ하는건지 알아야할듯

		ArrayList<QnaBean> articleList = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int startRow = (page - 1) * limit;



		try {
			// 게시물 조회
			// 참조글번호(board_re_ref) 번호를 기준으로 내림차순 정렬,
			// 순서번호(board_re_seq) 번호를 기준으로 오름차순 정렬
			// 조회 시작 게시물 번호(startRow)부터 limit 갯수만큼 조회
			// 여기 물음표 같으면 출력
			System.out.println("실행확인");
			String sql = "SELECT * FROM qna where p_member_id =? " + "ORDER BY re_ref DESC,re_seq ASC " + "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();

			articleList = new ArrayList<QnaBean>();

			while (rs.next()) {
				// 1개 게시물 정보를 저장할 NoticeBean 객체 생성 및 데이터 저장
				QnaBean article = new QnaBean();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setDate(rs.getTimestamp("date")); // 여기 timestap
				article.setFile(rs.getString("file"));
				article.setRe_ref(rs.getInt("re_ref"));
				article.setRe_lev(rs.getInt("re_lev"));
				article.setRe_seq(rs.getInt("re_seq"));
				article.setMember_id(rs.getString("member_id"));
				article.setP_member_id(rs.getString("p_member_id"));
				// ArrayList 객체 생성(while문 위에서 생성 필수!)
				
//				System.out.println("원글쓴이 : "+article.getP_member_id());
				articleList.add(article);
			}

		} catch (SQLException e) {
			System.out.println("selectArticleList2() 오류! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return articleList;
		
	}

	// 글 검색 (로그인한 id가 damin 일때 (일반회원일때)
	public ArrayList<QnaBean> selectUserArticleList(String id, int page, int limit, String search) {
		
		ArrayList<QnaBean> articleList = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

//		System.out.println("글 검색 2 ");

		// 조회를 시작할 레코드(행) 번호 계산
		int startRow = (page - 1) * limit;

		try {
			// 게시물 조회
			// 참조글번호(board_re_ref) 번호를 기준으로 내림차순 정렬,
			// 순서번호(board_re_seq) 번호를 기준으로 오름차순 정렬
			// 조회 시작 게시물 번호(startRow)부터 limit 갯수만큼 조회
			String sql = "SELECT * FROM qna where p_member_id =? and subject like ? " + "ORDER BY re_ref DESC,re_seq ASC " + "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, "%" + search + "%");
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, limit);
			rs = pstmt.executeQuery();

			articleList = new ArrayList<QnaBean>();

			while (rs.next()) {
				// 1개 게시물 정보를 저장할 NoticeBean 객체 생성 및 데이터 저장
				QnaBean article = new QnaBean();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setDate(rs.getTimestamp("date")); // 여기 timestap
				article.setFile(rs.getString("file"));
				article.setRe_ref(rs.getInt("re_ref"));
				article.setRe_lev(rs.getInt("re_lev"));
				article.setRe_seq(rs.getInt("re_seq"));
				article.setMember_id(rs.getString("member_id"));
				article.setP_member_id(rs.getString("p_member_id"));
				// ArrayList 객체 생성(while문 위에서 생성 필수!)
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
