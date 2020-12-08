package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import svc.TimeListJsonService;
import vo.ActionForward;

public class TimeListJsonAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		TimeListJsonService timeListJsonService = new TimeListJsonService();
		JSONArray timeList = timeListJsonService.getTimeListJson();
		
//		System.out.println(timeList);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(timeList);
		out.flush();
		
		return forward;
		
	}

}
