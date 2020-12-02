package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.NoticeDeleteProService;
import vo.ActionForward;

public class NoticeDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("NoticeDeleteProAction!");
		
		ActionForward forward = null;
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		NoticeDeleteProService noticeDeleteProService = new NoticeDeleteProService();
		
		boolean isDeleteSuccess = 
				noticeDeleteProService.removeArticle(num);
		
		// 삭제 작업 요청 결과 판별
		if(!isDeleteSuccess) { // 삭제 실패 시
			// 자바스크립트를 활용하여 "삭제 실패!" 출력 후
			// 이전페이지로 이동
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else { // 삭제 성공 시
			// ActionForward 객체를 생성하여 "NoticeList.no" 서블릿 요청
	        // Redirect 방식으로 포워딩
			// => URL 뒤에 파라미터로 페이지번호(page)를 전달
			forward = new ActionForward();
			forward.setPath(
					"NoticeList.no?page=" + request.getParameter("page"));
			forward.setRedirect(true);
		}
	
		
		return forward;
	}

}
