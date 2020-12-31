package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import action.Action;
import action.AdminDeleteProAction;
import action.MemberInfoAction;
import action.AdminMemberListAction;
import action.AdminMovDeleteProAction;
import action.AdminMovDetailAction;
import action.MemberLoginProAction;
import action.MemberLogoutAction;
import action.MemberMainAction;
import action.MemberWriteProAction;
import action.MovCommentDeleteProAction;
import action.MovCommentWriteProAction;
import action.MovCurrentMainAction;
import action.MovDetailAction;
import action.MovMainAction;
import action.MovToBeMainAction;
import action.AdminMovListAction;
import action.AdminMovWriteProAction;
import vo.ActionForward;

@WebServlet("*.mo") // 서블릿 주소 중 XXX.bo 주소에 대한 요청을 전달받아 처리
public class MovFrontController extends HttpServlet {
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 서블릿 요청 시 GET 방식 또는 POST 방식의 요청이 들어오면
		// 공통으로 처리하기 위해 doGet(), doPost() 메서드에서 호출하는 메서드
		// => 파라미터로 request 객체와 response 객체를 전달받음
		
		// POST 방식 요청에 대한 한글 처리
		request.setCharacterEncoding("UTF-8");
		
		// 서블릿 주소 가져오기
		String command = request.getServletPath();
		System.out.println("요청 서블릿 주소 : " + command);
		
		// 각 요청에 대한 처리에 필요한 객체를 다루는 변수 선언
		Action action = null;
		ActionForward forward = null;
		
		// if문을 사용하여 각 서블릿 주소 판별 및 각 요청 처리를 위한 작업 요청
		// 1. MemberWriteForm.bo 요청에 대한 처리
		if (command.equals("/AdminMovWrite.mo")) { // 관리자 영화 등록 화면
			forward = new ActionForward();
			forward.setPath("/mov/admin_mov_write.jsp");
			
		} else if (command.equals("/AdminMovWritePro.mo")) { // 관리자 영화등록
			action = new AdminMovWriteProAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		} else if (command.equals("/AdminMovList.mo")) { // 관리자 영화 리스트 조회
			action = new AdminMovListAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		} else if (command.equals("/MovDetail.mo")) { // 영화 상세 정보 조회
			action = new MovDetailAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}		
		} else if (command.equals("/AdminMovDetail.mo")) { // 관리자 영화 상세 정보 조회
			action = new AdminMovDetailAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		} else if (command.equals("/AdminMovDeletePro.mo")) { // 관리자 영화 삭제
			action = new AdminMovDeleteProAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		} else if (command.equals("/MovCommentWritePro.mo")) { // 영화 댓글 등록
			action = new MovCommentWriteProAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		} else if (command.equals("/MovCommentDeletePro.mo")) { // 영화 댓글 삭제
			action = new MovCommentDeleteProAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		}  else if (command.equals("/MovMain.mo")) { // 영화 메인 페이지
			action = new MovMainAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		} else if (command.equals("/MovCurrentMain.mo")) { // 현재 상영작 메인 페이지
			action = new MovCurrentMainAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		}  else if (command.equals("/MovToBeMain.mo")) { // 상영 예정작 메인 페이지
			action = new MovToBeMainAction();
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		}
		
		// ----------------------------------------------------------------------------------------------
		// 기본 설정 후 공통적으로 수행할 포워딩 작업
		// 1. ActionForward 객체 존재 여부 판별(객체가 존재할 때 포워딩 수행)
		if (forward != null) {
			// 2. ActionForward 객체 내의 포워딩 방식에 따라 각각의 포워딩 수행
			// => Redirect 방식 : isRedirect() == true.
			//    Dispatcher 방식 : isRedirect() == false
			if (forward.isRedirect()) {
				// 3. Redirect 방식일 경우
				// response 객체의 sendRedirect() 메서드를 호출하여 포워딩
				// => 파라미터 : 포워딩 할 URL
				response.sendRedirect(forward.getPath());
				
			} else {
				// 4. Dispatcher 방식일 경우
				// 4-1. request 객체의 getRequestDispatcher() 메서드를 호출하여
				//      RequestDispatcher 객체를 리턴받기
				//      => 파라미터 : 포워딩 할 URL
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				// 4-2. RequestDispatcher 객체의 forward() 메서드를 호출하여
				//      포워딩 수행(파라미터 : request, response 객체)
				dispatcher.forward(request, response);
				
			}
		}
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 서블릿 요청 시 GET 방식 요청이 들어오면 자동으로 호출되는 메서드
		// => 파라미터로 request 객체와 response 객체를 전달받음
		doProcess(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 서블릿 요청 시 POST 방식 요청이 들어오면 자동으로 호출되는 메서드
		// => 파라미터로 request 객체와 response 객체를 전달받음
		doProcess(request, response);
		
	}

}
