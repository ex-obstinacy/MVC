package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BasketListService;
import vo.ActionForward;
import vo.StoreBean;

//장바구니 목록
//값을 못받아옴 ... 수정할것
public class BasketListAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("BasketListAction");
      ActionForward forward = null;
      
      int goodsId = Integer.parseInt(request.getParameter("goodsId"));
//      System.out.println("BasketListAction - goodsId : " + goodsId);
      
      BasketListService basketListService = new BasketListService();
      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
      
      basketList = basketListService.getBasketList(goodsId);
      
      forward = new ActionForward();
      forward.setPath("/basket.jsp"); // true랑 false 차이 뭐지 true 하니까 값을 못받아오네
      forward.setRedirect(false);
      
      return forward;
   }

}