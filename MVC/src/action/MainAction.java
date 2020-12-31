package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MovCurrentListService;
import vo.ActionForward;
import vo.MovBean;

public class MainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MainAction");
		
		MovCurrentListService movCurrentListService = new MovCurrentListService();
		
		// 현재 상영작
		ArrayList<MovBean> currentMovList = new ArrayList<MovBean>();
		currentMovList = movCurrentListService.getCurrentMovList();
		
		request.setAttribute("currentMovList", currentMovList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/main/main.jsp");
		return forward;
	}

}
