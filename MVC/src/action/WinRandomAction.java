package action;


import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Set;

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
		
		// 해당 이벤트에 이미 당첨자가 있는지 확인하기
		boolean hasWinMember = winRandomService.hasWinMember(event_num);
		if(hasWinMember) {
			// 당첨자 있음 -> 추첨 완료
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('이미 추첨한 이벤트입니다!')");
			out.println("history.back()");
			out.println("</script>");
		} else {	// 당첨자 없음 -> 추첨해야함!
			// 해당 이벤트 당첨자 뽑기
			Set<Integer> win_members = winRandomService.getArticleList(event_num);	// 당첨자 num
			
			// 이벤트 당첨자 정보 가져오기 -> 여러명일 수도 있으니까 List에 담기
			ArrayList<WinBean> winMemberList = new ArrayList<WinBean>();
			winMemberList = winRandomService.getWinMemberInfo(win_members);
			
			request.setAttribute("winMemberList", winMemberList);
//			
			// 이벤트 번호, 당첨자 아이디(일단 2명)
//			System.out.println("응모한 이벤트번호 : " + winMemberList.get(0).getEvent_num());
//			System.out.println("당첨자 아이디 : " + winMemberList.get(0).getMember_id());
//			System.out.println("응모한 이벤트번호 : " + winMemberList.get(1).getEvent_num());
//			System.out.println("당첨자 아이디 : " + winMemberList.get(1).getMember_id());
//			
			// 당첨자 아이디를 win 테이블의 member_id 에 저장하기(2명)
//			String win_member_ids = "winMemberList.get(0).getMember_id()/winMemberList.get(1).getMember_id()";
			boolean isUpdateSuccess = winRandomService.updateWinMember(winMemberList);
			if(isUpdateSuccess) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('당첨자 저장 성공!')");
				out.println("</script>");
				forward = new ActionForward();
				forward.setPath("WinDetail.wi?num="+ num + "&page=" + request.getParameter("page"));
				forward.setRedirect(true);
			} else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('당첨자 저장 실패!')");
				out.println("history.back()");
				out.println("</script>");
			}
			
		}
		
		return forward;
	}

}
