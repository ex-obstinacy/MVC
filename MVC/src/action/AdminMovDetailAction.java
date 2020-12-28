package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.AdminMovInfoService;
import svc.StillCutFileNameService;
import vo.ActionForward;
import vo.MovBean;

public class AdminMovDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AdminMovDetailAction");
		
		int movieCd = Integer.parseInt(request.getParameter("movieCd"));
		
		AdminMovInfoService adminMovInfoService = new AdminMovInfoService();
		MovBean article = adminMovInfoService.getArticle(movieCd);
		
		StillCutFileNameService stillCutFileNameService = new StillCutFileNameService();
		article.setStillCutFileName(stillCutFileNameService.replace(article.getStillCut()));
		
		System.out.println(article.getTrailer());
		
		request.setAttribute("article", article);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/mov/admin_mov.jsp");
		
		return forward;
	}

}
