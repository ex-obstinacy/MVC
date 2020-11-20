package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import vo.ReserveBean;

import static db.JdbcUtil.*;

public class ReserveDAO {
	
	// ReserveDAO 싱클톤패턴으로 작업
	private ReserveDAO() {}
	
	private static ReserveDAO instance = new ReserveDAO();

	public static ReserveDAO getInstance() {
		return instance;
	}
	
	// ---------------------------------------------------------------------------------------------
	
	Connection con; // Connection 객체를 전달받아 저장할 멤버변수

	// 외부(Service 클래스)로부터 Connection 객체를 전달받아 멤버변수에 저장하는 setConnection() 메서드 정의
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	// 영화관 등록 메서드
	public int addCinema(ReserveBean reserveBean) {
		
		System.out.println("ReserveDAO - insertCinema()");
		
		int addCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			
			String sql = "insert into cinema(name, local) values(?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reserveBean.getCinema_name());
			pstmt.setString(2, reserveBean.getLocal());
			addCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			System.out.println("insertCinema() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			
			close(pstmt);
			
		}
		
		return addCount;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
