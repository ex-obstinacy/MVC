package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoreDAO;
import vo.StoreBean;

//////장바구니에서 넘어옴 //////
public class OrderProService2 {

	public boolean OrderGoods(String[] goodsIds, String[] reserveNum, String id, StoreBean order) {
		System.out.println("OrderProService2 - OrderGoods() !");
		boolean isOrderSuccess = false;
		
		Connection con = getConnection();
	    StoreDAO storeDAO = StoreDAO.getInstance();
	    storeDAO.setConnection(con);
	    
	    int addCount = storeDAO.orderGoods(goodsIds, reserveNum, id, order);
	      
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
