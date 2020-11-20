package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CinemaAddProService;
import vo.ActionForward;
import vo.ReserveBean;

public class CinemaAddProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		ReserveBean reserveBean = new ReserveBean();
		reserveBean.setCinema_name(request.getParameter("name"));
		reserveBean.setLocal(request.getParameter("local"));
		
		CinemaAddProService cinemaAddProService = new CinemaAddProService();
		boolean isAddSuccess = cinemaAddProService.registArticle(reserveBean);
		
		if(isAddSuccess) {
			forward = new ActionForward();
			forward.setPath("CinemaAddForm.re");
			forward.setRedirect(true);
		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('영화관 등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
