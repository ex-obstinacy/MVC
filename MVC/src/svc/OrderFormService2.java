package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;
import vo.StoreBean;

public class OrderFormService2 {

	public ArrayList<StoreBean> getBasketList(String[] checkRows, String id) {
		System.out.println("OrderFormService2 !");
	    
	    ArrayList<StoreBean> basketList = null;
	    
	    for(String check: checkRows) {
			System.out.println(check);
		}
	    
	    Connection con = getConnection();
	    StoreDAO storeDAO = StoreDAO.getInstance();
	    storeDAO.setConnection(con);
	       
	    basketList = storeDAO.selectBasketList(checkRows, id);
	    
	    close(con);
	       
	    return basketList;
	}



}
