package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.WinDAO;

import static db.JdbcUtil.*;

import vo.WinBean;

public class WinListSearchService {

	public int getListCount(String search) {
		
		int listCount = 0;
		
		Connection con = getConnection();
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		listCount = winDAO.selectListCount(search);
		
		return listCount;
	}

	public ArrayList<WinBean> getArticleList(int page, int limit, String search) {
		
		ArrayList<WinBean> articleList = null;
		
		Connection con = getConnection();
		
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		articleList = winDAO.selectArticleList(page, limit, search);
		
		close(con);
		
		return articleList;
	}

}
