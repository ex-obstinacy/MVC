package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.WinListSearchService;
import vo.ActionForward;
import vo.PageInfo;
import vo.WinBean;

public class WinListSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		// 페이징 처리를 위한 변수 선언
		int page = 1; // 현재 페이지 번호 저장할 변수
		int limit = 10; // 페이지 당 표시할 게시물 수를 결정하는 변수
		String search=request.getParameter("search");
		
		// request 객체로부터 "page" 파라미터가 전달됐을 경우(null 이 아닐 경우)
		// 해당 파라미터 값을 page 변수에 저장(String -> int 변환 필요)
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		WinListSearchService winListSearchService = new WinListSearchService();
		int listCount =winListSearchService.getListCount(search);
		
		ArrayList<WinBean> articleList = new ArrayList<WinBean>();
		
		articleList = winListSearchService.getArticleList(page, limit, search);
		
		
		int maxPage = (int)((double)listCount / limit + 0.95);
		
		// 2. 현재 페이지에서 보여줄 시작 페이지 번호(1, 11, 21 페이지 등)
		int startPage = ((int)((double)page / 10 + 0.9) - 1) * 10 + 1;
		
		// 3. 현재 페이지에서 보여줄 마지막 페이지 번호(10, 20, 30 페이지 등)
		int endPage = startPage + 10 - 1;
		
		// 4. 마지막 페이지가 현재 페이지에서 표시할 
		//    최대 페이지(전체 페이지) 수 보다 클 경우
		//    마지막 페이지 번호를 전체 페이지 번호로 대체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 계산된 모든 페이지 정보를 PageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(
				page, maxPage, startPage, endPage, listCount);

		// request 객체의 setAttribute() 메서드를 호출하여
		// 게시물 목록 정보(ArrayList)와 페이지 정보(PageInfo) 객체를 저장
		request.setAttribute("articleList", articleList);
		request.setAttribute("pageInfo", pageInfo);
		
		// ActionForward 객체를 생성하여 qna_board_list.jsp 페이지로 포워딩 설정
		// => request 객체가 유지되어야 하며, 서블릿 주소가 유지되어야 하므로
		//    Dispatcher 방식으로 포워딩 설정
		forward = new ActionForward();
		forward.setPath("/win/win_listSearch.jsp");
//		forward.setRedirect(false); // 기본값 false 이므로 생략 가능
		
		return forward;
	}

}		