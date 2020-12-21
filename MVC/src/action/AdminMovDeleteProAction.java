package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminMovDeleteProService;
import svc.MemberDeleteProService;
import vo.ActionForward;

public class AdminMovDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AdminMovDeleteProAction");

		// 삭제할 영화코드 값
		String movieCd = request.getParameter("movieCd");
		
		AdminMovDeleteProService movDeleteProService = new AdminMovDeleteProService();
		boolean isDeleteSuccess = movDeleteProService.isDeleteMember(movieCd);
		
		ActionForward forward = new ActionForward();
		
		if (isDeleteSuccess) {
			forward.setPath("AdminMovList.mo");
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
