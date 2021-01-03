package dao;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import vo.MemberBean;
import vo.MovBean;
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
	
	// 경환 시작
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
			close(rs);			
			close(pstmt);
		}
		
		return seatList;
	}

	// 영화정보 가져오는 메서드
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
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return movie;
	}
	
	// 영화 포스터 가져오는 메서드
	public MovBean getMoviePost(int moviecode) {
		MovBean mv = new MovBean();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql="select post from movie_board where movCode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moviecode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mv.setPost(rs.getString("post"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return mv;
	}

	// 쿠폰, 관람권 정보 가져오는 메서드
	public MemberBean getMemberInfo(String member_id) {
		MemberBean memberInfo = new MemberBean();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select coupon_1000,coupon_2000,coupon_3000,free_ticket from member where id=?";
			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, "kim"); // 임시확인용
			pstmt.setString(1, member_id); // 원래코드
			rs = pstmt.executeQuery();
			if (rs.next()) {
				memberInfo.setCoupon_1000(rs.getInt("coupon_1000"));
				memberInfo.setCoupon_2000(rs.getInt("coupon_2000"));
				memberInfo.setCoupon_3000(rs.getInt("coupon_3000"));
				memberInfo.setFree_ticket(rs.getInt("free_ticket"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return memberInfo;
	}
	
	// 예매정보 DB 등록 메서드
	public int reserveMovie(ReserveBean reservation, int payPrice) {
		System.out.println("ReserveDAO - reserveMovie() !");
		
		int reserveCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String[] seatArr = reservation.getSeatArr();
		String seat = Arrays.toString(seatArr);
		seat = seat.substring(1, seat.length()-1);
		
		try {
			
			String sql2 = "insert into private_reservation values(?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, reservation.getTicketnum());
			pstmt.setString(2, reservation.getMember_id());
			pstmt.setInt(3, reservation.getMovienum());
			pstmt.setInt(4, reservation.getAdultnum());
			pstmt.setInt(5, reservation.getKidsnum());
			pstmt.setString(6, seat);
			reserveCount = pstmt.executeUpdate();
			
			for(String insertSeat:seatArr) { // 좌석 예약 
				String sql3= "insert into reserved_seat values(?,?)";
				pstmt = con.prepareStatement(sql3);
				pstmt.setString(1, insertSeat);
				pstmt.setInt(2, reservation.getMovienum());
				pstmt.executeUpdate();
			}
			
			if(reservation.getFree_ticket() != 0) { // 관람권 사용했을때
				String sql4 = "update member set free_ticket=free_ticket - ?";
				pstmt = con.prepareStatement(sql4);
				pstmt.setInt(1, reservation.getFree_ticket());
				pstmt.executeUpdate();
			}
							
			if(reservation.getUse_coupon() != null) { // 쿠폰 사용했을때
				String sql5 = null;
				
				if(reservation.getUse_coupon().equals("coupon_1000")) {
					sql5 = "update member set coupon_1000=coupon_1000 - 1";
					pstmt = con.prepareStatement(sql5);
					pstmt.executeUpdate();
				} else if(reservation.getUse_coupon().equals("coupon_2000")) {
					sql5 = "update member set coupon_2000=coupon_2000 - 1";
					pstmt = con.prepareStatement(sql5);
					pstmt.executeUpdate();
				} else if(reservation.getUse_coupon().equals("coupon_3000")) {
					sql5 = "update member set coupon_3000=coupon_3000 - 1";
					pstmt = con.prepareStatement(sql5);
					pstmt.executeUpdate();
				}					
			}
			
			// 예매된 영화 예매율(ticketing) + 1 
			String sql6 = "SELECT movie_board_movCode FROM admin_reservation WHERE num=?";
			pstmt = con.prepareStatement(sql6);
			pstmt.setInt(1, reservation.getMovienum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String sql7 = "UPDATE movie_board SET ticketing=ticketing+1 WHERE movCode=?";
				pstmt=con.prepareStatement(sql7);
				pstmt.setInt(1, rs.getInt("movie_board_movCode"));
				pstmt.executeUpdate();
			}
			
			// 예매시 멤버쉽 포인트 + 결제금액의 1%
			String sql7 = "UPDATE member SET membership=membership+? WHERE id=?";
			pstmt = con.prepareStatement(sql7);
//			payPrice = 20000; // 포인트 테스트용
			pstmt.setInt(1, payPrice/100);
			pstmt.setString(2, reservation.getMember_id());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			close(pstmt);
			
		}
		return reserveCount;
	}

	// 예매정보 가져오는 메서드
	public ReserveBean getReserveInfo(String ticketnum) {
		ReserveBean reserveInfo = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try {
			String sql = "select * from private_reservation where ticketnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ticketnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reserveInfo = new ReserveBean();
				reserveInfo.setTicketnum(ticketnum);
				reserveInfo.setAdultnum(rs.getInt("adultnum"));
				reserveInfo.setKidsnum(rs.getInt("kidsnum"));
				reserveInfo.setSeatnum(rs.getString("seat"));
				
				String sql2 = "select * from admin_reservation where num=?";
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, rs.getInt("reservation_num"));
				rs2 = pstmt.executeQuery();
				if(rs2.next()) {
					reserveInfo.setMovie_subject(rs2.getString("movie_subject"));
					reserveInfo.setCinema_name(rs2.getString("cinema_name"));
					reserveInfo.setShowdate(rs2.getString("showdate"));
					reserveInfo.setShowtime(rs2.getString("showtime"));
				}
				  
				
				String sql3 = "select name from member where id=?";
				pstmt = con.prepareStatement(sql3);
				pstmt.setString(1, rs.getString("member_id"));
				rs2 = pstmt.executeQuery();
				if(rs2.next()) {
					reserveInfo.setMember_name(rs2.getString("name"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			close(rs);
			close(rs2);
			close(pstmt);
		}
		
		return reserveInfo;
	}

	// 티켓번호 생성 메서드
	public String createTicketNum() {
		System.out.println("createTicketNum() !");
		
		String ticketnum = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMdd");
		Date time = new Date();
		
		Random random = new Random();
		int bound = 10000;
		
		String suffix = String.format("%04d", random.nextInt(bound)); 
		ticketnum = format1.format(time) + suffix;
		
		try {
			String sql = "select ticketnum from private_reservation where ticketnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ticketnum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				while(rs.next()) {
					suffix = String.format("%04d", random.nextInt(bound));
					ticketnum = format1.format(time) + suffix;
				}						
			}
	
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(rs != null) {
				close(rs);
			}						
			close(pstmt);
		}				
		
		return ticketnum;
	}
	// 경환 끝
	
	
	// 은주 시작
	// 관리자 페이지용
	public int insertCinema(ReserveBean cinema) {
		
		System.out.println("ReserveDAO - insertCinema()");
		
		int addCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			
			String sql = "insert into cinema values(?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cinema.getCinema_name());
			pstmt.setString(2, cinema.getLocal());
			addCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			System.out.println("insertCinema() 오류! - " + e.getMessage());
			e.printStackTrace();
			
		} finally {
			
			close(pstmt);
			
		}
		
		return addCount;
		
	}
	
	public String getMovieSubject(int movie_code) {
		
		String subject = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select subject from movie_board where movCode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movie_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				subject = rs.getString("subject");
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return subject;
		
	}
	
	public String getMovieGrade(int movie_code) {
		
		String grade = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select grade from movie_board where movCode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movie_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				grade = rs.getString("grade");
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return grade;
		
	}

	public int insertMovie(ReserveBean movie) {
		
		int num = 1;
		int addCount = 0;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select max(num) from admin_reservation";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			
			String sql2 = "insert into admin_reservation values(?, ?, ?, ?, ?, ?, ?)";
			pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(1, num);
			pstmt2.setInt(2, movie.getMovie_code());
			pstmt2.setString(3, movie.getCinema_name());
			pstmt2.setString(4, movie.getShowdate());
			pstmt2.setString(5, movie.getShowtime());
			pstmt2.setString(6, movie.getMovie_subject());
			pstmt2.setString(7, movie.getMovie_grade());
			addCount = pstmt2.executeUpdate();
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			close(pstmt2);
			
		}
		
		return addCount;
		
	}

	public int deleteCinema(String cinema_name) {
		
		int deleteCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			
			String sql = "delete from cinema where name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cinema_name);
			deleteCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(pstmt);
			
		}
		
		return deleteCount;
		
	}

	public int deleteMovie(int movie_num) {
		
		int deleteCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			
			String sql = "delete from admin_reservation where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movie_num);
			deleteCount = pstmt.executeUpdate();
			
			String sql2 = "delete from reserved_seat where reservation_num=?"; // 영화 삭제시 해당 영화번호에 예약되있는 좌석 삭제 - 경환 추가
			pstmt = con.prepareStatement(sql2);
			pstmt.setInt(1, movie_num);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(pstmt);
			
		}
		
		return deleteCount;
		
	}

	public int findMovieNum(String movie, String local, String cinema, String date, String time) {
		
		int movienum = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select num from admin_reservation where movie_subject=? and cinema_name=? and showdate=? and showtime=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movie);
			pstmt.setString(2, cinema);
			pstmt.setString(3, date);
			pstmt.setString(4, time);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				movienum = rs.getInt("num");
			}
			
			System.out.println("영화번호 : " + movienum);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return movienum;
		
	}
	
	public int findMovieCode(String movie) {
		
		int moviecode = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select movCode from movie_board where subject=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movie);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				moviecode = rs.getInt("movCode");
			}
			
			System.out.println("영화코드 : " + moviecode);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return moviecode;
	}
	
	// JSON 처리 메서드
	public JSONArray getMovieList(String today) {
		
		JSONArray movieList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select num, movie_board_movCode, movie_subject, movie_grade, max(showdate) from admin_reservation group by movie_subject having max(showdate)>=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, today);

			rs = pstmt.executeQuery();
			
			movieList = new JSONArray();

			while(rs.next()) {
				
				JSONObject jo = new JSONObject();
				jo.put("movie_num", rs.getInt("num"));
				jo.put("movie_code", rs.getInt("movie_board_movCode"));
				jo.put("movie_subject", rs.getString("movie_subject"));
				jo.put("movie_grade", rs.getString("movie_grade"));
					
				movieList.add(jo);
				
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return movieList;
		
	}

	public JSONArray getCinemaList() {
		
		JSONArray cinemaList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select * from cinema order by name";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			cinemaList = new JSONArray();

			while(rs.next()) {
				JSONObject jo = new JSONObject();
				jo.put("cinema_name", rs.getString("name"));
				jo.put("cinema_localfull", rs.getString("local"));
				String jlocal = rs.getString("local").substring(0, 2);
				jo.put("cinema_local", jlocal);
				
				cinemaList.add(jo);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return cinemaList;
		
	}

	public JSONArray getTimeList() {
		
		JSONArray timeList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select * from admin_reservation";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			timeList = new JSONArray();

			while(rs.next()) {
				JSONObject jo = new JSONObject();
				jo.put("movie_code", rs.getInt("movie_board_movCode"));
				jo.put("movie_subject", rs.getString("movie_subject"));
				jo.put("cinema_name", rs.getString("cinema_name"));
				jo.put("showdate", rs.getString("showdate"));
				jo.put("showtime", rs.getString("showtime"));
				String jtime = rs.getString("showtime").substring(0, 5);
				String jguan = rs.getString("showtime").substring(5, 9);
				jo.put("showtime_t", jtime);
				jo.put("showtime_g", jguan);
				
				timeList.add(jo);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return timeList;
		
	}

	public JSONArray getAllMovieList(String today) {
		
		JSONArray allMovieList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select * from admin_reservation where showdate >= ? order by cinema_name, showdate, showtime";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, today);

			rs = pstmt.executeQuery();

			allMovieList = new JSONArray();

			while(rs.next()) {
				JSONObject jo = new JSONObject();
				jo.put("movie_num", rs.getInt("num"));
				jo.put("movie_code", rs.getInt("movie_board_movCode"));
				jo.put("movie_subject", rs.getString("movie_subject"));
				jo.put("cinema_name", rs.getString("cinema_name"));
				jo.put("showdate", rs.getString("showdate"));
				jo.put("showtime", rs.getString("showtime"));
				jo.put("movie_grade", rs.getString("movie_grade"));
				
				allMovieList.add(jo);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return allMovieList;
		
	}
	
	public JSONArray getShowMovieList() {
		
		JSONArray showMovieList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select * from movie_board order by subject";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			showMovieList = new JSONArray();
			
			while(rs.next()) {
				JSONObject jo = new JSONObject();
				jo.put("movie_code", rs.getInt("movCode"));
				jo.put("movie_subject", rs.getString("subject"));
				jo.put("movie_grade", rs.getString("grade"));
				
				
				showMovieList.add(jo);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(rs);
			close(pstmt);
			
		}
		
		return showMovieList;
	}


	
	
	// 은주 끝
	
} // ReserveDAO 
