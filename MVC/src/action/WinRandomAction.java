package action;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.WinRandomService;
import vo.ActionForward;
import vo.ApplyBean;

public class WinRandomAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("WinRandomAction");
		
		ActionForward forward = null;	
		
		int num= Integer.parseInt(request.getParameter("num"));
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		
		
		
//		System.out.println("이벤트 원글 번호 : " + event_num);
		
		WinRandomService winRandomService = new WinRandomService();
		
//		ArrayList<ApplyBean> articleList= new ArrayList<ApplyBean>();
		
		
		// 해당 이벤트 당첨자 뽑기
		int win_result = winRandomService.getArticleList(event_num);
		System.out.println(win_result);
		
		// 이벤트 당첨자 정보 가져오기
//		ApplyBean win_member = new ApplyBean();
//		win_member = winRandomService.getWinMemberInfo(win_result);
		
		
//		request.setAttribute("articleList", articleList);
		
		
			forward = new ActionForward();
			forward.setPath(
					"WinDetail.wi?num="+ num +
					"&page=" + request.getParameter("page") );
			forward.setRedirect(true);
	
		
		return forward;
	}

}
