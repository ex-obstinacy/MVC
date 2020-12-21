package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;
import vo.StoreBean;

public class GoodsOrderService {
	public int getListCount() throws Exception {
		System.out.println("GoodsOrderService - getListCount()");
		int listCount = 0;
		
		Connection con = getConnection();
		StoreDAO storeDAO = StoreDAO.getInstance();
		storeDAO.setConnection(con);
		
		listCount = storeDAO.selectOrderListCount();
		
		close(con);
		
		return listCount;
	}
	
		public ArrayList<StoreBean> getOrderList(int page, int limit) throws Exception {
		
		ArrayList<StoreBean> articleList = null;
		
		Connection con = getConnection();
		StoreDAO storeDAO = StoreDAO.getInstance();
		storeDAO.setConnection(con);
		
		articleList = storeDAO.selectOrderList(page, limit);
		
		close(con);
		
		return articleList;
	}
}
