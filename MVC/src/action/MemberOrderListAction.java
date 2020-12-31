package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberOrderListService;
import vo.ActionForward;
import vo.PageInfo;
import vo.StoreBean;

public class MemberOrderListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberOrderListAction");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession(); //MemberBean id 값 가져오기
	    String id = (String)session.getAttribute("id");
		
		int page = 1; // 현재 페이지 번호 저장할 변수
		int limit = 10; // 페이지 당 표시할 게시물 수를 결정하는 변수
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		MemberOrderListService memberorderListService = new MemberOrderListService();
		int listCount = memberorderListService.getOrderListCount(id);
		
		ArrayList<StoreBean> articleList = new ArrayList<StoreBean>();
		articleList = memberorderListService.getOrderList(page, limit, id);
		
		int maxPage = (int)((double)listCount / limit + 0.95);
		
		int startPage = ((int)((double)page / 10 + 0.9) - 1) * 10 + 1;
		
		int endPage = startPage + 10 - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);

		request.setAttribute("articleList", articleList);
		request.setAttribute("pageInfo", pageInfo);
		
		forward = new ActionForward();
		forward.setPath("/member/member_orderList.jsp");
		
		return forward;
	}

}
