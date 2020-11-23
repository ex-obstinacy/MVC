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
		
		if (command.equals("/CinemaAddForm.re")) {
			forward = new ActionForward();
			forward.setPath("/reservation/cinemaInsertForm.jsp");
//			forward.setRedirect(false);
		} else if (command.equals("/CinemaAddPro.re")) {
			action = new CinemaAddProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/SelectSeat.re")) { // 좌석 선택 페이지
			action = new SelectSeatAction() ;
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/PayForm.re")) { // 결제 폼 페이지
			action = new PayFormAction();
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
