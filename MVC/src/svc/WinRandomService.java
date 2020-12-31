package svc;



import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;
import java.util.Set;
import java.util.TreeSet;

import dao.ApplyDAO;
import dao.WinDAO;
import vo.ApplyBean;
import vo.WinBean;

public class WinRandomService {

	public Set<Integer> getArticleList(int event_num) {
		
		Set<Integer> win_members1 = null;
		Set<Integer> win_members2 = null;
		
//		System.out.println("WinRandomService - getArticleList()");
		
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
		System.out.println("응모한 회원  : " + articleList.size() + "명");
//		
//		System.out.println("응모 번호1 : " +  articleList.get(0).getNum());
//		System.out.println("응모 번호1 : " +  articleList.get(1).getNum());
//		System.out.println("응모 아이디1 : " + articleList.get(0).getMember_id());
//		System.out.println("응모 아이디2 :  " + articleList.get(1).getMember_id());
		
		int updateCount = 0;
		int win_member_num = 0;

		Random r = new Random();
		
		win_members1 = new TreeSet<Integer>();
		win_members2 = new TreeSet<Integer>();
		
		// 길이를 정해서 몇 명 추첨할건지 수정해야함! (현재는 무조건 2명 당첨)
		// 저장되는 요소(난수) 갯수가 3개보다 작을 동안 반복
		while(win_members2.size()<2) {
			win_members2.add(r.nextInt(articleList.size()));		// 0 ~ articleList.size-1 까지의 난수
		}
		
		System.out.println(win_members2);
		Iterator<Integer> ite = win_members2.iterator();
		while(ite.hasNext()) {
			int o = (int) ite.next();
			// 당첨된 사람 아이디
			System.out.println("당첨된 회원 : " + articleList.get(o).getMember_id());
			// 해당 이벤트에서 당첨된 사람 아이디의 응모번호(apply테이블의 num)
			System.out.println("응모번호 : " + articleList.get(o).getNum());
			win_member_num = articleList.get(o).getNum();
			updateCount = applyDAO.updateArticle(win_member_num);
			
			// win_member2는 index 순서이므로 num번호로 바꿔서 새 set에 저장
			win_members1.add(articleList.get(o).getNum());
		}
//		System.out.println("당첨자 번호 : " + win_members1);
		
		if(updateCount>0) {
			commit(con);
			
		}else {
			rollback(con);
		}
			
		close(con);
		
		// 당첨자 번호 return
		return win_members1;
	}

	public ArrayList<WinBean> getWinMemberInfo(Set<Integer> win_members) {
		
//		System.out.println("WinRandomService - getWinMemberInfo()");
		
		ArrayList<WinBean> winMemberList = null;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection(); // 메서드명만으로 접근 가능
		
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		ApplyDAO applyDAO = ApplyDAO.getInstance();
		
		applyDAO.setConnection(con);
		
		winMemberList = applyDAO.getWinMemberInfo(win_members);
		
		if(winMemberList != null) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return winMemberList;
	}

	public boolean updateWinMember(ArrayList<WinBean> winMemberList) {
		
		System.out.println("WinRandomService - updateWinMember()");
		boolean isUpdateSuccess = false;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection(); // 메서드명만으로 접근 가능
		
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		int updateCount = winDAO.updateWinMember(winMemberList);
		
		if(updateCount > 0) {
			commit(con);
			isUpdateSuccess = true;
			
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isUpdateSuccess;
		
	}

	public boolean hasWinMember(int event_num) {
		
		boolean hasWinMember = false;
		
		// 1(공통). Connection 객체 가져오기
		Connection con = getConnection(); // 메서드명만으로 접근 가능
		
		// 2(공통). DB 작업에 필요한 DAO 객체 가져오기
		WinDAO winDAO = WinDAO.getInstance();
		
		winDAO.setConnection(con);
		
		String winMember = winDAO.hasWinMember(event_num);
		
		// 당첨자가 admin 인 경우 -> 아직 추첨안함!
		// 당첨자가 admin 이 아닌 경우 -> 이미 추첨함!
		if(!(winMember.equals("admin"))) {
			commit(con);
			hasWinMember = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return hasWinMember;
	}


}
