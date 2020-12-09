package action;

import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exception.LoginException;
import svc.MemberLoginProService;
import svc.MemberUpdateProService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberUpdateProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberUpdateProAction");
		
		System.out.println();
		
		ActionForward forward = null;
		
		// 비밀번호 확인
		String chPass = request.getParameter("pass");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		MemberLoginProService memberLoginProService = new MemberLoginProService();
		
		try {
			boolean isMember = memberLoginProService.isLoginMember(id, chPass);
			
			if (isMember) {
				MemberBean memberBean = new MemberBean();
				
				// 비밀번호 변경 시
				String pass = request.getParameter("chPass");
				if (pass == "") {
					pass = chPass;
					
				}
				
				// 이메일 변경 시
				String email = request.getParameter("chEmail");
				if (email == "") {
					email = request.getParameter("email");
					
				}
				
				memberBean.setId(id);
				memberBean.setPass(pass);
				memberBean.setName(request.getParameter("name"));
				memberBean.setPhone(request.getParameter("phone"));
				memberBean.setEmail(email);
				memberBean.setGender(request.getParameter("gender"));
				memberBean.setBirthday(Date.valueOf(request.getParameter("birthday")));
				memberBean.setPostcode(request.getParameter("postcode"));
				memberBean.setAddress(request.getParameter("address"));
				memberBean.setDetailAddress(request.getParameter("detailAddress"));
				memberBean.setExtraAddress(request.getParameter("extraAddress"));
				
				MemberUpdateProService memberUpdateProService = new MemberUpdateProService();
				boolean isUpdateSuccess = memberUpdateProService.updateMember(memberBean);
				
				if (isUpdateSuccess) {
					forward = new ActionForward();
					forward.setPath("MemberMain.me");
					forward.setRedirect(true);
					
					
				} else {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>"); // 자바스크립트 시작 태그
					out.println("alert('회원정보 수정 실패!')"); // 다이얼로그 메세지 출력
					out.println("history.back()"); // 이전 페이지로 이동
					out.println("</script>");
				}
				
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
