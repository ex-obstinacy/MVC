package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
      
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id"); 
      
      int goodsId = Integer.parseInt(request.getParameter("goodsId"));
 
      
      BasketListService basketListService = new BasketListService();
      ArrayList<StoreBean> basketList = new ArrayList<StoreBean>();
      
      basketList = basketListService.getBasketList(goodsId, id);
      
      request.setAttribute("basketList", basketList);
      
      forward = new ActionForward();
      forward.setPath("/basket.jsp"); // true랑 false 차이 뭐지 true 하니까 값을 못받아오네
      forward.setRedirect(false);
      
      return forward;
   }

}