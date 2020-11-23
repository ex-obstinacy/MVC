package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.SelectSeatService;
import vo.ActionForward;
import vo.ReserveBean;

public class SelectSeatAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;		
		
//		int movienum = Integer.parseInt(request.getParameter("movienum"));
		int movienum = 1; // 임시확인용(원래는 위에코드)
		
		SelectSeatService selectSeatService = new SelectSeatService();
		ArrayList<ReserveBean> seatList = new ArrayList<ReserveBean>();
		
		seatList = selectSeatService.getSeatList(movienum);
		
		request.setAttribute("seatList", seatList);
		
		forward = new ActionForward();
		forward.setPath("/reservation/selectSeat.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
