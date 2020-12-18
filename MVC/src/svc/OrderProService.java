package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoreDAO;

public class OrderProService {

	public boolean OrderGoods(String[] goodsIds, String id, int sumPrice, int totalPrice) {
		System.out.println("OrderProService - OrderGoods() !");
		boolean isOrderSuccess = false;
		
		Connection con = getConnection();
	    StoreDAO storeDAO = StoreDAO.getInstance();
	    storeDAO.setConnection(con);
	    
	    int addCount = storeDAO.orderGoods(goodsIds, id, sumPrice, totalPrice);
	      
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
