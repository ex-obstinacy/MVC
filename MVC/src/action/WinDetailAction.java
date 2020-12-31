package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.WinDetailService;
import vo.ActionForward;
import vo.WinBean;

public class WinDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("WinDetailAction!!");
		
		ActionForward forward = null;
		
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("게시물 번호 : " + num);
		String nowPage = request.getParameter("page"); 
		System.out.println("게시물 페이지 : " + nowPage);
		
		WinDetailService winDetailService = new WinDetailService();
		WinBean article = winDetailService.getArticle(num);
		
		// event_num 으로 해당 이벤트에 참여한 사람수 구하기
		int event_num = article.getEvent_num();
		int partiMemberCount = winDetailService.getPartiMemberCount(event_num);
		System.out.println("해당 이벤트에 참여한 사람수 : " + partiMemberCount +"명");
		
		request.setAttribute("article", article);
		request.setAttribute("partiMemberCount", partiMemberCount);
		
		forward = new ActionForward();
		forward.setPath("/win/win_view.jsp");
		
		return forward;
	}

}
