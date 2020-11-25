package action;

import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import exception.LoginException;
import svc.MemberLoginProService;
import vo.ActionForward;

public class MemberLoginProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberLoginProAction!");
		
		ActionForward forward = null;
		
		String id = request.getParameter("name");
		String pass = request.getParameter("password");
		
		MemberLoginProService memberLoginProService = new MemberLoginProService();
		
		try {
			boolean isMember = memberLoginProService.isLoginMember(id, pass);
			
			if (isMember) {
				// 로그인 성공 시 아이디값을 세션 객체에 추가
				// 1. HttpSession 객체를 가져오기
				HttpSession session = request.getSession();
				// 2. HttpSession 객체의 setAttribut() 메서드 호출하여 아이디 추가
				session.setAttribute("id", id);
				
				forward = new ActionForward();
				forward.setPath("./");
				forward.setRedirect(true);
				
			}
			
		} catch (LoginException e) {
			// LoginException 예외가 발생하여 외부로 위임되고
			// 현재 위치에서 catch 문을 통해 예외를 전달받게 됨
			// => 전달받은 예외 객체의 메세지를 자바스크립트로 출력하면
			//    로그인 실패 원인에 대한 결과 메세지 출력 구분 가능
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('" + e.getMessage() +"')"); // 실패 메세지 출력
			out.println("history.back()"); // 이전 페이지로 이동
			out.println("</script>");
			
		}
		
		return forward;
	}

}
