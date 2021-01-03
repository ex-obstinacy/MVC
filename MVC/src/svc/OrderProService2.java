package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoreDAO;
import vo.StoreBean;

// 장바구니에서 구매하기시
public class OrderProService2 {

	public boolean createMembership(String id, StoreBean order) {
		System.out.println("OrderProService - createMembership !");
		
		boolean isMembershipSuccess = false;
		
		Connection con = getConnection();
	    StoreDAO storeDAO = StoreDAO.getInstance();
	    storeDAO.setConnection(con);
	    
	    int addCount = storeDAO.createMembership(id, order);
	    
	    if(addCount > 0) {
	    	isMembershipSuccess = true;
	         commit(con);
	      } else {
	         rollback(con);
	      }
	    
	    close(con);
	    
	    return isMembershipSuccess;
	}
	
	public boolean OrderGoods(String[] goodsIds, String[] reserveNum, String id, StoreBean order, int orderCount) {
		System.out.println("OrderProService2 - OrderGoods() !");
		boolean isOrderSuccess = false;
		
		Connection con = getConnection();
	    StoreDAO storeDAO = StoreDAO.getInstance();
	    storeDAO.setConnection(con);
	    
	    int addCount = storeDAO.orderGoods(goodsIds, reserveNum, id, order, orderCount);
	      
	    if(addCount > 0) {
	    	isOrderSuccess = true;
	       commit(con);
	    } else {
	       rollback(con);
	    }
	      
	    close(con);
	    
		return isOrderSuccess;
	}


}
