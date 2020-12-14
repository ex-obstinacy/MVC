package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderFormService;
import vo.ActionForward;
import vo.StoreBean;

public class OrderFormAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("OrderFormAction !");
      ActionForward forward = null;
      
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id"); 
       
      int goodsId = Integer.parseInt(request.getParameter("goodsId"));
      
      String basketCount = request.getParameter("basketCount");
      System.out.println(basketCount);
      
      System.out.println("멤버 아이디 : " + id);
            
      OrderFormService orderFormService = new OrderFormService();
      
      //1. store_main -> 구매
      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
      basketList = orderFormService.getBasketList(goodsId);
      
      //2. store_detail -> 구매
      basketList = orderFormService.getBasketList(Integer.parseInt(basketCount), goodsId); 
      
      //3. 장바구니 -> 구매
      
      
      
      request.setAttribute("basketList", basketList);

      forward = new ActionForward();
      forward.setPath("/goods/orderForm.jsp");
//      forward.setRedirect(false);
      
      return forward;
   }

}