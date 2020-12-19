package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderFormService2;
import svc.OrderFormService;
import vo.ActionForward;
import vo.StoreBean;

//장바구니 -> 구매목록
public class OrderFormAction2 implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   System.out.println("OrderFormAction2 !");
	      ActionForward forward = null;
	      
	      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
	      String id = (String)session.getAttribute("id"); 
	      
	      // 선택한 상품 장바구니번호 가져오기
	      String[] basketIds = request.getParameterValues("checkRow");
	      
	      OrderFormService2 orderFormService2 = new OrderFormService2();
	      
	      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
	      basketList = orderFormService2.getBasketList(basketIds, id);
	      request.setAttribute("basketList", basketList);
	      
	      String orderNum = orderFormService2.createOrderNum();
	      request.setAttribute("orderNum", orderNum);
	      
		  String reserveNum = orderFormService2.createReserveNum();
		  request.setAttribute("reserveNum", reserveNum);
	      
	      forward = new ActionForward();
	      forward.setPath("goods/orderForm.jsp");
//				forward.setRedirect(false);
	      
	      return forward;
	}

}
