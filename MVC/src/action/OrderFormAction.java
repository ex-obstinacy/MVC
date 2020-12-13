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
      System.out.println("게시물 번호 : " + goodsId);
      System.out.println("멤버 아이디 : " + id);
            
      OrderFormService orderFormService = new OrderFormService();
      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
      
      basketList = orderFormService.getBasketList(goodsId, id);
       
      request.setAttribute("basketList", basketList);

      forward = new ActionForward();
      forward.setPath("/orderForm.jsp");
//      forward.setRedirect(false);
      
      return forward;
   }

}