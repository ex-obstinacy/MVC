package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.GoodsDeleteProService;
import svc.NoticeDeleteProService;
import vo.ActionForward;

public class GoodsDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("GoodsDeleteProAction으로 이동!");
		
		ActionForward forward = null;
		
		// 상품 삭제에 필요한 상품번호(goodsId)
		int goodsId = Integer.parseInt(request.getParameter("goodsId"));
		
		// 임시 확인용
		System.out.println("BoardDeleteProAction에서 check!  :goodsId " + goodsId);
		
		// GoodsDeleteProService 클래스 인스턴스 생성 후
		GoodsDeleteProService goodsDeleteProService = new GoodsDeleteProService();
		// GoodsDeleteProService 클래스의 removeArticle() 메서드를 호출하여
		// 글 삭제 작업 요청
		// => 파라미터 : 글번호, 리턴타입 : boolean(isDeleteSuccess)
		boolean isDeleteSuccess = goodsDeleteProService.removeArticle(goodsId);			
		
		// 삭제 결과에 따른 처리
		// => 삭제 실패(deleteCount 가 0)일 경우 자바스크립트를 사용하여
		//    "글 삭제 실패!" 출력 후 이전페이지로 이동
		if(!isDeleteSuccess){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('글 삭제실패');");
			out.println("history.back()");
			out.println("</script>");
		}
		else{
			// 삭제 성공 시
			// ActionForward 객체를 생성하여 GoodsList.go 서블릿 요청
			// Redirect 방식으로 포워딩
			// => URL 뒤에 파라미터로 페이지번호(page)를 전달
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("GoodsList.go?page=" + request.getParameter("page")); 
		}
				
		
		return forward;
	}

}
