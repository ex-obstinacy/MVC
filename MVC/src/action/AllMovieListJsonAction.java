package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import svc.AllMovieListJsonService;
import svc.MovieListJsonService;
import vo.ActionForward;

public class AllMovieListJsonAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		AllMovieListJsonService allMovieListJsonService = new AllMovieListJsonService();
		JSONArray allMovieList = allMovieListJsonService.getAllMovieListJson();
		
//		System.out.println(allMovieList);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(allMovieList);
		out.flush();
		
		return forward;
		
	}

}
