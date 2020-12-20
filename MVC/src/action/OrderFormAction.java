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
      forward = new ActionForward();
      
      // -------------------- id가 null 이면 로그인 화면 이동 --------------------
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id"); 
      
      if(id == null) { // id가 null 이면 로그인 화면으로 이동 !
         forward.setPath("MemberLogin.me");
         forward.setRedirect(true);
         return forward;
      } 
      
      // -------------------- id가 null 이면 로그인 화면 이동 --------------------
      
      int goodsId = Integer.parseInt(request.getParameter("goodsId"));
      
      String basketCount = request.getParameter("basketCount");
      
      if(basketCount == null) {
    	  basketCount = "1";
      }
      
      System.out.println(goodsId);
      
      OrderFormService orderFormService = new OrderFormService();
      
      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
      basketList = orderFormService.getBasketList(Integer.parseInt(basketCount), goodsId); 
      request.setAttribute("basketList", basketList);
      
      String orderNum = orderFormService.createOrderNum();
      request.setAttribute("orderNum", orderNum);
      
      String reserveNum = orderFormService.createReserveNum();
      request.setAttribute("reserveNum", reserveNum);
      
      forward.setPath("/goods/orderForm.jsp");
//    forward.setRedirect(false);
      
      return forward;
   }

}