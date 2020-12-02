package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.CinemaAddProAction;
import action.CinemaDeleteProAction;
import action.MovieAddProAction;
import action.MovieDeleteProAction;
import action.PayFormAction;
import action.SelectSeatAction;
import vo.ActionForward;

@WebServlet("*.re")		// Reserve 관련 페이지 서블릿주소
public class ReserveFrontController extends HttpServlet {
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Post방식 요청시  한글 처리
		request.setCharacterEncoding("utf-8");
		
		String command = request.getServletPath();
		System.out.println("요청 서블릿 주소 : " + command);
		
		// 각 요청에 대한 처리에 필요한 객체를 다루는 변수 선언
		Action action = null;
		ActionForward forward = null;
		
		if (command.equals("/SelectSeat.re")) { // 좌석 선택 페이지
			action = new SelectSeatAction() ;
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/PayForm.re")) { // 결제 폼 페이지
			action = new PayFormAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/CinemaAddForm.re")) { // 관리자 - 영화관 등록 폼 페이지
			forward = new ActionForward();
			forward.setPath("/reservation/cinemaAddForm.jsp");
//			forward.setRedirect(false);
		} else if (command.equals("/CinemaAddPro.re")) { // 관리자 - 영화관 등록 Pro
			action = new CinemaAddProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MovieAddForm.re")) { // 관리자 - 영화 등록(예매) 폼 페이지
			forward = new ActionForward();
			forward.setPath("/reservation/movieAddForm.jsp");
//			forward.setRedirect(false);
		} else if (command.equals("/MovieAddPro.re")) { // 관리자 - 영화 등록 Pro
			action = new MovieAddProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/ReserveMain.re")) { // 사용자 - 예매 폼 페이지
			forward = new ActionForward();
			forward.setPath("/reservation/reserveMain.jsp");
//			forward.setRedirect(false);
		} else if (command.equals("/CinemaDeletePro.re")) { // 관리자 - 영화관 삭제 Pro
			action = new CinemaDeleteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MovieDeletePro.re")) { // 관리자 - 영화(예매) 삭제 Pro
			action = new MovieDeleteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		if(forward != null) {
			
			if(forward.isRedirect()) {
				// Redirect 방식으로 포워딩
				response.sendRedirect(forward.getPath());
			} else {
				// Dispatcher 방식으로 포워딩
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
			
		}
		
	}
	
	// ----------------------------------------------------------------------------------------------------------------------------
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
