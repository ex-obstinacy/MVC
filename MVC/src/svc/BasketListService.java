package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoreDAO;

import static db.JdbcUtil.*;
import vo.StoreBean;

public class BasketListService {
   public ArrayList<StoreBean> getBasketList(String id) throws Exception {
      System.out.println("BasketListService !");
      ArrayList<StoreBean> basketList = null;
      
      Connection con = getConnection();
      
      StoreDAO storeDAO = StoreDAO.getInstance();
      
      storeDAO.setConnection(con);
      
      basketList = storeDAO.selectBasketList(id);
      
      close(con);
      
      return basketList;
   }
}