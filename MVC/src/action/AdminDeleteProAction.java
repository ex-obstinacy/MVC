package action;

import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.MemberDeleteProService;
import vo.ActionForward;

public class AdminDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AdminDeleteProAction");

		// 삭제할 회원 아이디 값
		String id = request.getParameter("id");
		
		MemberDeleteProService memberDeleteProService = new MemberDeleteProService();
		boolean isDeleteSuccess = memberDeleteProService.isDeleteMember(id);
		
		ActionForward forward = new ActionForward();
		
		if (isDeleteSuccess) {
			forward.setPath("AdminMemberList.ad");
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
