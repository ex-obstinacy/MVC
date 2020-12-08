package action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static db.JdbcUtil.*;

import dao.StoreDAO;
import svc.BasketAddService;
import vo.ActionForward;
import vo.MemberBean;
import vo.StoreBean;

// 장바구니 담기
public class BasketAddAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      ActionForward forward = null;
      forward = new ActionForward();
      
      // -------------------- id가 null 이면 로그인 화면 이동 --------------------
      System.out.println("BasketAddAction - 로그인 확인");
      
      HttpSession session = request.getSession(); //MemberBean id 값 가져오기
      String id = (String)session.getAttribute("id"); 
      
      System.out.println("id : " + id); // id 확인
      
      if(id == null) { // id가 null 이면 로그인 화면으로 이동 !
         forward.setPath("MemberLogin.me");
         forward.setRedirect(true);
         return forward;
      } 
      
      // -------------------- id가 null 이면 로그인 화면 이동 --------------------
      
      
      // -------------------- 장바구니 담기 요청 --------------------
      
      System.out.println("BasketAddAction - 장바구니 담기");
      
      int goodsId = Integer.parseInt(request.getParameter("goodsId"));
      System.out.println("BasketAddAction() - 게시물 번호 : " + goodsId);
      
      // BasketAddService 클래스의 인스턴스 생성 후  selectBasketList() 메서드를 호출하여 게시물 번호에 해당하는 글내용 가져오기
      BasketAddService basketAddService = new BasketAddService();
      ArrayList<StoreBean> basketList = basketAddService.selectBasketList(goodsId);
      
      // 글내용이 저장된 ArrayList<StoreBean> 객체를 request 객체에 저장
      request.setAttribute("basketList", basketList);
      
//      StoreBean basketAdd = new StoreBean();
      boolean isBasketAddSuccess = basketAddService.addBasket(goodsId, id);
      
      if(isBasketAddSuccess) {
         forward = new ActionForward();
         forward.setPath("BasketList.go");
         forward.setRedirect(false); // 리다이렉트랑 디스패쳐 차이 머지.. true 하니까 goodsId 값을 못가져가넹
      } else {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('장바구니 담기 실패!')");
         out.println("history.back()");
         out.println("</script>");
      }
      
      // -------------------- 장바구니 담기 요청 --------------------

      // -------------------- 장바구니 basketId, basketCount, goodsId 중복 체크 --------------------
      // -------------------- 장바구니 basketId, basketCount, goodsId 중복 체크 --------------------
      return forward;
   }

}