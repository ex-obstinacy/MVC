package store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class StoreDAO {
	
	public Connection getConnection() throws Exception{
		//throws Exception
		
		Connection con = null;
		
		//커넥션 풀(Connection Pool)
		Context init = new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con=ds.getConnection();
		return con;
	}

	public void insertGoods(StoreBean sb) {
		System.out.println("StoreDAO insertgoods()");
		System.out.println("sb주소값" + sb );
		System.out.println("주소를 찾아서 ctg값을 가져옴 : " + sb.getCtg());
		System.out.println("주소를 찾아서 name값을 가져옴 : " + sb.getName());
		System.out.println("주소를 찾아서 price값을 가져옴 : " + sb.getPrice());
		System.out.println("주소를 찾아서 sale값을 가져옴 : " + sb.getSale());
		System.out.println("주소를 찾아서 stockcount값을 가져옴 : " + sb.getStockcount());
		System.out.println("주소를 찾아서 sellcount값을 가져옴 : " + sb.getSellcount());
		System.out.println("주소를 찾아서 component값을 가져옴 : " + sb.getComponent());
		System.out.println("주소를 찾아서 img값을 가져옴 : " + sb.getImg());
		System.out.println("주소를 찾아서 content값을 가져옴 : " + sb.getContent());
		System.out.println("주소를 찾아서 date값을 가져옴 : " + sb.getDate());
		
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt2=null;
		PreparedStatement pstmt =null;
		
		try {//예외발생코드
			
			con=getConnection();
			
		 	//3단계 num구하기 기존글에서 최대 num 값을 구해서 +1 
		 	String sql2 = "select max(num) from goods";
		 	pstmt2 = con.prepareStatement(sql2);
		 	
		 	//4단계 실행 => rs 저장
		 	rs = pstmt2.executeQuery();
		 	
//		 	//5단계 rs 첫행이동 max(num) 가져오기 +1
		 	int num = 0;
		 	if (rs.next()) {
		 		num = rs.getInt("max(num)") + 1;
		 	}
		 	
		// //$3단계 - 접속정보를 이용해서 SQL구문을 만들고 실행 할 수 있는 자바프로그램 생성
		 	String sql = "insert into goods(num, ctg, name, price, sale, stockcount, sellcount, component, img, content, date) values(?,?,?,?,?,?,?,?,?,?,?)";
			
		 	//sql구문과 connection연결
		 	pstmt =con.prepareStatement(sql);
		 	//(parameterIndex,변수값) 는 ?의 순서. set이 수정할 곳
		 	pstmt.setInt(1, num);
		 	pstmt.setString(2, sb.getCtg());
		 	pstmt.setString(3, sb.getName());
		 	pstmt.setInt(4, sb.getPrice());
		 	pstmt.setInt(5, sb.getSale());
		 	pstmt.setInt(6, sb.getStockcount());
		 	pstmt.setInt(7, sb.getSellcount());
		 	pstmt.setString(8, sb.getComponent());
		 	pstmt.setString(9, sb.getImg());
		 	pstmt.setString(10, sb.getContent());
		 	pstmt.setTimestamp(11, sb.getDate());


		// $4단계 - SQL 실행 (INSERT, UPDATE, DELETE)
		 	pstmt.executeUpdate();
			
		} catch (Exception e) {
			//예외처리됨
			e.printStackTrace(); //자세한건 자바시간에~
		} finally {
			//마무리
			if (rs!=null) {
				//resultSet이 null이 아니면 기억장소를 회수하는 작업
				try{rs.close();} catch(SQLException ex){} //finally생략
				}
			if (pstmt!=null) {
				//resultSet이 null이 아니면 기억장소를 회수하는 작업
				try{pstmt.close();} catch(SQLException ex){} //finally생략
				}
			if (pstmt2!=null) {
				//resultSet이 null이 아니면 기억장소를 회수하는 작업
				try{pstmt2.close();} catch(SQLException ex){} //finally생략
				}
			if (con!=null) {
				//resultSet이 null이 아니면 기억장소를 회수하는 작업
				try{con.close();} catch(SQLException ex){} //finally생략
				}
		}
	}//insertGoods 메서드
	
}
