package action;


import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import svc.MovieListJsonService;
import vo.ActionForward;

public class MovieListJsonAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String today = sdf.format(c.getTime());
//		System.out.println(today);
		
		MovieListJsonService movieListJsonService = new MovieListJsonService();
		JSONArray movieList = movieListJsonService.getMovieListJson(today);
		
//		System.out.println(movieList);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(movieList);
		out.flush();
		
		return forward;
		
	}

}
