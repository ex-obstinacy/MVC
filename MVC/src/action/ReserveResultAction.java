package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReserveResultService;
import vo.ActionForward;
import vo.ReserveBean;

public class ReserveResultAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		ReserveBean reserveInfo = null;
		
		String ticketnum = request.getParameter("ticketnum");
		
		ReserveResultService reserveResultService = new ReserveResultService();
		reserveInfo = reserveResultService.getReserveInfo(ticketnum);
		
		request.setAttribute("reserveInfo", reserveInfo);
		
		forward = new ActionForward();
		forward.setPath("/reservation/reserveResult.jsp");
		forward.setRedirect(false);	
		
		
		return forward;
	}

}
