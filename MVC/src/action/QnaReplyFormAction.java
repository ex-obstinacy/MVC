package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.QnaDetailService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaReplyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 답변글 작성을 위한 원본 게시물 정보 가져오기
		// => QnaModifyFormAction 과 거의 동일함
		System.out.println("QnaReplyFormAction");
		
		ActionForward forward = null;
		
		// 원본 게시물 정보 요청에 필요한 글번호(board_num) 파라미터 가져오기
		int num = Integer.parseInt(request.getParameter("num"));
//		String nowPage = request.getParameter("page");
//		System.out.println("게시물 페이지 : " +nowPage);
//		System.out.println("게시물 번호 : "+num);
		// 원본 게시물 정보 요청을 위해 새로운 Service 클래스를 정의하지 않고
		// 기존의 BoardDetailService 클래스의 getArticle() 메서드를 호출하여
		// 원본 게시물 정보 요청을 수행
		// => 파라미터 : 글번호(board_num), 리턴타입 : BoardBean(article)
		QnaDetailService qnaDetailService = new QnaDetailService();
		QnaBean article = qnaDetailService.getArticle(num);
		
		// request 객체에 원본 게시물 정보(BoardBean) 저장
		request.setAttribute("article", article);
		
		// ActionForward 객체를 생성하여 qna_board_reply.jsp 페이지로 포워딩
		// => Dispatcher 방식
		forward = new ActionForward();
		forward.setPath("/qna/qna_reply.jsp");
		
		return forward;
	}
}