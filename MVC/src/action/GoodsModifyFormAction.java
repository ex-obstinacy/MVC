package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.GoodsDetailService;
import vo.ActionForward;
import vo.StoreBean;


public class GoodsModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 특정 상품정보 수정을 위해 기존 상품 정보를 요청하는 Action 클래스
		System.out.println("GoodsModifyFormAction 클래스로 이동!");
		
		ActionForward forward = null;
		
		//원본 상품정보 요청에 필요한 상품아이디(goodsId) 파라미터 가져오기
		int goodsId = Integer.parseInt(request.getParameter("goodsId"));
		
		//원본 게시물 정보 요청을 위해 새로운 Service 클래스를 정의하지 않고
		//기존의 GoodsDetailService 클래스의 getArticle() 메서드를 호출하여
		//원본 상품정보 요청을 수행
		//=> 파라미터 : 상품아이디(goodsId), 리턴타입 : StoreBean(article) 
		GoodsDetailService goodsDetailService = new GoodsDetailService();	
	   	StoreBean article = goodsDetailService.getArticle(goodsId);
	   	
	   	// request 객체에 원본 게시물 정보(StoreBean) 저장
	   	request.setAttribute("article", article);
   		
	   	// ActionForward 객체를 생성하여 goodsModify.jsp 페이지로 포워딩
	   	// => Dispatcher 방식
	   	forward = new ActionForward();
	   	forward.setPath("/goods/goodsModify.jsp");
   		
   		return forward;
	}
	
	

}
