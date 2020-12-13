package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MovieAddProService;
import vo.ActionForward;
import vo.ReserveBean;

public class MovieAddProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		String seltime = request.getParameter("seltime");
		String selguan = request.getParameter("selguan");
		String time = seltime + "(" +selguan + ")";
		
		ReserveBean movie = new ReserveBean();
		movie.setMovie_subject(request.getParameter("movie_subject"));
		movie.setCinema_name(request.getParameter("cinema"));
		movie.setShowdate(request.getParameter("date"));
		movie.setShowtime(time);
		
		MovieAddProService movieAddProService = new MovieAddProService();
		
		boolean isMovieAddSuccess = movieAddProService.addMovie(movie);
		
		if(isMovieAddSuccess) {
			// 영화 등록 성공
			forward = new ActionForward();
			forward.setPath("MovieAddForm.re");
			forward.setRedirect(true);
		} else {
			// 영화 등록 실패
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('영화 등록 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
		
	}

}
