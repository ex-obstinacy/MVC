package dao;

import java.sql.Connection;
import java.util.Date;
import java.util.Random;
import java.util.TimeZone;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
   
   // ---------------------- 관리자 ----------------------
   
      // 상품 등록 작업
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
      
      //전체 상품수 조회
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
      
      // 상품 목록 조회
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
      
      // 상품 상세내용 조회
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

      // 상품 수정
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
  			System.out.println("StoreDAO에서 check! 수정되었는가? : " + updateCount);
  			
  		} catch (SQLException e) {
  			System.out.println("updateArticle() 오류!- "+e.getMessage());
  			
  			e.printStackTrace();
  		} finally {
  			close(pstmt);
  		}
  		
  		
  		return updateCount;
  	}
      
      // 상품 삭제
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
   	
   	   // 관리자 구매내역 전체 게시물 수 조회
   	   public int selectOrderListCount() {
   	      int listCount = 0;
   	      
   	      PreparedStatement pstmt = null;
   	      ResultSet rs = null;
   	      
   	      try {
   	         String sql= "select count(goods_goodsId) from goods_order";
   	         pstmt = con.prepareStatement(sql);
   	         rs= pstmt.executeQuery();
   	         
   	         if (rs.next()) {
   	            listCount = rs.getInt(1);
   	         }
   	         
   	         System.out.println("selectOrderListCount에서 check! 전체 게시물 수 : " + listCount);
   	         
   	      } catch (SQLException e) {
   	         System.out.println("selectOrderListCount() 오류!- "+e.getMessage());
   	         e.printStackTrace();
   	      } finally {
   	         close(rs);
   	         close(pstmt);
   	      }
   	      
   	      return listCount;
   	   }

   	   // 관리자 구매내역 조회
   	   public ArrayList<StoreBean> selectOrderList(int page, int limit) {
   	       System.out.println("selectOrderList DAO");
   	         ArrayList<StoreBean> orderList = null;
   	         
   	         PreparedStatement pstmt = null;
   	         ResultSet rs = null;
   	         
   	         PreparedStatement pstmt2 = null;
   	         ResultSet rs2 = null;
   	         
   	         int startRow = (page - 1) * limit;
   	         
   	         try {
   	            String sql = "SELECT o.orderNum, o.reserveNum, o.member_id, o.expiredate, o.status, " 
   	                     + "g.name, g.component, g.file, g.ctg "
   	                     + "FROM goods g JOIN goods_order o "
   	                     + "ON g.goodsId = o.goods_goodsId "
   	                     + "ORDER BY member_id, orderNum limit ?,?";
   	            pstmt = con.prepareStatement(sql);
   	            pstmt.setInt(1, startRow);
   	            pstmt.setInt(2, limit);

   	            rs = pstmt.executeQuery();
   	            
   	            System.out.println("확인");
   	            
   	            orderList = new ArrayList<StoreBean>();
   	            
   	            while(rs.next()) {
   	               StoreBean order = new StoreBean(); 
   	                 
   	               order.setOrderNum(rs.getString("orderNum"));
   	               order.setReserveNum(rs.getString("reserveNum"));
   	               order.setMember_id(rs.getString("member_id"));
   	               order.setExpiredate(rs.getString("expiredate"));
   	               order.setStatus(rs.getBoolean("status"));

   	               order.setName(rs.getString("name"));
   	               order.setComponent(rs.getString("component"));
   	               order.setFile(rs.getString("file"));
   	               order.setCtg(rs.getString("ctg"));
   	               
   	               
   	               String sql2 = "select name from member where id = ?";
   	               pstmt2 = con.prepareStatement(sql2);
   	               pstmt2.setString(1, order.getMember_id());
   	               rs2 = pstmt2.executeQuery();
   	               if(rs2.next()) {
   	            	   order.setMember_name(rs2.getString("name"));
   	               }
   					
   	               orderList.add(order);
   	            }

   	         } catch (SQLException e) {
   	            System.out.println("selectOrderList() 오류!- "+e.getMessage());
   	            e.printStackTrace();
   	         } finally {
   	            close(pstmt);
   	            close(rs);
   	            close(pstmt2);
   	            close(rs2);
   	         }
   	         return orderList;
   	      }

   	   // 상품 사용여부 변경
   	   public int UseArticle(String reserveNum) {
   			int UseCount =0;
   			
   			PreparedStatement pstmt =null;
   			
   			try {
   				
   				String sql = "UPDATE goods_order SET status=1 WHERE reserveNum =?";
   				pstmt = con.prepareStatement(sql);
   				pstmt.setString(1, reserveNum);
   				UseCount = pstmt.executeUpdate();
   				
   				System.out.println("storeDAO - UseArticle 에서 check! " + UseCount);
   				
   			} catch (SQLException e) {
   				System.out.println("UseArticle() 오류!- "+e.getMessage());
   				
   				e.printStackTrace();
   			} finally {
   				close(pstmt);
   			}
   			  			
   			return UseCount;
   	}

   	// 멤버십 포인트 추가
   	public int createMembership(String id, StoreBean order) {
   		System.out.println("StoreDAO createMembership() !");
   		
   		int membership = (int)(order.getSumPrice() * 0.01);
   		
   		System.out.println("가격 : " + order.getSumPrice() + ", membership : " + membership);
   		
   		PreparedStatement pstmt = null;
   	    ResultSet rs = null;
   	    int addCount = 0;

   	    try {
   			String sql = "SELECT membership FROM member WHERE id =?"; 
   			pstmt = con.prepareStatement(sql);
   			pstmt.setString(1, id);
   			rs = pstmt.executeQuery();
   			
   				if(rs.next()) {
   					sql = "UPDATE member SET membership = membership + ? WHERE id =?";
   					pstmt = con.prepareStatement(sql);
   					pstmt.setInt(1, membership);
   					pstmt.setString(2, id);
   					System.out.println("확인");
   					addCount = pstmt.executeUpdate();
   				} else {
   					sql = "INSERT INTO member(membership) values(?) WHERE id =?";
   					pstmt = con.prepareStatement(sql);
   					pstmt.setInt(1, membership);
   					pstmt.setString(2, id);
   					System.out.println("확인2");
   					addCount = pstmt.executeUpdate();
   				}
   				
   		} catch (SQLException e) {
   			System.out.println("createMembership() 오류!- "+e.getMessage());
   	        e.printStackTrace();

   		} finally {
   	        close(pstmt);
   	        close(rs);
   	     }
   		
   		return addCount;
   	}
   		
   		
   	// ---------------------- 관리자 끝 ----------------------	
   		
   	// ---------------------- 장바구니 ----------------------	
   		
      // 장바구니 담기
      public int addBasket(int basketCount, int goodsId, String id) {
         System.out.println("StoreDAO - addBasket()");
         
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int addCount = 0;
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
				pstmt.setInt(3, basketCount);
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
         
         System.out.println("storeDAO addBasket()에서 basketCount : " + basketCount);
         return addCount;
      }

      // 장바구니 목록 조회
      public ArrayList<StoreBean> selectBasketList(String id) {
            System.out.println("storeDAO - selectBasketList()");
            
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
                  
                  System.out.println("storeDAO - selectBasketList()에서 check - 담겨있는 상품아이디 :" + basket.getGoods_goodsId());
                  
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
      
      // 장바구니 수량 수정
      public int updateBasketCount(int basketCount, int basketId) {
      	System.out.println("StoreDAO - updateBasketCount()");
      	
  		int updateCount =0;
  		PreparedStatement pstmt = null;
//          ResultSet rs = null;
          Timestamp date = new Timestamp(System.currentTimeMillis());
  		
  		try {
//  			String sql = "update basket set basketCount=?, date=? where goods_goodsId=? and member_id=?";
  			String sql = "update basket set basketCount=?, date=? where basketId=?";
  			pstmt = con.prepareStatement(sql);
	        	pstmt.setInt(1, basketCount);
//	        	pstmt.setInt(3, goodsId);
//	        	pstmt.setString(4, id);
	        	pstmt.setTimestamp(2, date);
	        	pstmt.setInt(3, basketId);
	        	
	        	if(basketCount == 0) {
	        		 basketCount = 1;
	        	 }
  			
  			updateCount = pstmt.executeUpdate();
  			
  			//임시 확인용
  			System.out.println("StoreDAO에서 check! 수정되었는가? : " + updateCount);
  			
  		} catch (SQLException e) {
  			System.out.println("updateBasketCount() 오류!- "+e.getMessage());
  			
  			e.printStackTrace();
  		} finally {
  			close(pstmt);
  		}
  		
  		return updateCount;
  	}
      
      // 장바구니 상품 삭제
 		public int deleteBasket(int basketId) {
 			// StoreBean 객체에 저장된 내용을 사용하여
 			// 장바구니번호(basketId)에 해당하는 레코드를 삭제 후 결과 리턴
 			int deleteCount =0;
 			PreparedStatement pstmt = null;
 			
 			try {
// 				String sql = "delete from basket where goods_goodsId=?and member_id";
 				String sql = "delete from basket where basketId=?";
 				pstmt = con.prepareStatement(sql);
 				pstmt.setInt(1, basketId );
// 				pstmt.setString(2, id);
 				
 				deleteCount = pstmt.executeUpdate();
 				
 				//임시 확인용
 				System.out.println("storeDAO - deleteBasket 에서 check! 삭제되었는가? : " + deleteCount);
 				
 			} catch (SQLException e) {
 				System.out.println("deleteArticle() 오류!- "+e.getMessage());
 				
 				e.printStackTrace();
 			} finally {
 				close(pstmt);
 			}
 			  			
 			return deleteCount;
 		}
 		
 	// ---------------------- 장바구니  끝 ----------------------	
 		
 	// ---------------------- 구매하기 ----------------------	
 		
      // 1. store_main, store_detail 구매하기 목록 조회
      public ArrayList<StoreBean> selectBasketList(int basketCount, int goodsId) {
            System.out.println("storeDAO - selectBasketList()");
    	  	ArrayList<StoreBean> basketList = null;
    	  	
            System.out.println(basketCount);
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
            	String sql = "SELECT * FROM goods WHERE goodsId = ?";
            	pstmt = con.prepareStatement(sql);
            	pstmt.setInt(1, goodsId);
            	rs = pstmt.executeQuery();
               
               //ArrayList 객체 생성(while문 위에서 생성 필수!)
               basketList = new ArrayList<StoreBean>();
               
               // 읽어올 게시물이 존재할 경우 다음 작업 반복 
               // StoreBean 객체를 생성하여 레코드 데이터 모두 저장 후  StoreBean 객체를 다시 ArrayList 객체에 추가 => 반복
               while(rs.next()) {
                  // 1개 게시물 정보를 저장할 StoreBean 객체 생성 및 데이터 저장
                  StoreBean basket = new StoreBean(); 
                  
                  basket.setBasketCount(basketCount);
                  
                  basket.setCtg(rs.getString("ctg"));
                  basket.setName(rs.getString("name"));
                  basket.setPrice(rs.getInt("price"));
                  basket.setSale(rs.getInt("sale"));
                  basket.setComponent(rs.getString("component"));
                  basket.setFile(rs.getString("file"));
                  basket.setContent(rs.getString("content"));
                  
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
            System.out.println("goodsId : " + goodsId);
            
            return basketList;
         }
      
      // 2. 장바구니 -> 구매하기 목록 조회
      public ArrayList<StoreBean> selectBasketList(String[] basketIds, String id) {
    	  System.out.println("selectBasketList DAO");
  	  	ArrayList<StoreBean> basketList = null;
  	  	
          PreparedStatement pstmt = null;
          PreparedStatement pstmt2 = null;
          ResultSet rs = null;
          ResultSet rs2 = null;
          
          try {
          	
          	basketList = new ArrayList<StoreBean>();
          	
          	for(String basket: basketIds) {
          		int basketId = Integer.parseInt(basket);
          		
          		String sql = "SELECT * FROM basket WHERE basketId = ?";
          		pstmt = con.prepareStatement(sql);
          		pstmt.setInt(1, basketId);
          		rs = pstmt.executeQuery();
          		
          		if(rs.next()) {
          			// 가져온 상품번호를 통해 상품정보 저장하기위해 변수 정의
          			int goods_goodsId = rs.getInt("goods_goodsId");
          			
          			String sql2 = "SELECT * FROM goods WHERE goodsId = ?";
          			pstmt2 = con.prepareStatement(sql2);
          			pstmt2.setInt(1, goods_goodsId);
          			rs2 = pstmt2.executeQuery();
          			
          			//ArrayList 객체 생성(while문 위에서 생성 필수!)
          			
          			while(rs2.next()) {
          				
          				// 1개 게시물 정보를 저장할 StoreBean 객체 생성 및 데이터 저장
                          StoreBean sb = new StoreBean(); 
                            
                          //basket 테이블
                          sb.setBasketCount(rs.getInt("basketCount"));
                          sb.setBasketId(rs.getInt("basketId"));
                          sb.setGoods_goodsId(rs.getInt("goods_goodsId"));
                          sb.setMember_id(id);
                          //goods 테이블
                          sb.setCtg(rs2.getString("ctg"));
                          sb.setName(rs2.getString("name"));
                          sb.setPrice(rs2.getInt("price"));
                          sb.setSale(rs2.getInt("sale"));
                          sb.setComponent(rs2.getString("component"));
                          sb.setFile(rs2.getString("file"));
                          sb.setContent(rs2.getString("content"));
                          
                          System.out.println(sb.getGoods_goodsId());
                          
                          // 1개 게시물을 전체 게시물 저장 객체(ArrayList)에 추가
                          basketList.add(sb);
          			}
          			
          		}
             
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
   	
      // 1. 스토어메인, 디테일 -> 구매내역 -> 결제
        public int orderGoods(String id, StoreBean order) {
  			System.out.println("StoreDAO - orderGoods ----String id, StoreBean order");
  			
  			int addCount = 0;
  			Timestamp date = new Timestamp(System.currentTimeMillis());
  			PreparedStatement pstmt = null;
  			ResultSet rs = null;
  			boolean status = false;
  			
  			//---유효기간---
  			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  	        String currentTime = sdf.format(new java.util.Date());
  	        Calendar c = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
  	        String fromDate = sdf.format(c.getTime());
  	        c.add(Calendar.YEAR, 1);    // 1년 증가
  	        String expiredate = sdf.format(c.getTime());
  	        //---유효기간---
  			
  			try {
  				int orderId = 1;
  				int orderCount = 1;
  				
  					//확인
  					System.out.println("goodsId : " + order.getGoodsId());
  		            System.out.println(order.getReserveNum());
  		            
  		            String sql = "SELECT MAX(orderId) FROM goods_order";
  		            pstmt = con.prepareStatement(sql);
			        rs = pstmt.executeQuery();
			        
			        if(rs.next()) {
			        	orderId = rs.getInt(1) +1;
			        	System.out.println("확인");
			        }
			        
  		             sql = "INSERT INTO goods_order(orderId, goods_goodsId, member_id, orderCount, totalPrice, date, orderNum, sumPrice, reserveNum, expiredate, status) VALUES(?, ?, ?, ?, ? ,? ,? ,? ,? ,?, ?)";
  					 pstmt = con.prepareStatement(sql);
  					 pstmt.setInt(1, orderId);
  					 pstmt.setInt(2, order.getGoodsId());
  					 pstmt.setString(3, id);
  					 pstmt.setInt(4, orderCount);
  					 pstmt.setInt(5, order.getTotalPrice());
  					 pstmt.setTimestamp(6, date);
  					 pstmt.setString(7, order.getOrderNum());
  					 pstmt.setInt(8, order.getSumPrice());
  					 pstmt.setString(9, order.getReserveNum());
  					 pstmt.setString(10, expiredate);
  					 pstmt.setBoolean(11, status);
  				        
  					 addCount = pstmt.executeUpdate();
  					 System.out.println("확인2");
  					 
//  				 구매시 goods에 sellCount  + orderCount - 수정 중 (란희) 
  					String sql2 = "SELECT sellCount FROM goods WHERE goodsId=?";
  					pstmt = con.prepareStatement(sql2);
  					pstmt.setInt(1, order.getGoodsId());
//  					rs = pstmt.executeQuery();
  					System.out.println("확인3");
  					if(rs.next()) {
//  						String sql3 = "UPDATE goods g SET g.sellCount = g.sellCount + (SELECT o.orderCount FROM goods_order o WHERE g.goodsId = o.goods_goodsId) WHERE g.goodsId=?";
  						String sql3 = "UPDATE goods g INNER JOIN goods_order o ON g.goodsId = o.goods_goodsId SET g.sellCount = g.sellCount + o.orderCount WHERE g.goodsId=?";
  						pstmt=con.prepareStatement(sql3);
//  						pstmt.setInt(1, rs.getInt("goodsId"));
  						pstmt.setInt(1, order.getGoodsId());
  						pstmt.executeUpdate();
  						System.out.println("확인4");
  					}
  					
  			} catch (Exception e) {
  				System.out.println("orderGoods() 오류!- "+e.getMessage());
  				e.printStackTrace();
  			} finally {
  	             close(pstmt);
  	             close(rs);
  	          }
  			
  			return addCount;
  		}	
        
      // 2. 장바구니 -> 구매내역 -> 결제
        public int orderGoods(String[] goodsIds, String[] reserveNum, String id, StoreBean order, int orderCount) {
  			System.out.println("StoreDAO - orderGoods");
  			
  			int addCount = 0;
  			Timestamp date = new Timestamp(System.currentTimeMillis());
  			PreparedStatement pstmt = null;
  			ResultSet rs = null;
  			
  			boolean status = false;
  			
  			//---유효기간---
  			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  	        String currentTime = sdf.format(new java.util.Date());
  	        Calendar c = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
  	        String fromDate = sdf.format(c.getTime());
  	        c.add(Calendar.YEAR, 1);    // 1년 증가
  	        String expiredate = sdf.format(c.getTime());
  	        //---유효기간---
  			
  			try {
  				int orderId = 0;
  				
  				for(int i=0; i<goodsIds.length; i++) {
  					
//  				for(String goods: goodsIds) {
//  					for(String num: reserveNum) {
  						
  					int goodsId = Integer.parseInt(goodsIds[i]);
  					//확인
//  					System.out.println("goodsId : " + goodsIds.g);
//  		            System.out.println(num);
  		            
//  		            String sql = "SELECT * FROM goods_order WHERE orderNum=?";
//  		           	pstmt = con.prepareStatement(sql);
//  		           	pstmt.setString(1, order.getOrderNum());
//  		           	rs = pstmt.executeQuery();
  		            
  		           	System.out.println("확인");
  		           	
//  					if(rs.next()) {
  				           String sql = "SELECT MAX(orderId) FROM goods_order";
  					        pstmt = con.prepareStatement(sql);
  					        rs = pstmt.executeQuery();
  					        if (rs.next()) {
  					              orderId = rs.getInt(1) +1;
  					              System.out.println("확인6");
  					        }
  					        sql = "INSERT INTO goods_order(orderId, goods_goodsId, member_id, orderCount, totalPrice, date, orderNum, sumPrice, reserveNum, expiredate, status) VALUES(?, ?, ?, ?, ? ,? ,? ,? ,? ,?, ?)";
  							 pstmt = con.prepareStatement(sql);
  							 pstmt.setInt(1, orderId);
  							 pstmt.setInt(2, goodsId);
  							 pstmt.setString(3, id);
  							 pstmt.setInt(4, orderCount);
  							 pstmt.setInt(5, order.getTotalPrice());
  							 pstmt.setTimestamp(6, date);
  							 pstmt.setString(7, order.getOrderNum());
  							 pstmt.setInt(8, order.getSumPrice());
  							 pstmt.setString(9, reserveNum[i]);
  							 pstmt.setString(10, expiredate);
  							 pstmt.setBoolean(11, status);
  				        
  							 addCount = pstmt.executeUpdate();
  							 System.out.println("확인7");
  							 
//  					} else {
//  						sql = "SELECT MAX(orderId) FROM goods_order";
//  				        pstmt = con.prepareStatement(sql);
//  				        rs = pstmt.executeQuery();
//  				        System.out.println("확인3"); 
//  				        if (rs.next()) {
//  				              orderId = rs.getInt(1) +1;
//  				              System.out.println("확인4");
//  				        }
//  						 sql = "INSERT INTO goods_order(orderId, goods_goodsId, member_id, orderCount, totalPrice, date, orderNum, sumPrice, reserveNum, expiredate, status) VALUES(?, ?, ?, ?, ?, ? ,? ,? ,? ,? ,?)";
//  						 pstmt = con.prepareStatement(sql);
//  						 pstmt.setInt(1, orderId);
//  						 pstmt.setInt(2, goodsId);
//  						 pstmt.setString(3, id);
//  						 pstmt.setInt(4, orderCount);
//  						 pstmt.setInt(5, order.getTotalPrice());
//  						 pstmt.setTimestamp(6, date);
//  						 pstmt.setString(7, order.getOrderNum());
//  						 pstmt.setInt(8, order.getSumPrice());
//  						 pstmt.setString(9, reserveNum[i]);
//  						 pstmt.setString(10, expiredate);
//  						 pstmt.setBoolean(11, status);
//  			        
//  						 addCount = pstmt.executeUpdate();
//  						 System.out.println("확인5");
//  			        }
  					 
//  					} // reserveNum 포문
//  				} // goods 포문
  				}
  			} catch (Exception e) {
  				System.out.println("orderGoods() 오류!- "+e.getMessage());
  				e.printStackTrace();
  			} finally {
  	             close(pstmt);
  	             close(rs);
  	          }
  			
  			return addCount;
  		}	
   		
    // 주문번호 생성
   	public String createOrderNum() {
   				System.out.println("StoreDAO - createOrderNum() !");
   				
   				String orderNum = null;
   				
   				PreparedStatement pstmt = null;
   				ResultSet rs = null;
   				
   				SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
   				Date time = new Date();
   				
   				Random random = new Random();
   				int bound = 10000;
   				
   				String suffix = String.format("%04d", random.nextInt(bound)); 
   				orderNum = format1.format(time) + suffix;
   				
   				try {
   					String sql = "select orderNum from goods_order where orderNum=?";
   					pstmt = con.prepareStatement(sql);
   					pstmt.setString(1, orderNum);
   					rs = pstmt.executeQuery();
   					
   					if(rs.next()) {
   						while(rs.next()) {
   							suffix = String.format("%04d", random.nextInt(bound));
   							orderNum = format1.format(time) + suffix;
   						}						
   					}
   			
   				} catch (SQLException e) {
   					
   					e.printStackTrace();
   				}finally {
   					if(rs != null) {
   						close(rs);
   					}						
   					close(pstmt);
   				}				
   				
   				return orderNum;
   			}
   	
	// 1. 스토어메인, 디테일 -> 개별 구매번호
	public String createReserveNum() {
		System.out.println("StoreDAO - createReserveNum() !");
 				
		String reserveNum = null;
 				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
   				
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
		Date time = new Date();
  				
		Random random = new Random();
		int bound = 10000;
  				
		String suffix = String.format("%04d", random.nextInt(bound)); 
		reserveNum = format1.format(time) + suffix;
   				
		try {
			String sql = "select reserveNum from goods_order where reserveNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reserveNum);
			rs = pstmt.executeQuery();
   					
			if(rs.next()) {
				while(rs.next()) {
					suffix = String.format("%04d", random.nextInt(bound));
					reserveNum = format1.format(time) + suffix;
				}						
			}
 			
		} catch (SQLException e) {
   					
			e.printStackTrace();
		}finally {
			if(rs != null) {
				close(rs);
			}						
			close(pstmt);
		}				
   				
		return reserveNum;
	}

	 // 2. 장바구니 -> 개별 구매번호
    public String[] createReserveNum(int count) {
       System.out.println("StoreDAO - createReserveNum() 배열 !");
       System.out.println(count);
       String[] reserveNum2 = new String[count];
              
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
          String sql = "SELECT MAX(reserveNum) FROM goods_order";
          pstmt = con.prepareStatement(sql);
          rs = pstmt.executeQuery();
          
          SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMdd");
          Date time = new Date();
          String today = format1.format(time);
          
          if (rs.next()) {
             System.out.println(rs.getString(1));
             
             if (rs.getNString(1) != null) {
                if (rs.getString(1).contains(today)) {
                   int num = Integer.parseInt(rs.getString(1).substring(8));
                   
                   for (int i = 0; i < count; i++) {
                      reserveNum2[i] = today + (num + i + 1);
                   }
                   
                } else {
                   for (int i = 0; i < count; i++) {
                      reserveNum2[i] = today + "000" + i;
                      
                   }
                   
                }
                
             } else {
                for (int i = 0; i < count; i++) {
                   reserveNum2[i] = today + "000" + i;
                }
                
             }
             
          }
          
          //값 확인
          for(String reserve : reserveNum2) {
             System.out.println(reserve);
          }
          
       } catch (NumberFormatException e) {
          e.printStackTrace();
          
       } catch (SQLException e) {
          e.printStackTrace();
          
       }
       
       return reserveNum2;
    }
    
   // 구매내역 조회
   public ArrayList<StoreBean> selectOrderList(String orderNum, String id) {
       System.out.println("storeDAO - selectOrderList()");
         ArrayList<StoreBean> orderList = null;
         
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         
         PreparedStatement pstmt2 = null;
         ResultSet rs2 = null;
         
         try {
            String sql = "SELECT o.orderNum, o.reserveNum, o.member_id, o.expiredate, " 
                     + "g.name, g.component, g.file "
                     + "FROM goods g JOIN goods_order o "
                     + "ON g.goodsId = o.goods_goodsId "
                     + "WHERE orderNum = ? AND member_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, orderNum);
            pstmt.setString(2, id);
            rs = pstmt.executeQuery();
            
            System.out.println("구매내역 orderNum 확인" + orderNum);
            
            orderList = new ArrayList<StoreBean>();
            
            while(rs.next()) {
               StoreBean order = new StoreBean(); 
                 
               order.setOrderNum(orderNum);
               order.setReserveNum(rs.getString("reserveNum"));
               order.setMember_id(id);
               order.setExpiredate(rs.getString("expiredate"));

               order.setName(rs.getString("name"));
               order.setComponent(rs.getString("component"));
               order.setFile(rs.getString("file"));
               
               
               String sql2 = "select name from member where id = ?";
               pstmt2 = con.prepareStatement(sql2);
               pstmt2.setString(1, id);
               rs2 = pstmt2.executeQuery();
               if(rs2.next()) {
            	   order.setMember_name(rs2.getString("name"));
               }
				
               orderList.add(order);
               System.out.println("구매내역 orderNum 확인2" + orderNum);
            }
            
         } catch (SQLException e) {
            System.out.println("selectOrderList() 오류!- "+e.getMessage());
            e.printStackTrace();
         } finally {
            close(pstmt);
            close(rs);
            close(pstmt2);
            close(rs2);
         }
         return orderList;
      }
   
// ---------------------- 구매하기 끝 ----------------------	
   
} //메인메서드
