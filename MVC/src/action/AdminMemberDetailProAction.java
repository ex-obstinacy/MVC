package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberInfoService;
import vo.ActionForward;
import vo.MemberBean;

public class AdminMemberDetailProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AdminMemberDetailProAction");
		
		String id = request.getParameter("id");
		System.out.println("id : " + id);
		
		MemberInfoService memberInfoService = new MemberInfoService();
		MemberBean article = memberInfoService.getArticle(id);
		
		request.setAttribute("article", article);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/admin_member.jsp");
		
		return forward;
	}

}
