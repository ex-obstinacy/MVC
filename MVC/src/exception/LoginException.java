package exception;

public class LoginException extends Exception {
	
	public LoginException(String message) {
		// 사용자 정의 예외 클래스
		// => 로그인 실패 메세지 저장을 위한 생성자 정의
		super(message); // 슈퍼클래스의 생성자에 메세지 전달
		
	}

}
