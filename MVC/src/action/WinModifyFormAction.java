package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.WinDetailService;
import vo.ActionForward;

import vo.WinBean;

public class WinModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("WinModifyFormAction!");
		
		ActionForward forward = null;
		
		// 원본 게시물 정보 요청에 필요한 글번호(num) 파라미터 가져오기
		int num = Integer.parseInt(request.getParameter("num"));
		
		// 원본 게시물 정보 요청을 위해 새로운 Service 클래스를 정의하지 않고
		// 기존의 NoticeDetailService 클래스의 getArticle() 메서드를 호출하여
		// 원본 게시물 정보 요청을 수행
		// => 파라미터 : 글번호(num), 리턴타입 : NoticeBean(article)
		WinDetailService winDetailService = new WinDetailService();
		WinBean article = winDetailService.getArticle(num);
		
		// request 객체에 원본 게시물 정보(NoticeBean) 저장
		request.setAttribute("article", article);
		
		System.out.println(article.getSubject());
//		System.out.println(article.getContent());
		
		// ActionForward 객체를 생성하여 notice_modify.jsp 페이지로 포워딩
		// => Dispatcher 방식
		forward = new ActionForward();
		forward.setPath("/win/win_modify.jsp");
		
		return forward;
	}

}
