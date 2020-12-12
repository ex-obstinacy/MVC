package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.MemberDAO;
import vo.MemberShipBean;

public class MemberShipService {

	public MemberShipBean getMemberShip(String id) {
		System.out.println("MemberShipService - getMemberShip()");
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		MemberShipBean memberShip = memberDAO.selectMemberShip(id);
		
		if (memberShip.getPoint() > 3000) {
			memberShip.setGrade("VIP");
			
		} else if (memberShip.getPoint() > 2000) {
			memberShip.setGrade("GOLD");
			memberShip.setNextGrade("VIP");
			memberShip.setNextPoint(3000);
			
		} else if (memberShip.getPoint() > 1000) {
			memberShip.setGrade("SILVER");
			memberShip.setNextGrade("GODL");
			memberShip.setNextPoint(2000);
			
		} else {
			memberShip.setGrade("BRONZE");
			memberShip.setNextGrade("SILVER");
			memberShip.setNextPoint(1000);
			
		}
		
		close(con);
		
		return memberShip;
	}

}
