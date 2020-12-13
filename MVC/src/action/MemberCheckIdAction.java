package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberCheckIdService;
import svc.MemberInfoService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberCheckIdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberCheckIdAction");
		
		String id = request.getParameter("id");
		
		MemberCheckIdService memberCheckIdService = new MemberCheckIdService();
		boolean chekcIdResult = memberCheckIdService.checkArticle(id);

		
		String checkId = null;
		
		if (chekcIdResult) {
			checkId = "아이디 중복";
			
		} else {
			checkId = "사용 가능";
			
		}
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/checkId.jsp?checkId=" + checkId);
		
		return forward;
	}

}
