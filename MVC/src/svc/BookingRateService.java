package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.MovDAO;

public class BookingRateService {

	public float insertBookingRate(int ticketing) {
		System.out.println("BookingRateService - insertBookingRate()");
		
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		int sumTicketing = movDAO.selectTicketing();
		
		float bookingRate = (float) (ticketing / sumTicketing * 100);
		
		close(con);
		
		return bookingRate;
	}

}