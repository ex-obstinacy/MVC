package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.PayProService;
import vo.ActionForward;
import vo.ReserveBean;

public class PayProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int movienum = Integer.parseInt(request.getParameter("movienum"));
		
		ReserveBean reservation = new ReserveBean();
//		reservation.setMember_id(request.getParameter("member_id")); // 원래 코드
		reservation.setMember_id("kim"); // 임시 코드
		reservation.setMovienum(movienum);
		reservation.setAdultnum(Integer.parseInt(request.getParameter("adultnum")));
		reservation.setKidsnum(Integer.parseInt(request.getParameter("kidsnum")));
		reservation.setSeatArr(request.getParameterValues("seat"));
		reservation.setFree_ticket(Integer.parseInt(request.getParameter("useTicket")));
		reservation.setUse_coupon(request.getParameter("coupon_select"));
		
		PayProService payProService = new PayProService();
		boolean isReserveSuccess = payProService.reserveMovie(reservation);
		
		if(isReserveSuccess) {	
			String ticketnum = payProService.getTicketNum(reservation);
			
			if(ticketnum != null) {
				forward = new ActionForward();
				forward.setPath("ReserveResult.re?ticketnum=" + ticketnum);
				forward.setRedirect(true);	
			} else {
				response.setContentType("text/html; charset=UTF-8");
				
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('티켓 번호 없음!')"); 
				out.println("location.href='http://localhost:8080/MVC/ReserveMain.re'");
				out.println("</script>"); 
			}
			
		} else {
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('예매 실패!')"); 
			out.println("history.back()");
			out.println("</script>"); 
		}
			
		
		return forward;
	}

}
