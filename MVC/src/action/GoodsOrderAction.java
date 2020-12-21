package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.GoodsListService;
import svc.GoodsOrderService;
import vo.ActionForward;
import vo.PageInfo;
import vo.StoreBean;

public class GoodsOrderAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				System.out.println("GoodsOrderAction");
				
				ActionForward forward = null;
				
				int page =1; //현재 페이지 번호 저장할 변수
				int limit =10; // 페이지 당 표시할 게시물 수를 결정하는 변수
				
				if (request.getParameter("page")!=null) {
					page = Integer.parseInt(request.getParameter("page"));
				}
						
				GoodsOrderService goodsOrderService = new GoodsOrderService();
				int listCount = goodsOrderService.getListCount();
					
				ArrayList<StoreBean> orderList = new ArrayList<StoreBean>();
				orderList = goodsOrderService.getOrderList(page, limit);

				int maxPage = (int)((double)listCount / limit + 0.95);
				
				int startPage = ((int)((double)page/10 + 0.9) -1)*10+1;
						
				int endPage = startPage +10 -1;
					
				if (endPage > maxPage) {
					endPage = maxPage;
					}
				PageInfo pageInfo = new PageInfo(
						page, maxPage, startPage, endPage, listCount);
				
				request.setAttribute("orderList", orderList);
				request.setAttribute("pageInfo", pageInfo);
				
				forward = new ActionForward();
				forward.setPath("/goods/goodsOrder.jsp");

				forward.setRedirect(false); //기본값이 false 이므로 생략 가능
					
				return forward;
	}

}
