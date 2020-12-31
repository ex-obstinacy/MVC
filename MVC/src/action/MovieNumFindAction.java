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
		
		// 선택한 영화에 해당하는 영화번호(reserve_num) 가져오기
		int movienum = movieNumFindService.findMovieNum(movie, local, cinema, date, time);
		
		// 선택한 영화의 영화코드(movie_code) 가져오기
		int moviecode = movieNumFindService.findMovieCode(movie);
		
		forward = new ActionForward();
		forward.setPath("SelectSeat.re?movienum=" + movienum + "&moviecode=" + moviecode);
		forward.setRedirect(true);
		
		return forward;
	}

}
