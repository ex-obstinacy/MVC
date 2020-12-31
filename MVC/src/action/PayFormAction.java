package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.PayFormService;
import vo.ActionForward;
import vo.MemberBean;
import vo.MovBean;
import vo.ReserveBean;

public class PayFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("PayFormAction !");
		ActionForward forward = null;
		
		int movienum = Integer.parseInt(request.getParameter("movienum"));
		int moviecode = Integer.parseInt(request.getParameter("moviecode"));
		String member_id = request.getParameter("member_id");

		PayFormService payFormService = new PayFormService();
		
		ReserveBean movie = payFormService.getMovie(movienum);		
		request.setAttribute("movie", movie);
		
		MovBean mv = payFormService.getMoviePost(moviecode);
		request.setAttribute("mv", mv);
		
		MemberBean memberInfo = payFormService.getMemberInfo(member_id);		
		request.setAttribute("memberInfo", memberInfo);
		
		String ticketnum = payFormService.createTicketNum();
		request.setAttribute("ticketnum", ticketnum);
		
		forward = new ActionForward();
		forward.setPath("/reservation/payForm.jsp");
		
		
		return forward;
	}

}
