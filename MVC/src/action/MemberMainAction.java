package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberShipService;
import vo.ActionForward;
import vo.MemberShipBean;

public class MemberMainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberMainAction!");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		MemberShipService memberShipService = new MemberShipService();
		
		MemberShipBean memberShip = new MemberShipBean();
		
		memberShip = memberShipService.getMemberShip(id);
		
		request.setAttribute("memberShip", memberShip);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/member_main.jsp");
		
		return forward;
	}

}
