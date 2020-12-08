package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import svc.CinemaListJsonService;
import vo.ActionForward;

public class CinemaListJsonAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		CinemaListJsonService cinemaListJsonService = new CinemaListJsonService();
		JSONArray cinemaList = cinemaListJsonService.getCinemaListJson();
		
//		System.out.println(cinemaList);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(cinemaList);
		out.flush();
		
		return forward;
		
	}

}
