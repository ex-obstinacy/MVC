package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoreDAO;
import vo.StoreBean;

public class OrderProService2 {

	public boolean OrderGoods(String[] goodsIds, String id, StoreBean order) {
		System.out.println("OrderProService - OrderGoods() !");
		boolean isOrderSuccess = false;
		
		Connection con = getConnection();
	    StoreDAO storeDAO = StoreDAO.getInstance();
	    storeDAO.setConnection(con);
	    
	    int addCount = storeDAO.orderGoods(goodsIds, id, order);
	      
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
