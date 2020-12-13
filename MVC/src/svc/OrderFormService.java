package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;
import vo.StoreBean;

public class OrderFormService {

   public ArrayList<StoreBean> getBasketList(int goodsId, String id) {
      System.out.println("OrderFormService !");
      
      ArrayList<StoreBean> basketList = null;
         
       Connection con = getConnection();
       StoreDAO storeDAO = StoreDAO.getInstance();
       storeDAO.setConnection(con);
         
       basketList = storeDAO.selectBasketList(goodsId, id);
      
       close(con);
         
       return basketList;
   }

}
