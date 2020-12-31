package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MovDAO;
import vo.MovBean;

public class MovCurrentListService {

	public ArrayList<MovBean> getCurrentMovList() {
		System.out.println("MovCurrentListService - getCurrentMovList()");
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		ArrayList<MovBean> currentMovList = movDAO.selectAllListCurrentMov();
		
		for (int i = 0; i < currentMovList.size(); i++) {
			currentMovList.get(i).setTotalRating(movDAO.selectCmgrade(currentMovList.get(i).getMovieCd()));
		}
		
		close(con);
		
		return currentMovList;
	}

}
