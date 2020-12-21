package action;

import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.QnaReplyProService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaReplyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		 * 답변글 작성 요청하기
		 * - 전달받은 파라미터(답글 작성에 필요한 모든 파라미터) 가져오기
		 *   => QnaBean 객체에 저장
		 * - QnaReplyProService 클래스의 replyArticle() 메서드를 호출하여
		 *   답변글 작성 요청
		 *   => 파라미터 : QnaBean, 리턴타입 : boolean(isReplySuccess)
		 */
		System.out.println("QnaReplyProAction!");
		
		ActionForward forward = null;
		
		String nowPage = request.getParameter("page");
		int num = Integer.parseInt(request.getParameter("num"));
//		System.out.println("게시물 페이지 : " +nowPage);
//		System.out.println("게시물 번호 : "+num);
		
		QnaBean article = new QnaBean();
		article.setNum(Integer.parseInt(request.getParameter("num")));
//	
		article.setSubject(request.getParameter("subject"));
		article.setContent(request.getParameter("content"));
		
		article.setRe_ref(Integer.parseInt(request.getParameter("re_ref")));
		article.setRe_lev(Integer.parseInt(request.getParameter("re_lev")));
		article.setRe_seq(Integer.parseInt(request.getParameter("re_seq")));
		
		article.setMember_id(request.getParameter("member_id")); // 이거 널
		Timestamp date = new Timestamp(System.currentTimeMillis());
		article.setDate(date);
		article.setP_member_id(request.getParameter("p_member_id"));
		
		QnaReplyProService qnaReplyProService = new QnaReplyProService();
		boolean isReplySuccess = QnaReplyProService.replyArticle(article);
//		System.out.println();
//		System.out.println(article.toString());
		
		// 답변글 작성 요청 결과에 따른 판별 작업 수행 
		// 작성 실패 시(isReplySuccess 가 false 일 경우)
		// => 자바 스크립트를 사용해서 "답글 등록 실패 ! " 출력 후 이전 페이지 이동 
		// 작성 성공시 ActionForward 객체를 생성하여 
		// BoardList.bo 서블릿 주소를 요청하여 포워딩
		// => 서블릿 주소 뒤에 파라미터로 페이지 번호(page) 전달
		// => Redirect 방식으로 포워딩
		
		if(!isReplySuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('답글 등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			forward = new ActionForward();
			forward.setPath("QnaList.qn?page=" +request.getParameter("page"));
			forward.setRedirect(true);
		}
		
		return forward;
	}

}
