package action;

import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.EventApplyInsertService;
import vo.ActionForward;
import vo.ApplyBean;

public class EventApplyInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("EventApplyInsertAction!");
		
		ActionForward forward = null;	
		
	int event_num= Integer.parseInt(request.getParameter("num"));	
	HttpSession session = request.getSession(); // MemberBean id 값 가져오기
	
	String member_id = (String) session.getAttribute("id");
	
	int win = 0;
	
	System.out.println("이벤트 글 번호 : "+event_num);
	System.out.println("응모자 아이디 : " + member_id);
	
	ApplyBean applyBean = new ApplyBean();
	applyBean.setWin(win);
	applyBean.setMember_id(member_id);
	applyBean.setEvent_num(event_num);
	
	
	Timestamp date = new Timestamp(System.currentTimeMillis());
	applyBean.setDate(date);
	
	EventApplyInsertService eventApplyInsertService = new EventApplyInsertService();
	boolean checkApply = eventApplyInsertService.checkApplyEvent(member_id , event_num) ;
	
	
	
	if(!checkApply) {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('이미 응모한 이벤트입니다.')");
		out.println("history.back()");
		out.println("</script>");
	}else {
		
		eventApplyInsertService = new EventApplyInsertService();
		boolean isInsertSuccess = eventApplyInsertService.registArticle(applyBean);
		
		// 글쓰기 작업 수행 후 리턴받은 결과값을 사용하여
		// 글쓰기 성공/실패 여부를 판단
		// => 만약, 실패했을 경우 자바스크립트를 사용하여 이전페이지로 이동
		// => 만약, 성공했을 경우 ActionForward 객체를 생성하여
		//    포워딩 경로(BoardList.bo)와 방식(새 요청이므로 Redirect) 지정
		if(!isInsertSuccess) {
			// 글쓰기 작업 실패 시 자바스크립트를 통해 
			// 실패 메세지 출력 후 이전 페이지로 이동
			// => 자바 코드를 사용하여 응답페이지 생성
			// 1. response 객체의 setContentType() 메서드를 호출하여
			// 문서 타입 및 캐릭터셋 설정
			response.setContentType("text/html; charset=UTF-8");
			// 2. response 객체의 getWrite() 메서드를 호출하여
			//    출력스트림 객체를 리턴받아 PrintWriter 타입으로 저장
			PrintWriter out = response.getWriter();
			// 3. PrintWriter 객체의 println() 메서드를 호출하여
			//    응답페이지에서 수행할 작업을 기술
			//    => 모든 작업(자바스크립트, 태그 등)은 문자열로 지정
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('회원 이벤트 응모  실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back()"); // 이전 페이지로 이동
			out.println("</script>"); // 자바스크립트 끝 태그
		} else {
			// 1. ActionForward 객체 생성
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('회원 이벤트 응모 완료!')"); // 다이얼로그 메세지 출력
			
			out.println("</script>"); // 자바스크립트 끝 태그
			forward = new ActionForward();
			// 2. 포워딩 경로(URL) 지정
			//    (주의! 경로명 앞에 슬래시(/) 기호 붙이지 말 것!)
			forward.setPath(
					"EventDetail.ev?num=" + event_num +
					"&page=" + request.getParameter("page") );
			// 3. 포워딩 방식(Redirect 방식) 지정
			forward.setRedirect(true);
		}
	}
	
	
	return forward;
	}

}
