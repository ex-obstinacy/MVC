package action;

import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.WinModifyService;
import vo.ActionForward;
import vo.WinBean;

public class WinModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("WinModifyProAction");
		
		ActionForward forward = null;
		
		String nowPage = request.getParameter("page");
		int num = Integer.parseInt(request.getParameter("num"));
		
		WinBean article = new WinBean();
		article.setNum(Integer.parseInt(request.getParameter("num")));
	
		article.setSubject(request.getParameter("subject"));
		article.setContent(request.getParameter("content"));
		
		
		article.setEvent_num(Integer.parseInt(request.getParameter("event_num")));
		
		WinModifyService winModifyService = new WinModifyService();
		boolean isModifySuccess =
				winModifyService.modifyArticle(article);
		
		
		if(!isModifySuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 수정 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setPath("WinDetail.wi?num=" + num + 
									"&page=" + nowPage);
			
			
//			System.out.println("게시물 페이지 : " +nowPage);

			forward.setRedirect(true);
		}
		
		return forward;
	}

}
