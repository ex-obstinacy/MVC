package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderProService;
import svc.PayProService;
import vo.ActionForward;

public class OrderProAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      ActionForward forward = null;
      
      System.out.println("OrderProAction !");
      
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id");
      int sumPrice = Integer.parseInt(request.getParameter("sumPrice")); //sumPrice 값 가져오기
      int totalPrice = Integer.parseInt(request.getParameter("totalPrice")); //totalPrice 값 가져오기
      System.out.println("sumPrice : " + sumPrice + ", totalPrice : " +totalPrice );
      
      // 선택한 상품번호 가져오기
      String[] goodsIds = request.getParameterValues("goodsRow");
      for(String goods: goodsIds) {
    	  System.out.println(goods);
      }
      
      OrderProService orderProService = new OrderProService();
	  boolean isOrderSuccess = orderProService.OrderGoods(goodsIds, id, sumPrice, totalPrice);
      
	  if(isOrderSuccess) {
	         forward = new ActionForward();
	         forward.setPath("OrderResult.go");
	         forward.setRedirect(true);
	      } else {
	         response.setContentType("text/html; charset=UTF-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('결제 실패!')");
	         out.println("history.back()");
	         out.println("</script>");
	      }
      
      
      
//      forward = new ActionForward();
//      forward.setPath("/goods/orderResult.jsp");
//      forward.setRedirect(false);
      
      return forward;
   }

}