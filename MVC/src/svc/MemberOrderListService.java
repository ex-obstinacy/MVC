package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MemberDAO;
import vo.ReserveBean;
import vo.StoreBean;

public class MemberOrderListService {

	public int getOrderListCount(String id) throws Exception  {
		System.out.println("MemberOrderListService - getOrderListCount()");
		
		int listCount = 0;
		
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		listCount = memberDAO.selectOrderListCount(id);
		
		close(con);
		
		return listCount;
	}

	public ArrayList<StoreBean> getOrderList(int page, int limit, String id) throws Exception {
		System.out.println("MemberOrderListService - getOrderList()");
		
		ArrayList<StoreBean> articleList = null;
		
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		articleList = memberDAO.selectOrderList(page, limit, id);
		
		close(con);
		
		return articleList;
	}

}
