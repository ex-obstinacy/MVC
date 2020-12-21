package action;

import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.EventWriteProService;
import svc.PreviewWriteProService;
import vo.ActionForward;
import vo.EventBean;
import vo.PreviewBean;

public class EventWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("eventWriteProAction!");
		
		ActionForward forward = null;
		
		// MultiPartRequest 객체를 가져와서
		// 전달받은 파라미터(글쓴이, 비밀번호, 글제목, 내용, 작성일) 가져오기
		// 현재 컨텍스트(객체) 정보 가져오기 위해 
		// request 객체의 getServletContext() 메서드를 호출
		ServletContext context = request.getServletContext();
		
		// 프로젝트 상에서 설정한 가상 업로드 폴더 경로 지정
		// 현재 루트 위치가 webcontent 폴더이므로 하위 폴더를 "/하위폴더명" 지정
		String saveFolder = "/eventUpload";
		
		// 가상 폴더에 대응하는 실제 폴더 위치를 가져오기 위해
		// ServletContext 객체의 getRealPath() 메서드를 호출
		// => 파라미터 : 가상 업로드 폴더 경로
		String realFolder = context.getRealPath(saveFolder);
//		System.out.println("실제 업로드 폴더 : " + realFolder); // 경로 확인
		// 실제 업로드 폴더 구조 : 워크스페이스\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\프로젝트명\업로드폴더명
		// 실제 업로드 폴더 : D:\Shared\JSP_Model2\workspace_jsp_model2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MVC_Board\boardUpload
		
		// 업로드 할 최대 파일 크기 지정(Byte 단위)
		// ex) 1MByte = 1,024KByte = 1,048,576Byte  
//		int fileSize = 1048576; // 직접적인 크기를 명시하지 않도록 한다!
		// 작은 단위로 분할해서 해당 크기에 맞게 연산 수행하도록 지정해야 수정 쉬움
//		int fileSize = 1024 * 1024; // 1024Byte * 1024Byte = 1,048,576Byte = 1MByte
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
		
		// 주의! request 객체의 getParameter() 메서드가 아닌
		// MultiparRequest 객체의 getParameter() 메서드 호출 필수!
//		String board_name = multi.getParameter("board_name");
//		String board_pass = multi.getParameter("board_pass");
//		String board_subject = multi.getParameter("board_subject");
//		String content = multi.getParameter("content");
//		String thumbnail = multi.getParameter("thumbnail");
		// -------------------------------------------------------------------
		// 업로드 파일명을 얻기 위한 파라미터 이름 가져오기
//		System.out.println((String)multi.getFileNames().nextElement());
		
		// 업로드 파일명 가져오기(파라미터 이름은 직접 지정해도 무관)
		// getOriginalFileName() : 업로드 할 때 지정된 파일명
		// => 주로, 화면에 표시할 파일명으로 사용
//		System.out.println("getOriginalFileName() : " + 
//					multi.getOriginalFileName("board_file"));
		
		// getFilesystemName() : 실제 업로드 될 때 중복 처리 완료된 실제 파일명
		// => 주로, 다운로드 시 실제 다운로드 링크로 사용할 파일명으로 사용
//		System.out.println("getFilesystemName() : " + 
//					multi.getFilesystemName("board_file"));
		
		// 현재 프로젝트에서는 다운로드에 중요성이 낮으므로
		// 원본 파일과 실제 업로드 파일명 구분 없이 원본 파일명만 사용
		// => 실제 프로젝트에서 다운로드가 필요할 경우
		//    원본 파일과 실제 업로드 파일명을 모두 DB 에 저장하면 됨
//		String board_file = multi.getOriginalFileName("board_file");
		
//		System.out.println("글쓴이 : " + board_name);
//		System.out.println("패스워드 : " + board_pass);
//		System.out.println("글제목 : " + board_subject);
//		System.out.println("글내용 : " + board_content);
//		System.out.println("파일명 : " + board_file);
		
//		System.out.println("썸네일 :  " + thumbnail );
		// -------------------------------------------------------------------
		// 전달할 데이터를 BoardBean 객체에 저장
		EventBean eventBean = new EventBean();
		eventBean.setMember_id(multi.getParameter("member_id"));
		eventBean.setApply(multi.getParameter("apply"));
		eventBean.setSubject(multi.getParameter("subject"));
		eventBean.setContent(multi.getParameter("content"));
		eventBean.setFile(multi.getOriginalFileName("file"));
		eventBean.setThumbnail(multi.getOriginalFileName("thumbnail"));
		
		Timestamp date = new Timestamp(System.currentTimeMillis());
		eventBean.setDate(date);
		
		// -------------------------------------------------------------------
		// 서비스 클래스를 통해 실제 글 등록 작업 수행을 위한 요청
		// BoardWriteProService 클래스의 인스턴스 생성 후
		// registArticle() 메서드를 호출하여 글 등록 작업 수행 요청
		// => 파라미터 : BoardBean, 리턴타입 : boolean(isWriteSuccess)
		EventWriteProService eventWriteProService = new EventWriteProService();
		boolean isWriteSuccess = eventWriteProService.registArticle(eventBean);
		
		// 글쓰기 작업 수행 후 리턴받은 결과값을 사용하여
		// 글쓰기 성공/실패 여부를 판단
		// => 만약, 실패했을 경우 자바스크립트를 사용하여 이전페이지로 이동
		// => 만약, 성공했을 경우 ActionForward 객체를 생성하여
		//    포워딩 경로(BoardList.bo)와 방식(새 요청이므로 Redirect) 지정
		if(!isWriteSuccess) {
			// 글쓰기 작업 실패 시 자바스크립트를 통해 
			// 실패 메세지 출력 후 이전 페이지로 이동
			// => 자바 코드를 사용하여 응답페이지 생성
			// 1. response 객체의 setContentType() 메서드를 호출하여
			// 문서 타입 및 캐릭터셋 설정
			response.setContentType("text/html; charset=UTF-8");
			// 2. response 객체의 getWrite() 메서드를 호출하여
			//    출력스트림 객체를 리턴받아 PrintWriter 타입으로 저장
			PrintWriter out = response.getWriter();
			// 3. PrintWriter 객체의 println() 메서드를 호출하여
			//    응답페이지에서 수행할 작업을 기술
			//    => 모든 작업(자바스크립트, 태그 등)은 문자열로 지정
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('공지글 등록 실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back()"); // 이전 페이지로 이동
			out.println("</script>"); // 자바스크립트 끝 태그
		} else {
			// 1. ActionForward 객체 생성
			forward = new ActionForward();
			// 2. 포워딩 경로(URL) 지정
			//    (주의! 경로명 앞에 슬래시(/) 기호 붙이지 말 것!)
			forward.setPath("EventList.ev");
			// 3. 포워딩 방식(Redirect 방식) 지정
			forward.setRedirect(true);
		}
		
		// 4. ActionForward 객체 리턴 => BoardFrontController 클래스로 전달
		return forward;
	}

}

