package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class MemberMovCommentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberMovCommentAction");
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/member_mb_comment.jsp");
		return forward;
	}

}
