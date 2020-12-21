package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.GoodsDeleteProService;
import svc.GoodsUseProService;
import vo.ActionForward;
import vo.StoreBean;

public class GoodsUseProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
System.out.println("GoodsUseProAction 이동!");
		
		ActionForward forward = null;
		
		String reserveNum = request.getParameter("reserveNum");
		System.out.println("GoodsUseProAction - reserveNum :" + reserveNum);
		
		GoodsUseProService goodsUseProService = new GoodsUseProService();
		
		boolean isUseSuccess = goodsUseProService.UseArticle(reserveNum);			
		
		if(!isUseSuccess){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('사용여부 전환 실패');");
			out.println("history.back()");
			out.println("</script>");
		}
		else{
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("GoodsOrder.go"); 
		}
				
		
		return forward;
	}

}
