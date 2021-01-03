package action;

import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.WinWriteProService;
import vo.ActionForward;
import vo.WinBean;

public class WinWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("WinWriteProAction!");
		
		ActionForward forward = null;

		WinBean article = new WinBean();	
		article.setSubject(request.getParameter("subject"));
		article.setContent(request.getParameter("content"));
//		article.setMember_id(request.getParameter("member_id"));
		article.setEvent_num(Integer.parseInt(request.getParameter("event_num")));
		
		
		Timestamp date = new Timestamp(System.currentTimeMillis());
		article.setDate(date);
		
		WinWriteProService winWriteProService = new WinWriteProService();
		
		// 해당 이벤트가 존재하는 이벤트인지 확인하기
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		boolean isEventExist = winWriteProService.hasEvent(event_num);
		if(!isEventExist) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('존재하지 않는 이벤트 번호입니다.')"); // 다이얼로그 메세지 출력
			out.println("history.back()"); // 이전 페이지로 이동
			out.println("</script>");
		} else {
			// 글쓰기 작업 성공여부 확인하기
			boolean isWriteSuccess = winWriteProService.registArticle(article);
			
			if(!isWriteSuccess) {
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
				out.println("alert('이벤트 당첨 발표글 등록 실패!')"); // 다이얼로그 메세지 출력
				out.println("history.back()"); // 이전 페이지로 이동
				out.println("</script>"); // 자바스크립트 끝 태그
			} else {
				// 1. ActionForward 객체 생성
				forward = new ActionForward();
				// 2. 포워딩 경로(URL) 지정
				//    (주의! 경로명 앞에 슬래시(/) 기호 붙이지 말 것!)
				forward.setPath("WinList.wi");
				// 3. 포워딩 방식(Redirect 방식) 지정
				forward.setRedirect(true);
			}
		}
		
		return forward;
	}

}
