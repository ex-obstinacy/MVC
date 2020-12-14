package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;
import vo.StoreBean;

public class OrderFormService {

// store_main, store_detail 구매목록
public ArrayList<StoreBean> getBasketList(int basketCount, int goodsId) {
	System.out.println("OrderFormService - store_detail !");
    
    ArrayList<StoreBean> basketList = null;
       
    System.out.println(basketCount );
     Connection con = getConnection();
     StoreDAO storeDAO = StoreDAO.getInstance();
     storeDAO.setConnection(con);
       
     basketList = storeDAO.selectBasketList(basketCount, goodsId);
    
     close(con);
       
     return basketList;
}




}
