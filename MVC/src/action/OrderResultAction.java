package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class OrderResultAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("OrderResultAction");
		
      forward = new ActionForward();
      forward.setPath("/goods/orderResult.jsp");
      forward.setRedirect(false);
		
		return forward;
	}

}
