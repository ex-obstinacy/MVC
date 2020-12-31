package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderResultService;
import vo.ActionForward;
import vo.StoreBean;

public class MemberOrderDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberOrderDetailAction");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession(); //MemberBean id 값 가져오기
	    String id = (String)session.getAttribute("id"); 
	    
	    String orderNum = request.getParameter("orderNum");
		
	    OrderResultService orderResultService = new OrderResultService();
	    ArrayList<StoreBean> orderList = new ArrayList<StoreBean>();
	    
	    orderList = orderResultService.getOrderList(orderNum, id);
	    
	    request.setAttribute("orderList", orderList);
	    
		forward = new ActionForward();
		forward.setPath("/member/member_order.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
