package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vo.ActionForward;

public class MemberLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberLogoutAction!");
		
		// request 객체로부터 HttpSession 객체 가져와서 세션 초기화
		HttpSession session = request.getSession();
		session.invalidate(); // 초기화
		
		// 만약, id 에 해당하는 세션값만 삭제해야할 경우
//		session.removeAttribute("id");
		
		// 메인페이지로 포워딩
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("./"); // 프로젝트 루트로 경로 설정
		
		return forward;
		
	}

}
