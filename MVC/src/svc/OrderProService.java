package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoreDAO;
import vo.StoreBean;

//////스토어메인, 디테일에서 넘어옴 //////
public class OrderProService {

	public boolean OrderGoods(String id, StoreBean order) {
		System.out.println("OrderProService - OrderGoods() !");
		boolean isOrderSuccess = false;
		
		Connection con = getConnection();
	    StoreDAO storeDAO = StoreDAO.getInstance();
	    storeDAO.setConnection(con);
	    
	    int addCount = storeDAO.orderGoods(id, order);
	      
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
