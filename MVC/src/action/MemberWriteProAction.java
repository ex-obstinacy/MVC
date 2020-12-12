package action;

import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.MemberWriteProService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberWriteProAction!");
		
		// 회원가입을 위한 입력정보 MemberBean에 저장
		MemberBean memberBean = new MemberBean();
		memberBean.setId(request.getParameter("id"));
		memberBean.setPass(request.getParameter("pass"));
		memberBean.setName(request.getParameter("name"));
		memberBean.setPhone(request.getParameter("phone"));
		memberBean.setEmail(request.getParameter("email"));
		memberBean.setGender(request.getParameter("gender"));
		memberBean.setBirthday(Date.valueOf(request.getParameter("birthday")));
		memberBean.setPostcode(request.getParameter("postcode"));
		memberBean.setAddress(request.getParameter("address"));
		memberBean.setDetailAddress(request.getParameter("detailAddress"));
		memberBean.setExtraAddress(request.getParameter("extraAddress"));
		
		MemberWriteProService memberWriteProSevice = new MemberWriteProService();
		boolean isWriteSuccess = memberWriteProSevice.registArticle(memberBean);
		
		// 1. ActionForward 객체 생성
		ActionForward forward = new ActionForward();
		
		if (isWriteSuccess) {
			// 2. 포워딩 경로(URL) 지정
			//    (주의! 경로명 앞에 슬래시(/) 기호 붙이지 말 것!)
			forward.setPath("MemberLogin.me");
			// 3. 포워딩 방식(Redirect 방식) 지정
//			forward.setRedirect(true);
			
		} else {
			// 글쓰기 작업 실패 시 자바스크립트를 통해
			// 실패 메세지 출력 후 이전 페이지로 이동
			// 1. response 객체의 setContentType() 메서드를 호출하여
			//    문서 타입 및 개릭터셋 설정
			response.setContentType("text/html; charset=UTF-8");
			// 2. response 객체의 getWrite() 메서드를 호출하여
			//    출력스트림 객체를 리턴받아 PrintWriter 타입으로 저장
			PrintWriter out = response.getWriter();
			// 3. PrintWriter 객체의 println() 메서드를 호출하여
			//    응답페이지에서 수행할 작업을 기술
			//    => 모든 작업(자바스크립트, 태그 등)은 문자열로 지정
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('회원 등록 실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back()"); // 이전 페이지로 이동
			out.println("</script>"); // 자바스크립트 끝 태그
			
		}
				
		return forward;
	}

}
