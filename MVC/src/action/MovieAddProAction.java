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
		
		int movie_code = Integer.parseInt(request.getParameter("movie_code"));
		String seltime = request.getParameter("seltime");
		String selguan = request.getParameter("selguan");
		String time = seltime + "(" +selguan + ")";
		
		ReserveBean movie = new ReserveBean();
		movie.setMovie_code(movie_code);
		movie.setCinema_name(request.getParameter("cinema"));
		movie.setShowdate(request.getParameter("date"));
		movie.setShowtime(time);
		
		MovieAddProService movieAddProService = new MovieAddProService();
		
		// 영화 코드로 영화 제목, 연령제한 가져오기
		String movie_subject = movieAddProService.getMovieSubject(movie_code);
		String movie_grade = movieAddProService.getMovieGrade(movie_code);
//		System.out.println(movie_subject);
//		System.out.println(movie_grade);
		System.out.println(movie_grade);
		movie.setMovie_subject(movie_subject);
		movie.setMovie_grade(movie_grade);
		
		// 영화 등록하기
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
