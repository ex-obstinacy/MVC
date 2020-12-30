package svc;

import java.sql.Connection;
import java.util.ArrayList;


import dao.WinDAO;

import static db.JdbcUtil.*;


import vo.WinBean;

public class WinListService {

	public int getListCount() {
		System.out.println("WinListService - getListCount()");
		int listCount = 0;
		
		Connection con = getConnection();
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		listCount = winDAO.selectListCount();
		
		close(con);
		
		return listCount;
	}

	public ArrayList<WinBean> getArticleList(int page, int limit) {
		System.out.println("WinListService- getArticleList()");
		
		ArrayList<WinBean> articleList = null;
		
		Connection con = getConnection();
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		articleList = winDAO.selectArticleList(page, limit);
		
		close(con);
		
		return articleList;
	}

}
