package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderFormService2;
import svc.OrderFormService;
import vo.ActionForward;
import vo.StoreBasketIds;
import vo.StoreBean;

//장바구니 -> 구매목록
public class OrderFormAction2 implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("OrderFormAction2 !");
      ActionForward forward = null;
      
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id"); 
      
      System.out.println(id);
      
		if(request.getParameterValues("checkRow") == null) {
			// 체크 안한 경우
			System.out.println("체크안함");
			forward = new ActionForward();
			forward.setPath("BasketList.go");
			forward.setRedirect(true);
		} else {
			// 체크 한 경우
			String[] checkRows = request.getParameterValues("checkRow");
			for(String check: checkRows) {
				System.out.println(check);
			}
			
			OrderFormService2 orderFormService2 = new OrderFormService2();
			ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
			
			basketList = orderFormService2.getBasketList(checkRows,id);
			
			request.setAttribute("basketList", basketList);
			
			forward = new ActionForward();
			forward.setPath("goods/orderForm.jsp");
//			forward.setRedirect(false);
		}
		
		return forward;
	}

}