package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import svc.QnaDeleteProService;
import vo.ActionForward;

public class QnaDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("QnaDeleteProAction!");
		
		ActionForward forward = null;
		
		int num = Integer.parseInt(request.getParameter("num")); // 글 번호 
		System.out.println(num);
		int re_ref = Integer.parseInt(request.getParameter("re_ref")); // 원글 번호
		
		System.out.println(re_ref);
		int re_lev = Integer.parseInt(request.getParameter("re_lev")); // re_lev 가 0이면 원글, 0이 아니면 답글
		System.out.println(re_lev);
		if(re_lev ==0) {
			// 삭제하고자 하는 글이 원글일때 , 답글까지 전부 삭제 
			
			QnaDeleteProService qnaDeleteProService = new QnaDeleteProService();
			
			boolean isDeleteSuccess = 
					qnaDeleteProService.removeArticle(re_ref);
			System.out.println("re_ref(원글번호): " + re_ref);
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
						"QnaList.qn?page=" + request.getParameter("page"));
				forward.setRedirect(true);
			}
			
		}else {
			// 삭제하고자 하는 글이 답글일때, 답글만 삭제 
			QnaDeleteProService qnaDeleteProService = new QnaDeleteProService();
			
			boolean isDeleteSuccess = 
					qnaDeleteProService.removeReplyArticle(num);
			
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
						"QnaList.qn?page=" + request.getParameter("page"));
				forward.setRedirect(true);
			}
		}
		
		return forward;
	}

}
