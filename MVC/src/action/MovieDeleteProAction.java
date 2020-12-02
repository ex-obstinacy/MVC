package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MovieDeleteProService;
import vo.ActionForward;

public class MovieDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		int movie_num = Integer.parseInt(request.getParameter("movie"));
		
		MovieDeleteProService movieDeleteProService = new MovieDeleteProService();
		boolean isDeleteSuccess = movieDeleteProService.removeMovie(movie_num);
		if(isDeleteSuccess) {
			// 삭제성공
			forward = new ActionForward();
			forward.setPath("MovieAddForm.re");
			forward.setRedirect(true);
		} else {
			// 삭제실패
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	
	}

}
