package action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import svc.AllMovieListJsonService;
import vo.ActionForward;

public class AllMovieListJsonAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String today = sdf.format(c.getTime());
//		System.out.println(today);
		
		AllMovieListJsonService allMovieListJsonService = new AllMovieListJsonService();
		JSONArray allMovieList = allMovieListJsonService.getAllMovieListJson(today);
		
//		System.out.println(allMovieList);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(allMovieList);
		out.flush();
		
		return forward;
		
	}

}
