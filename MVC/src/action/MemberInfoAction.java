package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import svc.MemberInfoService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberInfoAction!");
		
		// session의 id값 가져오기
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		System.out.println("id : " + id);
		
		MemberInfoService memberInfoService = new MemberInfoService();
		MemberBean article = memberInfoService.getArticle(id);
		
		request.setAttribute("article", article);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/member_info.jsp");
		
		return forward;
	}

}
