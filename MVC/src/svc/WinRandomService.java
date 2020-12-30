package svc;



import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ApplyDAO;
import vo.ApplyBean;

public class WinRandomService {

	public int getArticleList(int event_num) {
		
		System.out.println("WinRandomService - getArticleList()");
		
		ArrayList<ApplyBean> articleList = null;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection(); // 메서드명만으로 접근 가능
		
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		ApplyDAO applyDAO = ApplyDAO.getInstance();
		
		applyDAO.setConnection(con);
		
		articleList =applyDAO.selectArticleList(event_num);
		
		// 저걸 랜덤함수랑 잘 버무려서 그 리턴값이 무슨 숫자가 나올거란 말이지
		// 그 숫자 가지고 해당하는 리스트 번호 불러오면 당첨자 나오겟지
		
		// 전체 갯수 (num)  
//		System.out.println("응모한 회원  : " + articleList.size() + "명");
//		
//		System.out.println("응모 번호1 : " +  articleList.get(0).getNum());
//		System.out.println("응모 번호1 : " +  articleList.get(1).getNum());
//		System.out.println("응모 아이디1 : " + articleList.get(0).getMember_id());
//		System.out.println("응모 아이디2 :  " + articleList.get(1).getMember_id());
		
		int result=0;
		int updateCount = 0;
		for(int i=1; i<=1;i++) {
			 result = ((int)(Math.random() * articleList.size())+1);
			System.out.println("당첨자 회원 번호 :"+ result);
			updateCount = applyDAO.updateArticle(result);
		}
////		
		System.out.println("당첨자 명 수 : " + updateCount);
//		System.out.println("result" + result);
		
//		System.out.println(articleList.get(0).getWin());
//		System.out.println(articleList.get(1).getWin());
//		System.out.println(articleList.get(2).getWin());
		
		if(updateCount>0) {
			commit(con);
			
		}else {
			rollback(con);
		}
		
		close(con);
		
		// 당첨자 번호 return
		return result;
	}


//	public ArrayList<ApplyBean> getArticleList(int event_num) {
//		
//		System.out.println("WinRandomService - getArticleList()");
//		
//		ArrayList<ApplyBean> articleList = null;
//		
//		// 1(공통). Connection 객체 가져오기
//		Connection con = getConnection(); // 메서드명만으로 접근 가능
//		
//		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
//		ApplyDAO applyDAO = ApplyDAO.getInstance();
//		
//		applyDAO.setConnection(con);
//		
//		articleList =applyDAO.selectArticleList(event_num);
//		
//		// 저걸 랜덤함수랑 잘 버무려서 그 리턴값이 무슨 숫자가 나올거란 말이지
//		// 그 숫자 가지고 해당하는 리스트 번호 불러오면 당첨자 나오겟지
//		
//		// 전체 갯수 (num)  
////		System.out.println("응모한 회원  : " + articleList.size() + "명");
////		
////		System.out.println("응모 번호1 : " +  articleList.get(0).getNum());
////		System.out.println("응모 번호1 : " +  articleList.get(1).getNum());
////		System.out.println("응모 아이디1 : " + articleList.get(0).getMember_id());
////		System.out.println("응모 아이디2 :  " + articleList.get(1).getMember_id());
//		
//		int result=0;
//		int updateCount = 0;
//		for(int i=1; i<=1;i++) {
//			 result = ((int)(Math.random() * articleList.size())+1);
//			System.out.println("당첨자 회원 번호 :"+ result);
//			updateCount = applyDAO.updateArticle(result);
//		}
//////		
//		System.out.println("당첨자 명 수 : " + updateCount);
////		System.out.println("result" + result);
//		
////		System.out.println(articleList.get(0).getWin());
////		System.out.println(articleList.get(1).getWin());
////		System.out.println(articleList.get(2).getWin());
//		
//		if(updateCount>0) {
//			commit(con);
//			
//		}else {
//			rollback(con);
//		}
//		
//		close(con);
//		
//		return articleList;
//	}
	
	

}
