package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.QnaListService;
import vo.ActionForward;
import vo.PageInfo;
import vo.QnaBean;

public class MemberQnADetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberQnADetailAction");
		
		HttpSession session = request.getSession(); // MemberBean id 값 가져오기
		String id = (String) session.getAttribute("id");
		
		// 페이징 처리를 위한 변수 선언
		int page = 1; // 현재 페이지 번호 저장할 변수
		int limit = 10; // 페이지 당 표시할 게시물 수를 결정하는 변수
		// request 객체로부터 "page" 파라미터가 전달됐을 경우(null 이 아닐 경우)
		// 해당 파라미터 값을 page 변수에 저장(String -> int 변환 필요)
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		QnaListService qnaListService = new QnaListService();
		int listCount = qnaListService.getListCount();
		ArrayList<QnaBean> articleList = new ArrayList<QnaBean>();
		articleList = qnaListService.getUserArticleList(id, page, limit);
		int maxPage = (int) ((double) listCount / limit + 0.95);
		int startPage = ((int) ((double) page / 10 + 0.9) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);
		
		System.out.println("확인 : " + articleList.size());

		request.setAttribute("articleList", articleList);
		request.setAttribute("pageInfo", pageInfo);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/member_qna.jsp");
		return forward;
	}

}
