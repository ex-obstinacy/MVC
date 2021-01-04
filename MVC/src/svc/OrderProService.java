package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoreDAO;
import vo.StoreBean;

//store_main, store_detail에서 구매하기시
public class OrderProService {

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
	
	public boolean OrderGoods(String id, StoreBean order, String[] basketCount) {
		System.out.println("OrderProService - OrderGoods() !");
		boolean isOrderSuccess = false;
		
		Connection con = getConnection();
	    StoreDAO storeDAO = StoreDAO.getInstance();
	    storeDAO.setConnection(con);
	    
	    int addCount = storeDAO.orderGoods(id, order, basketCount);
	      
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
