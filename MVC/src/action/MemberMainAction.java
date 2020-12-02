package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class MemberMainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberMainAction!");
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/member_main.jsp");
		
		return forward;
	}

}
