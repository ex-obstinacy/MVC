package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class MainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MainAction");
		
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("/main/main.jsp");
		return forward;
	}

}
