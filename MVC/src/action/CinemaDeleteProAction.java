package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CinemaDeleteProService;
import vo.ActionForward;

public class CinemaDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		String cinema_name = request.getParameter("cinema");
		
		CinemaDeleteProService cinemaDeleteProService = new CinemaDeleteProService();
		boolean isDeleteSuccess = cinemaDeleteProService.removeCinema(cinema_name);
		if(isDeleteSuccess) {
			// 삭제성공
			forward = new ActionForward();
			forward.setPath("CinemaAddForm.re");
			forward.setRedirect(true);
		} else {
			// 삭제실패
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
		
	}

}
