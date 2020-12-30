package action;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.WinRandomService;
import vo.ActionForward;
import vo.ApplyBean;
import vo.WinBean;

public class WinRandomAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("WinRandomAction");
		
		ActionForward forward = null;	
		
		// 이벤트 번호 num
		int num= Integer.parseInt(request.getParameter("num"));
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		
		WinRandomService winRandomService = new WinRandomService();
		
//		ArrayList<ApplyBean> articleList= new ArrayList<ApplyBean>();
		
		
		// 해당 이벤트 당첨자 뽑기(1명)
		int win_result = winRandomService.getArticleList(event_num);
		
		// 이벤트 당첨자 정보 가져오기(1명) -> 나중에는 ApplyBean을 list 에 담기
		WinBean win_member = new WinBean();
		win_member = winRandomService.getWinMemberInfo(win_result);
		
//		request.setAttribute("articleList", articleList);
		
		// 이벤트 번호, 당첨자 아이디(1명)
		System.out.println("응모한 이벤트번호 : " + win_member.getEvent_num());
		System.out.println("당첨자 아이디 : " + win_member.getMember_id());
		
		// 당첨자 아이디를 win 테이블의 member_id 에 저장하기(1명)
		int updateCount = winRandomService.updateWinMember(win_member);
		if(updateCount > 0) {
			System.out.println("당첨자 저장 완료!");
			forward = new ActionForward();
			forward.setPath("WinDetail.wi?num="+ num + "&page=" + request.getParameter("page"));
			forward.setRedirect(true);
		} else {
			System.out.println("당첨자 저장 실패!");
		}
		
		return forward;
	}

}
