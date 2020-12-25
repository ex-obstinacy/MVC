package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminMovInfoService;
import svc.BookingRateService;
import svc.StillCutFileNameService;
import vo.ActionForward;
import vo.MovBean;

public class MovDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovDetailAction");
		
		String movieCd = request.getParameter("movieCd");
		
		AdminMovInfoService adminMovInfoService = new AdminMovInfoService();
		MovBean article = adminMovInfoService.getArticle(movieCd);
		
		StillCutFileNameService stillCutFileNameService = new StillCutFileNameService();
		article.setStillCutFileName(stillCutFileNameService.replace(article.getStillCut()));
		
		BookingRateService bookingRateService = new BookingRateService();
		article.setBookingRate(bookingRateService.insertBookingRate(article.getTicketing()));
		
		request.setAttribute("article", article);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/mov/mov_detail.jsp");
		return forward;
		
	}

}
