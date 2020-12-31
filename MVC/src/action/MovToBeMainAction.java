package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MovListService;
import svc.MovToBeListService;
import vo.ActionForward;
import vo.MovBean;

public class MovToBeMainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovToBeMainAction");
		
		MovToBeListService movToBeListService = new MovToBeListService();
		
		// 상영 예정작
		ArrayList<MovBean> toBeMovList = new ArrayList<MovBean>();
		toBeMovList = movToBeListService.getToBeMovList();
		
		request.setAttribute("toBeMovList", toBeMovList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/mov/mov_main_tobe.jsp");
		return forward;
	}

}
