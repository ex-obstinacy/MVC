package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MovListService;
import vo.ActionForward;
import vo.MovBean;

public class MovMainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovMainAction");
		
		MovListService movListService = new MovListService();
		
		// 현재 상영작
		ArrayList<MovBean> currentMovList = new ArrayList<MovBean>();
		currentMovList = movListService.getCurrentMovList();
		
		
		// 상영 예정작
		ArrayList<MovBean> toBeMovList = new ArrayList<MovBean>();
		toBeMovList = movListService.getToBeMovList();
		
		request.setAttribute("currentMovList", currentMovList);
		request.setAttribute("toBeMovList", toBeMovList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/mov/mov_main.jsp");
		return forward;
	}

}
