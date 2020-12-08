package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MovieNumFindService;
import vo.ActionForward;

public class MovieNumFindAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
//		System.out.println("MovieNumFindAction");
		
		ActionForward forward = null;
		
		String movie = request.getParameter("movie");
		String local = request.getParameter("local");
		String cinema = request.getParameter("cinema");
		String date = request.getParameter("date");
		String time = request.getParameter("time");
		
		MovieNumFindService movieNumFindService = new MovieNumFindService();
		int movienum = movieNumFindService.findMovieNum(movie, local, cinema, date, time);
		
		forward = new ActionForward();
		forward.setPath("SelectSeat.re?movienum=" + movienum);
		forward.setRedirect(true);
		
		return forward;
	}

}
