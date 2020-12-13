package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.BasketListService;
import vo.ActionForward;
import vo.StoreBean;

public class BasketListAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("BasketListAction");
      ActionForward forward = null;
      
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id"); 
      
      int goodsId = Integer.parseInt(request.getParameter("goodsId"));
 
      
      BasketListService basketListService = new BasketListService();
      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
      
      basketList = basketListService.getBasketList(goodsId, id);
      
      request.setAttribute("basketList", basketList);
      
      forward = new ActionForward();
      forward.setPath("/basket.jsp");
      forward.setRedirect(false);
      
      return forward;
   }

}