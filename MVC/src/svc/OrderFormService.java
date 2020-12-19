package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;
import vo.StoreBean;

public class OrderFormService {

// store_main, store_detail 구매목록
public ArrayList<StoreBean> getBasketList(int basketCount, int goodsId) {
	System.out.println("OrderFormService !");
    
    ArrayList<StoreBean> basketList = null;
       
    System.out.println(basketCount );
    System.out.println(goodsId);
     Connection con = getConnection();
     StoreDAO storeDAO = StoreDAO.getInstance();
     storeDAO.setConnection(con);
       
     basketList = storeDAO.selectBasketList(basketCount, goodsId);
    
     close(con);
       
     return basketList;
}

public String createOrderNum() {
	System.out.println("OrderFormService - createOrderNum !");
	
	String orderNum = null;
	
	Connection con = getConnection();
    StoreDAO storeDAO = StoreDAO.getInstance();
    storeDAO.setConnection(con);
    
    orderNum = storeDAO.createOrderNum();
    
    close(con);
    
	return orderNum;
}

public String createReserveNum() {
	System.out.println("OrderFormService - createReserveNum !");
	
	String reserveNum = null;
	
	Connection con = getConnection();
    StoreDAO storeDAO = StoreDAO.getInstance();
    storeDAO.setConnection(con);
    
    reserveNum = storeDAO.createReserveNum();
    
    close(con);
    
	return reserveNum;
}




}
