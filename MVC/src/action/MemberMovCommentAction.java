package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberMovCommentService;
import svc.MovCommentListService;
import vo.ActionForward;
import vo.MovCommentBean;
import vo.PageInfo;

public class MemberMovCommentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberMovCommentAction");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		int page = 1; // 현재 페이지 번호 저장할 변수
		int limit = 5; // 페이지 당 표시할 게시물 수를 결정하는 변수
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		MemberMovCommentService memberMovCommentService = new MemberMovCommentService();
		
		int listCount = memberMovCommentService.getListCount(id);
		ArrayList<MovCommentBean> articleList = new ArrayList<MovCommentBean>();
		articleList = memberMovCommentService.getArticleList(page, limit, id);
		
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
		forward.setPath("/member/member_mb_comment.jsp");
		return forward;
	}

}
