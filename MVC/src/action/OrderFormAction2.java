package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderFormService2;
import svc.OrderFormService;
import vo.ActionForward;
import vo.StoreBean;

// 장바구니에서 구매하기시 - 구매하기 목록
public class OrderFormAction2 implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   System.out.println("OrderFormAction2로 이동!");
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
	      
	      
	      // 선택한 상품 장바구니번호 가져오기
	      String[] basketIds = request.getParameterValues("checkRow");
	      
	      OrderFormService2 orderFormService2 = new OrderFormService2();
	      
	      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
	      basketList = orderFormService2.getBasketList(basketIds, id);
	      request.setAttribute("basketList", basketList);
	      
	      String orderNum = orderFormService2.createOrderNum();
	      request.setAttribute("orderNum", orderNum);
	      
		  String[] reserveNum = orderFormService2.createReserveNum(basketIds.length);
		  request.setAttribute("reserveNum", reserveNum);
	      
	      forward.setPath("goods/orderForm2.jsp");
//				forward.setRedirect(false);
	      
	      return forward;
	}

}
