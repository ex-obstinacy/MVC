package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BasketDeleteProService;
import vo.ActionForward;

public class BasketDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("BasketDeleteProAction으로 이동!");
		
		ActionForward forward = null;
		
		// 상품 삭제에 필요한 장바구니번호(basketId)
		int basketId = Integer.parseInt(request.getParameter("basketId"));
		
		// 임시 확인용
		System.out.println("BasketDeleteProAction에서 check!  :basketId " + basketId);
		
		// BasketDeleteProService 클래스 인스턴스 생성 후
		BasketDeleteProService basketDeleteProService = new BasketDeleteProService();
		// BasketDeleteProService 클래스의 removeBasket() 메서드를 호출하여
		// 장바구니 상품 삭제 작업 요청
		boolean isDeleteSuccess = basketDeleteProService.removeBasket(basketId);			
		
		// 삭제 결과에 따른 처리
		// => 삭제 실패(deleteCount 가 0)일 경우 자바스크립트를 사용하여
		//    "글 삭제 실패!" 출력 후 이전페이지로 이동
		if(!isDeleteSuccess){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('장바구니 상품 삭제실패');");
			out.println("history.back()");
			out.println("</script>");
		}
		else{
			// 삭제 성공 시
			// ActionForward 객체를 생성하여 BasketList.go 서블릿 요청
			// Redirect 방식으로 포워딩
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("BasketList.go"); 
		}
				
		
		return forward;
	}

}
