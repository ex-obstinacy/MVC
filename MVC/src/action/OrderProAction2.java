package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderProService2;
import svc.PayProService;
import vo.ActionForward;
import vo.StoreBean;

public class OrderProAction2 implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      ActionForward forward = null;
      
      System.out.println("OrderProAction2 !");
      
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id");
//      int goodsId = Integer.parseInt(request.getParameter("goodsId"));
      int sumPrice = Integer.parseInt(request.getParameter("sumPrice")); //sumPrice 값 가져오기
      int totalPrice = Integer.parseInt(request.getParameter("totalPrice")); //totalPrice 값 가져오기
      String orderNum = request.getParameter("orderNum");
      String reserveNum = request.getParameter("reserveNum");
      
      StoreBean order = new StoreBean();
      order.setOrderNum(orderNum);
      order.setReserveNum(reserveNum);
      order.setSumPrice(sumPrice);
      order.setTotalPrice(totalPrice);
//      order.setGoodsId(goodsId);
      
//      System.out.println("goodsId : " + goodsId);
      
      // 선택한 상품번호 가져오기
      String[] goodsIds = request.getParameterValues("goodsRow");
      for(String goods: goodsIds) {
    	  System.out.println("goods : " + goods);
      }
      
      OrderProService2 orderProService = new OrderProService2();
	  boolean isOrderSuccess = orderProService.OrderGoods(goodsIds, id, order);
      
	  
	  if(isOrderSuccess) {
		  if(orderNum != null) {
			  forward = new ActionForward();
			  forward.setPath("OrderResult.go");
			  forward.setRedirect(true);
		  } else {
	         response.setContentType("text/html; charset=UTF-8");
	         
	         PrintWriter out = response.getWriter();
	         
	         out.println("<script>");
	         out.println("alert('주문번호 없음!')");
	         out.println("history.back()");
	         out.println("</script>");
	      }
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