package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminMovDeleteProService;
import svc.MovCommentDeleteProService;
import vo.ActionForward;

public class MovCommentDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovCommentDeleteProAction");
		
		String movieCd = request.getParameter("movieCd");
		String page = request.getParameter("page");
		int num = Integer.parseInt(request.getParameter("num"));
		
		MovCommentDeleteProService movCommentDeleteProService = new MovCommentDeleteProService();
		boolean isDeleteSuccess = movCommentDeleteProService.isDeleteMovComment(num);
		
		ActionForward forward = new ActionForward();
		
		if (isDeleteSuccess) {
			forward.setPath("MovDetail.mo?movieCd=" + movieCd + "&page=" + page);
			forward.setRedirect(true);
			
		} else {
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
