package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import vo.MemberBean;
import vo.StoreBean;
import static db.JdbcUtil.*;

public class StoreDAO {

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
//            JdbcUtil.close(rs);
//            JdbcUtil.close(pstmt);
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
               System.out.println("storeDAO - selectArticleList()에서 check - "+article.getName());
               
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
         System.out.println("StoreDAO - selectArticle()");
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
               System.out.println("storeDAO - selectArticle()에서 check - 글제목 : " + article.getName());
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

      // 장바구니 담기
      public int addBasket(int basketCount, int goodsId, String id) {
         System.out.println("StoreDAO - addBasket()");
         
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int addCount = 0;
//         null 1 basketCOunt
         Timestamp date = new Timestamp(System.currentTimeMillis());
         
         try {
        	 int basketId = 0;
        	 
        	 String sql = "SELECT * FROM basket WHERE goods_goodsId=? AND member_id=?";
        	 pstmt = con.prepareStatement(sql);
        	 pstmt.setInt(1, goodsId);
        	 pstmt.setString(2, id);
        	 rs = pstmt.executeQuery();
        	 
        	 if(basketCount == 0) {
        		 basketCount = 1;
        	 }
        	 if (rs.next()) {
				sql = "UPDATE basket SET basketCount=basketCount+? WHERE goods_goodsId=? AND member_id=?";
	        	 pstmt = con.prepareStatement(sql);
	        	 pstmt.setInt(1, basketCount);
	        	 pstmt.setInt(2, goodsId);
	        	 pstmt.setString(3, id);
	        	 addCount = pstmt.executeUpdate();
	        	 
        	} else {
        		sql = "SELECT MAX(basketId) FROM basket";
        		pstmt = con.prepareStatement(sql);
        		rs = pstmt.executeQuery();
        		
        		if (rs.next()) {
        			basketId = rs.getInt(1) +1;
					
				}
        		
				sql = "INSERT INTO basket(basketId, goods_goodsId, basketCount, member_id, date) VALUES(?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, basketId);
				pstmt.setInt(2, goodsId);
				pstmt.setInt(3, 1);
				pstmt.setString(4, id);
				pstmt.setTimestamp(5, date);
				addCount = pstmt.executeUpdate();
        		
			}
        	 
         } catch (Exception e) {
            System.out.println("addBasket() 오류! - " + e.getMessage());
            e.printStackTrace();
            
         } finally {
            close(rs);
            close(pstmt);
            
         }
         
         return addCount;
      }

      // 장바구니 목록 조회
      public ArrayList<StoreBean> selectBasketList(String id) {
            System.out.println("selectBasketList DAO");
    	  	ArrayList<StoreBean> basketList = null;
            
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
            	String sql = "SELECT basket.basketCount, basket.basketId, basket.member_id, basket.goods_goodsId, " 
            				+ "goods.name, goods.price, goods.sale, goods.component, goods.file, goods.content, goods.ctg "
            				+ "FROM goods JOIN basket "
            				+ "ON goods.goodsId = basket.goods_goodsId "
            				+ "WHERE member_id = ?";
            	pstmt = con.prepareStatement(sql);
            	pstmt.setString(1, id);
            	rs = pstmt.executeQuery();
               
               //ArrayList 객체 생성(while문 위에서 생성 필수!)
               basketList = new ArrayList<StoreBean>();
               
               // 읽어올 게시물이 존재할 경우 다음 작업 반복 
               // StoreBean 객체를 생성하여 레코드 데이터 모두 저장 후  StoreBean 객체를 다시 ArrayList 객체에 추가 => 반복
               while(rs.next()) {
                  // 1개 게시물 정보를 저장할 StoreBean 객체 생성 및 데이터 저장
                  StoreBean basket = new StoreBean(); 
                    
                  //basket 테이블
                  basket.setBasketCount(rs.getInt("basketCount"));
                  basket.setBasketId(rs.getInt("basketId"));
                  basket.setGoods_goodsId(rs.getInt("goods_goodsId"));
                  basket.setMember_id(id);
                  //goods 테이블
                  basket.setCtg(rs.getString("ctg"));
                  basket.setName(rs.getString("name"));
                  basket.setPrice(rs.getInt("price"));
                  basket.setSale(rs.getInt("sale"));
                  basket.setComponent(rs.getString("component"));
                  basket.setFile(rs.getString("file"));
                  basket.setContent(rs.getString("content"));
                  
                  System.out.println(basket.getGoods_goodsId());
                  
                  // 1개 게시물을 전체 게시물 저장 객체(ArrayList)에 추가
                  basketList.add(basket);
               }
               
            } catch (SQLException e) {
               System.out.println("selectBasketList() 오류!- "+e.getMessage());
               e.printStackTrace();
            } finally {
               close(pstmt);
               close(rs);
            }
            return basketList;
         }
      
      // 글 수정
      public int updateArticle(StoreBean article) {
  		// StoreBean 객체에 저장된 수정 내용(작성자, 제목, 내용)을 사용하여
  		// 상품번호(goodsId)에 해당하는 레코드를 수정 후 결과 리턴
  		int updateCount =0;
  		PreparedStatement pstmt = null;
  		
  		try {
  			String sql = "update goods set ctg=?, name=?, price=?, sale=?, component=?, sellCount=?, file=?, content=? where goodsId=?";
  			pstmt = con.prepareStatement(sql);
  			pstmt.setString(1, article.getCtg());
  			pstmt.setString(2, article.getName());
  			pstmt.setInt(3, article.getPrice());
            pstmt.setInt(4, article.getSale());
            pstmt.setString(5, article.getComponent());
            pstmt.setInt(6, article.getSellCount());
            pstmt.setString(7, article.getFile());
            pstmt.setString(8, article.getContent());
            pstmt.setInt(9, article.getGoodsId());
  			
  			updateCount = pstmt.executeUpdate();
  			
  			//임시 확인용
  			System.out.println("GoodsDAO에서 check! 수정되었는가? : " + updateCount);
  			
  		} catch (SQLException e) {
  			System.out.println("updateArticle() 오류!- "+e.getMessage());
  			
  			e.printStackTrace();
  		} finally {
  			close(pstmt);
  		}
  		
  		
  		return updateCount;
  	}
      
   // 글 삭제
   		public int deleteArticle(int goodsId) {
   			// StoreBean 객체에 저장된 내용을 사용하여
   			// 상품번호(goodsId)에 해당하는 레코드를 삭제 후 결과 리턴
   			int deleteCount =0;
   			PreparedStatement pstmt = null;
   			
   			try {
   				String sql = "delete from goods where goodsId=?";
   				pstmt = con.prepareStatement(sql);
   				pstmt.setInt(1, goodsId );
   				
   				deleteCount = pstmt.executeUpdate();
   				
   				//임시 확인용
   				System.out.println("storeDAO - deleteArticle 에서 check! 삭제되었는가? : " + deleteCount);
   				
   			} catch (SQLException e) {
   				System.out.println("deleteArticle() 오류!- "+e.getMessage());
   				
   				e.printStackTrace();
   			} finally {
   				close(pstmt);
   			}
   			  			
   			return deleteCount;
   		}

      
   
} //메인메서드
