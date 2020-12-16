package action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.BasketModifyProService;
import vo.ActionForward;
import vo.StoreBean;


public class BasketModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 장바구니 상품 중 특정 상품의 수량 수정을 요청하는 Action 클래스
		System.out.println("BasketModifyProAction으로 이동!");
		
		ActionForward forward = null;
		
		// 현재 context(객체) 정보 가져오기위해
		// request 객체의 getServletContext() 메서드 호출
		ServletContext context = request.getServletContext();
		
		// -------------------- id가 null 이면 로그인 화면 이동 (시작) --------------------
	      
	      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
	      String id = (String)session.getAttribute("id"); 
	      
	      if(id == null) { // id가 null 이면 로그인 화면으로 이동 !
	         forward.setPath("MemberLogin.me");
	         forward.setRedirect(true);
	         return forward;
	      } 
	    // -------------------- id가 null 이면 로그인 화면 이동 (끝) --------------------
		
	      
		// StoreBean 객체 생성하여 리스트로부터 전달받은 항목을 저장
		// => 상품번호, 장바구니수량
//		StoreBean basket = new StoreBean();
//		basket.setBasketId(Integer.parseInt(request.getParameter("basketId")));
//		basket.setBasketCount(Integer.parseInt(request.getParameter("basketCount")));
//		basket.setGoodsId(Integer.parseInt(request.getParameter("goodsId")));
//		basket.setBasketCount(Integer.parseInt(request.getParameter("basketCount")));
	      
//	    int goodsId = Integer.parseInt(request.getParameter("goodsId"));  
	    int basketId = Integer.parseInt(request.getParameter("basketId"));
	    int basketCount = Integer.parseInt(request.getParameter("basketCount"));
//	    System.out.println(goodsId);
	    System.out.println(basketId);
	    System.out.println(basketCount);
		
		// BasketModifyProService 클래스 인스턴스 생성 후
		BasketModifyProService basketModifyProService = new BasketModifyProService();
	      
		// BasketModifyProService 클래스의 modifyBasketCount() 메서드를 호출하여
		// 장바구니 상품 수량 수정 작업 요청
		boolean isModifySuccess = basketModifyProService.modifyBasketCount(basketCount,basketId, id);	
					
			// 수정 결과에 따른 처리
			// => 변경 실패(updateCount 가 0)일 경우 자바스크립트를 사용하여
			//    "상품 수량변경 실패!" 출력 후 이전페이지로 이동
			// => 아니면 ActionForward 객체 생성 후 BasketList.go 로 포워딩
			//    새 요청이 발생하므로 Redirect 방식으로 이동
			//	  파라미터로 글번호(goodsId)와 페이지 번호(page) 전달 필요
			if(!isModifySuccess){
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('상품 수량변경 실패');");
				out.println("history.back()");
				out.println("</script>");
			}
			else{
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("BasketList.go"); 
			}
			
		
		return forward;
	}

}












