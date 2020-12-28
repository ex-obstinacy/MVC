package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminMovInfoService;
import svc.AdminMovListService;
import svc.BookingRateService;
import svc.MovCommentListService;
import svc.StillCutFileNameService;
import svc.TotalRatingService;
import svc.TrailerFileNameService;
import vo.ActionForward;
import vo.MovBean;
import vo.MovCommentBean;
import vo.PageInfo;

public class MovDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovDetailAction");
		
		int movieCd = Integer.parseInt(request.getParameter("movieCd"));
		
		AdminMovInfoService adminMovInfoService = new AdminMovInfoService();
		MovBean article = adminMovInfoService.getArticle(movieCd);
		
		StillCutFileNameService stillCutFileNameService = new StillCutFileNameService();
		article.setStillCutFileName(stillCutFileNameService.replace(article.getStillCut()));
		for (int i = 0; i < article.getStillCutFileName().length; i++) {
			System.out.println(i + " : " + article.getStillCutFileName()[i]);
		}
		
		TrailerFileNameService trailerFileNameService = new TrailerFileNameService();
		article.setTrailerFileName(trailerFileNameService.replace(article.getTrailer()));
		for (int i = 0; i < article.getTrailerFileName().length; i++) {
			System.out.println(i + " : " + article.getTrailerFileName()[i]);
		}
		
		BookingRateService bookingRateService = new BookingRateService();
		article.setBookingRate(bookingRateService.insertBookingRate(article.getTicketing()));
		
		TotalRatingService totalRatingService = new TotalRatingService();
		article.setTotalRating(totalRatingService.insertTotalRating(movieCd));
		
		request.setAttribute("article", article);
		
		int page = 1; // 현재 페이지 번호 저장할 변수
		int limit = 10; // 페이지 당 표시할 게시물 수를 결정하는 변수
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		MovCommentListService MovCommentListService = new MovCommentListService();
		int listCount = MovCommentListService.getListCount(movieCd);
		ArrayList<MovCommentBean> articleList = new ArrayList<MovCommentBean>();
		articleList = MovCommentListService.getArticleList(page, limit, movieCd);
		int maxPage = (int)((double)listCount / limit + 0.95);
		int startPage = ((int)((double)page / 10 + 0.9) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);
		
		request.setAttribute("articleList", articleList);
		request.setAttribute("pageInfo", pageInfo);
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("/mov/mov_detail.jsp");
		return forward;
		
	}

}
