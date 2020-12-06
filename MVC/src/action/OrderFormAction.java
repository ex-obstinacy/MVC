package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.GoodsDetailService;
import svc.OrderFormService;
import vo.ActionForward;
import vo.StoreBean;

public class OrderFormAction implements Action {
	//수정해야됨
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderFormAction !");
		ActionForward forward = null;
		
		// 파라미터로 전달받은 게시물 번호(goodsId) 가져오기
		int goodsId = Integer.parseInt(request.getParameter("goodsId"));
		System.out.println("게시물 번호 : " + goodsId);
				
		// OrderFormService 클래스의 인스턴스 생성 후
		// getArticle() 메서드를 호출하여 게시물 번호에 해당하는 글내용 가져오기
		// => 파라미터 : 글번호(goodsId), 리턴타입 : 게시물 1개 정보(StoreBean)
		OrderFormService orderFormService = new OrderFormService();
		StoreBean article = orderFormService.getArticle(goodsId);
		
		// 글내용이 저장된 StoreBean 객체를 request 객체에 저장
		request.setAttribute("article", article);

		// orderForm.jsp 페이지로 포워딩
		// => request 객체를 유지하고, 서블릿 주소가 유지되어야 하므로
		//    Dispatcher 방식으로 포워딩
		forward = new ActionForward();
		forward.setPath("/orderForm.jsp");
//		forward.setRedirect(false);
		
		return forward;
	}

}
