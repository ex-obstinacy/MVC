package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.StoreBean;
import static db.JdbcUtil.*;

public class StoreDAO {
	/*
	 * 싱글톤 디자인 패턴을 활용한 BoardDAO 인스턴스 작업
	 * 1. 외부에서 인스턴스 생성(생성자 호출)이 불가능하도록
	 * 	생성자의 접근제한자를 private 으로 선언
	 * 2. 자신의 클래스 내에서 직접 인스턴스를 생성하여 멤버변수(instance)로 저장
	 * => 외부에서 변수에 접근하여 함부로 값을 변경하지 못하도록 접근제한자를 private 으로 선언
	 * => 멤버변수를 static 으로 선언하여 외부에서 객체 생성 없이 접근할 수 있도록 함
	 * 3. 생성된 인스턴스를 외부로 리턴하는 Getter 메서드(getInstance)를 정의
	 * => 파라미터 : 없음, 리턴타입 : BoardDAO 
	 * => static 변수를 리턴하므로 Getter 메서드도 static 으로 선언
	 */
	private StoreDAO() {}
	
	private static StoreDAO instance = new StoreDAO();
	
	public static StoreDAO getInstance() {
		return instance;
	}
	
	//========================================================================
	
	Connection con; //Connection 객체를 전달받아 저장할 멤버변수
	
	// 외부(Service 클래스)로 부터 Connection 객체를 전달받아
	// 멤버변수에 저장하는 setConnection() 메서드 정의

	public void setConnection(Connection con) {
		this.con = con;
	}
	
	// 글 등록 작업
		public int insertArticle(StoreBean storeBean) {
			// Service 클래스로 부터 BoardBean 객체를 전달받아
			// DB의 board 테이블에 insert 작업 수행하고 결과(int) 리턴
			System.out.println("StoreDAO - insertArticle()");
			int insertCount = 0; // INSERT 작업 수행 결과를 저장할 변수
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int goodsId =1; //글번호를 저장할 변수
			
			try {
				// 현재 게시물 번호(Id) 중 가장 큰 번호를 조회하여
				// 해당 번호 +1값을 새 글 번호(goodsId)로 저장
				
				String sql ="select max(goodsId) from goods";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery(); //리턴 타입 resultSet
				
				//조회된 결과가 있을 경우 조회된 번호 +1의 값을 num에 저장
				//조회된 결과가 없을 경우 새 글 번호는 1번이므로 기본값 그대로 사용
				if (rs.next()) {
					goodsId = rs.getInt(1) + 1; // 새 글 번호 만들기
				} 
				System.out.println("1");
				// 전달 받은 StoreBean 객체 내의 데이터를 사용하여 insert 작업 수행
				sql = "insert into goods values(?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				
				// StoreBean 객체로부터 데이터를 꺼내서 쿼리문 ? 대체
				pstmt.setInt(1, goodsId);
				pstmt.setString(2, storeBean.getCtg());
				pstmt.setString(3, storeBean.getName());
				pstmt.setInt(4, storeBean.getPrice());
				pstmt.setInt(5, storeBean.getSale());
				pstmt.setString(6, storeBean.getComponent());
				pstmt.setInt(7, storeBean.getSellCount());
				pstmt.setString(8, storeBean.getFile());
				pstmt.setString(9, storeBean.getContent());
				
				//insert 구문 실행 결과값을 int형 변수 insertCount에 저장
				insertCount = pstmt.executeUpdate();
				
				//임시 확인용
				System.out.println("storeDAO에서 check! 글이 입력되었나? : " + insertCount);
				
			} catch (SQLException e) {
				System.out.println("insertArticle() 오류!- "+e.getMessage());
				e.printStackTrace();
			} finally {
				// 자원 반환
				// 주의! DAO 클래스 내에서 Connection 객체 반환 금지!
				// service 에서 commit, rollback에 쓰임
//				JdbcUtil.close(rs);
//				JdbcUtil.close(pstmt);
				close(rs);
				close(pstmt);
			}
			
			return insertCount;
		}
		
		//전체 게시물 수 조회
		public int selectListCount() {
			int listCount = 0;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				// SELECT 구문을 사용하여 전체 게시물 수 조회
				// => count() 함수 사용, 조회 대상 컬럼 1개 지정하거나 * 사용
				String sql= "select count(goodsId) from goods";
				pstmt = con.prepareStatement(sql);
				rs= pstmt.executeQuery();
				
				// 조회 결과가 있을 경우(= 게시물이 하나라도 존재하는 경우)
				// => 게시물 수를 listCount에 저장
				if (rs.next()) {
					listCount = rs.getInt(1);
				}
				
				//임시 확인용
				System.out.println("storeDAO에서 check! 전체 게시물 수 : " + listCount);
				
			} catch (SQLException e) {
				System.out.println("selectListCount() 오류!- "+e.getMessage());
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
			
			return listCount;
		}
		
		//게시물 목록 조회
		public ArrayList<StoreBean> selectArticleList(int page, int limit) {
			// 지정된 갯수만큼의 게시물 조회 후 ArrayList 객체에 저장한 뒤 리턴
			ArrayList<StoreBean> articleList = null;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			// 조회를 시작할 레코드(행) 번호 계산
			int startRow = (page - 1) * limit;
			
			try {
				// 게시물 조회
				// 참조글 번호(goodsId) 번호를 기준으로 내림차순 정렬.
				// 조회 시작 게시물 번호(startRow)를 기준으로 limit 갯수만큼 조회
				String sql ="select * from goods order by goodsId limit ?,?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, limit);
				
				rs= pstmt.executeQuery();
				
				//ArrayList 객체 생성(while문 위에서 생성 필수!)
				articleList = new ArrayList<StoreBean>();
				
				// 읽어올 게시물이 존재할 경우 다음 작업 반복 
				// BoardBean 객체를 생성하여 레코드 데이터 모두 저장 후
				// BoardBean 객체를 다시 ArrayList 객체에 추가 => 반복
				while(rs.next()) {
					// 1개 게시물 정보를 저장할 BoardBean 객체 생성 및 데이터 저장
					StoreBean article = new StoreBean(); 
					
					article.setGoodsId(rs.getInt("goodsId"));
					article.setCtg(rs.getString("ctg"));
					article.setName(rs.getString("name"));
					article.setPrice(rs.getInt("price"));
					article.setSale(rs.getInt("sale"));
					article.setComponent(rs.getString("component"));
					article.setSellCount(rs.getInt("sellCount"));
					article.setFile(rs.getString("file"));
					article.setContent(rs.getString("content"));
					
					// 레코드 저장 확인용 코드
					System.out.println("storeDAO에서 check - "+article.getName());
					
					// 1개 게시물을 전체 게시물 저장 객체(ArrayList)에 추가
					articleList.add(article);
				}
				
				
			} catch (SQLException e) {
				System.out.println("selectArticleList() 오류!- "+e.getMessage());
				e.printStackTrace();
			} finally {
				close(pstmt);
				close(rs);
			}
			
			return articleList;
		}
		
		// 게시물 상세내용 조회
		public StoreBean selectArticle(int goodsId) {
			// 글번호(goodsId)에 해당하는 레코드를 SELECT
			// 조회 결과가 있을 경우 StoreBean 객체에 저장한 뒤 리턴
			System.out.println("selectArticle() ");
			StoreBean article = null;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "select * from goods where goodsId=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, goodsId);
				rs = pstmt.executeQuery();
				
				// 게시물이 존재할 경우 Store 객체를 생성하여 게시물 내용 저장
				if(rs.next()) {
					article = new StoreBean();
					article.setGoodsId(rs.getInt("goodsId"));
					article.setCtg(rs.getString("ctg"));
					article.setName(rs.getString("name"));
					article.setPrice(rs.getInt("price"));
					article.setSale(rs.getInt("sale"));
					article.setComponent(rs.getString("component"));
					article.setSellCount(rs.getInt("sellCount"));
					article.setFile(rs.getString("file"));
					article.setContent(rs.getString("content"));
					
					// 임시 확인용 상세 내용 출력
					System.out.println("글제목 : " + article.getName());
				}
			} catch (SQLException e) {
				System.out.println("selectArticle() 오류 : " + e.getMessage());
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
			
			return article;
		}

	
} //메인메서드

