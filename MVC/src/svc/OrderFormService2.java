package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;
import vo.StoreBean;

public class OrderFormService2 {

	public ArrayList<StoreBean> getBasketList(String[] basketIds, String id) {
		System.out.println("OrderFormService - store_detail !");
	    
	    ArrayList<StoreBean> basketList = null;
	       
	    System.out.println(basketIds);
	     Connection con = getConnection();
	     StoreDAO storeDAO = StoreDAO.getInstance();
	     storeDAO.setConnection(con);
	       
//	     basketList = storeDAO.selectBasketList(basketIds, id);
	    
	     close(con);
	       
	     return basketList;
	}

}
