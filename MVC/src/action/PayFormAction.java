package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.PayFormService;
import vo.ActionForward;
import vo.ReserveBean;

public class PayFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("PayFormAction !");
		ActionForward forward = null;
		
		int movienum = Integer.parseInt(request.getParameter("movienum"));

		PayFormService payFormService = new PayFormService();
		ReserveBean movie = payFormService.getMovie(movienum);
		
		request.setAttribute("movie", movie);
		
		forward = new ActionForward();
		forward.setPath("/reservation/payForm.jsp");		
		
		
		return forward;
	}

}
