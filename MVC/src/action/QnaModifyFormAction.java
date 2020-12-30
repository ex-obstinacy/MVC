package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.QnaDetailService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		// 원본 게시물 정보 요청에 필요한 글번호(board_num) 파라미터 가져오기
		int num = Integer.parseInt(request.getParameter("num"));
		
		// 원본 게시물 정보 요청을 위해 새로운 Service 클래스를 정의하지 않고
		// 기존의 QnaDetailService 클래스의 getArticle() 메서드를 호출하여
		// 원본 게시물 정보 요청을 수행
		// => 파라미터 : 글번호(num), 리턴타입 : qnaBean(article)
		QnaDetailService qnaDetailService = new QnaDetailService();
		QnaBean article = qnaDetailService.getArticle(num);
		
		// request 객체에 원본 게시물 정보(QnaBean) 저장
		request.setAttribute("article", article);
		
		// ActionForward 객체를 생성하여 qna_board_modify.jsp 페이지로 포워딩
		// => Dispatcher 방식
		forward = new ActionForward();
		forward.setPath("/qna/qna_modify.jsp");
		
		return forward;
	}

}


