package action;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import svc.ShowMovieListJsonService;
import vo.ActionForward;

public class ShowMovieListJsonAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		ShowMovieListJsonService showMovieListJsonService = new ShowMovieListJsonService();
		JSONArray showMovieList = showMovieListJsonService.getShowMovieListJson();
		
//		System.out.println(showMovieList);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(showMovieList);
		out.flush();
		
		return forward;
	}

}
