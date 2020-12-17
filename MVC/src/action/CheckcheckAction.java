package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vo.ActionForward;

public class CheckcheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		if(request.getParameterValues("checkRow") == null) {
			// 체크 안한 경우
			System.out.println("체크안함");
			forward = new ActionForward();
			forward.setPath("BasketList.go");
			forward.setRedirect(true);
		} else {
			// 체크 한 경우
			String[] checkRows = request.getParameterValues("checkRow");
			for(String check: checkRows) {
				System.out.println(check);
			}
			forward = new ActionForward();
			forward.setPath("goods/checkcheck.jsp");
//			forward.setRedirect(false);
		}
		
		return forward;
	}

}
