package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderFormService;
import vo.ActionForward;
import vo.StoreBean;

//store_main, store_detail 구매목록
public class OrderFormAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("OrderFormAction !");
      ActionForward forward = null;
      
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id"); 
      
      int goodsId = Integer.parseInt(request.getParameter("goodsId"));
      
      String basketCount = request.getParameter("basketCount");
      
      if(basketCount == null) {
    	  basketCount = "1";
      }
      
      OrderFormService orderFormService = new OrderFormService();
      
      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
      basketList = orderFormService.getBasketList(Integer.parseInt(basketCount), goodsId); 
      
      request.setAttribute("basketList", basketList);

      forward = new ActionForward();
      forward.setPath("/goods/orderForm.jsp");
//    forward.setRedirect(false);
      
      return forward;
   }

}