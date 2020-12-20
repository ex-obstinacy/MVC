package action;

import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import svc.MovWriteProService;
import vo.ActionForward;
import vo.MovBean;

public class MovWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovWriteProAction");
		
		// MultiPartRequest 객체를 가져와서
		// 전달받은 파라미터(글쓴이, 비밀번호, 글제목, 내용, 작성일) 가져오기
		// 현재 컨텍스트(객체) 정보 가져오기 위해 
		// request 객체의 getServletContext() 메서드를 호출
		ServletContext context = request.getServletContext();
		// 프로젝트 상에서 설정한 가상 업로드 폴더 경로 지정
		// 현재 루트 위치가 webcontent 폴더이므로 하위 폴더를 "/하위폴더명" 지정
		String saveFolder = "/movUpload";
		// 가상 폴더에 대응하는 실제 폴더 위치를 가져오기 위해
		// ServletContext 객체의 getRealPath() 메서드를 호출
		// => 파라미터 : 가상 업로드 폴더 경로
		String realFolder = context.getRealPath(saveFolder);
		// 업로드 할 최대 파일 크기 지정(Byte 단위)
		// ex) 1MByte = 1,024KByte = 1,048,576Byte  
		// 작은 단위로 분할해서 해당 크기에 맞게 연산 수행하도록 지정해야 수정 쉬움
		int fileSize = 1024 * 1024 * 10; // 10MByte 크기 지정
		// 뷰페이지(JSP) 에서 전달된 파라미터들이 
		// enctype="multipart/form-data" 타입으로 전달될 경우
		// 일반 request 객체가 아닌 MultipartRequest 객체를 통해 전달받아야 하므로
		// MultipartRequest 객체 생성 필수!
		MultipartRequest multi = new MultipartRequest(
				request, // HttpServletRequest(request) 객체 
				realFolder, // 실제 업로드 폴더 
				fileSize, // 한 번에 업로드 가능한 1개 파일 최대 크기 
				"UTF-8", // 파일명에 대한 인코딩 방식 
				new DefaultFileRenamePolicy() // 파일명 중복 시 중복 처리 객체
		);
		
		MovBean movBean = new MovBean();
		movBean.setSubjet(multi.getParameter("subject"));
		movBean.setMovieCd(Integer.parseInt(multi.getParameter("movieCd")));
		movBean.setGenre(multi.getParameter("genre"));
		movBean.setOpenDt(Date.valueOf(multi.getParameter("openDt")));
		movBean.setShowTm(multi.getParameter("showTm"));
		movBean.setDirector(multi.getParameter("director"));
		movBean.setCast(multi.getParameter("cast"));
		movBean.setNationNm(multi.getParameter("nationNm"));
		movBean.setCompanys(multi.getParameter("companys"));
		movBean.setGrade(multi.getParameter("grade"));
		movBean.setPost(multi.getOriginalFileName("post"));
		movBean.setStillCut(multi.getOriginalFileName("stillCut[]"));
		movBean.setTrailer(multi.getParameter("trailer"));
		movBean.setContent(multi.getParameter("content"));
		
		System.out.println("Subject : " + movBean.getSubjet());
		System.out.println("MovieCd : " + movBean.getMovieCd());
		System.out.println("Genre : " + movBean.getGenre());
		System.out.println("OpenDt : " + movBean.getOpenDt());
		System.out.println("ShowTm : " + movBean.getShowTm());
		System.out.println("Director : " + movBean.getDirector());
		System.out.println("Cast : " + movBean.getCast());
		System.out.println("NationNm : " + movBean.getNationNm());
		System.out.println("Companys : " + movBean.getCompanys());
		System.out.println("Grade : " + movBean.getGrade());
		System.out.println("Post : " + movBean.getPost());
		System.out.println("StillCut : " + movBean.getStillCut());
		System.out.println("Trailer : " + movBean.getTrailer());
		System.out.println("Content : " + movBean.getContent());
		
		MovWriteProService movWriteProSevice = new MovWriteProService();
		boolean isWriteSuccess = movWriteProSevice.registArticle(movBean);
		
		ActionForward forward = new ActionForward();
		
		if (isWriteSuccess) {
			forward.setPath("MemberLogin.me");
			forward.setRedirect(true);
			
		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('영화 등록 실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back()"); // 이전 페이지로 이동
			out.println("</script>"); // 자바스크립트 끝 태그
			
		}
		
		return forward;
	}

}
