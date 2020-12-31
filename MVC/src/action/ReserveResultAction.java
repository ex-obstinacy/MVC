package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReserveResultService;
import vo.ActionForward;
import vo.MovBean;
import vo.ReserveBean;

public class ReserveResultAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		ReserveBean reserveInfo = null;
		MovBean mv = null;
		
		String ticketnum = request.getParameter("ticketnum");
		int moviecode = Integer.parseInt(request.getParameter("moviecode"));
		
		ReserveResultService reserveResultService = new ReserveResultService();
		reserveInfo = reserveResultService.getReserveInfo(ticketnum);
		mv = reserveResultService.getMoviePost(moviecode);
		
		request.setAttribute("reserveInfo", reserveInfo);
		request.setAttribute("mv", mv);
		
		forward = new ActionForward();
		forward.setPath("/reservation/reserveResult.jsp");
		forward.setRedirect(false);	
		
		
		return forward;
	}

}
