package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MovDAO;
import vo.MovBean;

public class MovListService {

	public ArrayList<MovBean> getCurrentMovList() {
		System.out.println("MovListService - getCurrentMovList()");
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		ArrayList<MovBean> currentMovList = movDAO.selectListCurrentMov();
		
		for (int i = 0; i < currentMovList.size(); i++) {
			currentMovList.get(i).setTotalRating(movDAO.selectCmgrade(currentMovList.get(i).getMovieCd()));
		}
		
		close(con);
		
		return currentMovList;
	}

	public ArrayList<MovBean> getToBeMovList() {
		System.out.println("MovListService - getToBeMovList()");
		
		// DB 작업을 위한 비즈니스 로직 수행 준비
		Connection con = getConnection();
		MovDAO movDAO = MovDAO.getInstance();
		movDAO.setConnection(con);
		
		ArrayList<MovBean> toBeMovList = movDAO.selectListToBeMov();
		
		for (int i = 0; i < toBeMovList.size(); i++) {
			toBeMovList.get(i).setTotalRating(movDAO.selectCmgrade(toBeMovList.get(i).getMovieCd()));
		}
		
		close(con);
		
		return toBeMovList;
	}

}
