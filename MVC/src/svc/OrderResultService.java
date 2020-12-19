package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;
import vo.StoreBean;

public class OrderResultService {

	public ArrayList<StoreBean> getOrderList(String orderNum, String id) {
		 System.out.println("OrderResultService !");
		 
	      ArrayList<StoreBean> orderList = null;
	      
	      Connection con = getConnection();
	      StoreDAO storeDAO = StoreDAO.getInstance();
	      storeDAO.setConnection(con);
	      
	      orderList = storeDAO.selectOrderList(orderNum, id);
	      
	      close(con);
	      
	      return orderList;
	}

}
