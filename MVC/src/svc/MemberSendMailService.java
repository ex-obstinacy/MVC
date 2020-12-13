package svc;

import java.io.PrintWriter;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vo.GoogleAuthentication;

public class MemberSendMailService {

	public void sendMail(HttpServletRequest request, HttpServletResponse response, String id, String email) throws Exception {
		System.out.println("MemberSendMail - sendMail()");
		
		request.setCharacterEncoding("UTF-8");
		
		String sender = "관리자";
		String receiver = email;
		String subject = "축하드려요 MVC에 가입 되셨습니다!";
		String content = id + "님 MVC 가입을 축하드립니다.";
		
		System.out.println(receiver + ", " + content);
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
			try {
				Properties properties = System.getProperties();
				properties.put("mail.smtp.starttls.enable", "true"); // gmail은 무조건 true 고정
				properties.put("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
				properties.put("mail.smtp.auth", "true"); // gmail은 무조건 true 고정
				properties.put("mail.smtp.port", "587"); // gmail 포트
				Authenticator auth = new GoogleAuthentication();
				Session s = Session.getDefaultInstance(properties, auth);
				Message message = new MimeMessage(s);
				Address sender_address = new InternetAddress(sender);
				Address receiver_address = new InternetAddress(receiver);
				message.setHeader("content-type", "text/html;charset=UTF-8");
				message.setFrom(sender_address);
				message.addRecipient(Message.RecipientType.TO, receiver_address);
				message.setSubject(subject);
				message.setContent(content, "text/html;charset=UTF-8");
				message.setSentDate(new java.util.Date());
				Transport.send(message);
				out.println("정상적으로 전송");
				
			} catch (AddressException e) {
				e.printStackTrace();
				
			} catch (MessagingException e) {
				e.printStackTrace();
				
			}
			
	}

}
