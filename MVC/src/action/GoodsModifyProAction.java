package action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.GoodsModifyProService;
import vo.ActionForward;
import vo.StoreBean;


public class GoodsModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 특정 상품 수정을 요청하는 Action 클래스
		System.out.println("GoodsModifyProAction으로 이동!");
		
		ActionForward forward = null;
		
		// 현재 context(객체) 정보 가져오기위해
		// request 객체의 getServletContext() 메서드 호출
		ServletContext context = request.getServletContext();
				
		//프로젝트 상에서 설정한 가상 업로드 폴더 경로 지정
		// 현재 루트 위치가 webcontent 폴더이므로 하위 폴더를 "/하위폴더명" 지정
		String saveFolder ="/goodsUpload";
				
		// 가상 폴더에 대응하는 실제 폴더 위치를 가져오기 위해
		// ServletContext 객체의 getRealPath() 메서드를 호출
		// => 파라미터 : 가상 업로드 폴더 경로
		String realFolder = context.getRealPath(saveFolder);
//		System.out.println("실제 업로드 폴더 : " + realFolder); // 경로 확인
		// 실제 업로드 폴더 : D:\Shared\JSP_Model2\workspace_jsp_model2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\프로젝트명\업로드폴더명
		// 실제 업로드 폴더 : D:\Shared\JSP_Model2\workspace_jsp_model2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MVC_Board\boardUpload
				
		// 업로드 할 최대 파일 크기 지정(Byte 단위)
		int fileSize = 1024 * 1024 * 10; // 10MByte 크기 지정
				
		// 뷰페이지(JSP) 에서 전달된 파라미터들이
		// enctype="multipart/form-data"타입으로 전달 될 경우
		// 일반 request 객체가 아닌 MultipartRequest 객체를 통해 전달받아야 하므로
		// MultipartRequest 객체 생성 필수!
		MultipartRequest multi = new MultipartRequest(
				request, // HttpServletRequest(request) 객체 
				realFolder, // 실제 업로드 폴더
				fileSize, // 한 번에 업로드 가능한 1개 파일 최대 크기
				"UTF-8", // 파일명에 대한 인코딩 방식
				new DefaultFileRenamePolicy() //파일명 중복 시 중복 처리 객체
				);
		
		// StoreBean 객체 생성하여 수정폼으로부터 전달받은 항목을 저장
		// => 상품번호, 카테고리, 상품이름, 상품가격, 할인율, 판매수량, 상품구성, 이미지파일, 상세내용
		StoreBean article = new StoreBean();
		article.setGoodsId(Integer.parseInt(multi.getParameter("goodsId")));
		article.setCtg(multi.getParameter("goods_ctg"));
		article.setName(multi.getParameter("goods_name"));
		article.setPrice(Integer.parseInt(multi.getParameter("goods_price")));
		article.setSale(Integer.parseInt(multi.getParameter("goods_sale")));
		article.setComponent(multi.getParameter("goods_component"));
		article.setSellCount(Integer.parseInt(multi.getParameter("goods_sellCount")));
		article.setFile(multi.getOriginalFileName("goods_file"));
		article.setContent(multi.getParameter("goods_content"));
		
		// GoodsModifyProService 클래스 인스턴스 생성 후
		GoodsModifyProService goodsModifyProService = new GoodsModifyProService();
		// GoodsModifyProService 클래스의 modifyArticle() 메서드를 호출하여
		// 글 수정 작업 요청
		// => 파라미터 : BoardBean, 리턴타입 : boolean(isModifySuccess)
		boolean isModifySuccess = goodsModifyProService.modifyArticle(article);	
					
			// 수정 결과에 따른 처리
			// => 수정 실패(updateCount 가 0)일 경우 자바스크립트를 사용하여
			//    "글 수정 실패!" 출력 후 이전페이지로 이동
			// => 아니면 ActionForward 객체 생성 후 GoodsList.go 로 포워딩
			//    새 요청이 발생하므로 Redirect 방식으로 이동
			//	  파라미터로 글번호(goodsId)와 페이지 번호(page) 전달 필요
			if(!isModifySuccess){
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('글 수정실패');");
				out.println("history.back()");
				out.println("</script>");
			}
			else{
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("GoodsList.go?goodsId="+ request.getParameter("goodsId") + "&page=" + request.getParameter("page")); 
			}
			
		
		return forward;
	}

}












