package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.MemberBean;
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

	// 예약된 좌석 가져오는 메서드
	public ArrayList<ReserveBean> getSeatList(int movienum) {
		ArrayList<ReserveBean> seatList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select num from reserved_seat where reservation_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movienum);
			rs = pstmt.executeQuery();
			
			seatList = new ArrayList<ReserveBean>();
			
			while(rs.next()){
				ReserveBean reserveBean = new ReserveBean();
				reserveBean.setSeatnum(rs.getNString("num"));
				seatList.add(reserveBean);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {			
			close(pstmt);
			close(rs);			
		}
		
		return seatList;
	}

	public ReserveBean getMovie(int movienum) {
		ReserveBean movie = new ReserveBean();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql="select * from admin_reservation where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movienum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				movie.setMovie_subject(rs.getNString("movie_subject"));
				movie.setCinema_name(rs.getNString("cinema_name"));
				movie.setShowdate(rs.getString("showdate"));
				movie.setShowtime(rs.getString("showtime"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return movie;
	}

	public MemberBean getCoupon(String member_id) {
		MemberBean coupon = new MemberBean();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select coupon_1000,coupon_2000,coupon_3000 from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "kim"); // 임시확인용
//			pstmt.setString(1, member_id); // 원래코드
			rs = pstmt.executeQuery();
			if (rs.next()) {
				coupon.setCoupon_1000(rs.getInt("coupon_1000"));
				coupon.setCoupon_2000(rs.getInt("coupon_2000"));
				coupon.setCoupon_3000(rs.getInt("coupon_3000"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return coupon;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
