package action;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import svc.MovieListJsonService;
import vo.ActionForward;

public class MovieListJsonAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		MovieListJsonService movieListJsonService = new MovieListJsonService();
		JSONArray movieList = movieListJsonService.getMovieListJson();
		
//		System.out.println(movieList);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(movieList);
		out.flush();
		
		return forward;
		
	}

}
