package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberSendMailService;
import svc.MovCommentWriteProService;
import vo.ActionForward;
import vo.MovCommentBean;

public class MovCommentWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovCommentWriteProAction");
		
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		System.out.println();
		
		if (id != null) {
			MovCommentBean movCommentBean = new MovCommentBean();
			movCommentBean.setMember_id(id);
			movCommentBean.setCmgrade(Integer.parseInt(request.getParameter("cmgrade")));
			movCommentBean.setContent(request.getParameter("content"));
			movCommentBean.setMovie_board_movCode(Integer.parseInt(request.getParameter("movie_board_movCode")));
			
			MovCommentWriteProService movCommentWriteProService = new MovCommentWriteProService();
			boolean isWriteSuccess = movCommentWriteProService.registArticle(movCommentBean);
			
			if (isWriteSuccess) {
				forward.setPath("MovDetail.mo?movieCd="+movCommentBean.getMovie_board_movCode());
				forward.setRedirect(true);
				
			} else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>"); // 자바스크립트 시작 태그
				out.println("alert('댓글 등록 실패!')"); // 다이얼로그 메세지 출력
				out.println("history.back()"); // 이전 페이지로 이동
				out.println("</script>"); // 자바스크립트 끝 태그
				
			}
			
		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('회원가입이 필요 합니다!')"); // 다이얼로그 메세지 출력
			out.println("history.back()"); // 이전 페이지로 이동
			out.println("</script>"); // 자바스크립트 끝 태그
			
		}
		
		return forward;
	}

}
