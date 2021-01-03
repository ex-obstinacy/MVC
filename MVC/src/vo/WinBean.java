package vo;

import java.sql.Timestamp;

public class WinBean {
	
	private int num;  
	private String subject;
	private String content;
	private int readcount;
	private Timestamp date;
	
	
	private String win_member;
	// 당첨자 회원 저장 
	private int event_num;
	
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}


	public String getWin_member() {
		return win_member;
	}
	public void setWin_member(String win_member) {
		this.win_member = win_member;
	}
	public int getEvent_num() {
		return event_num;
	}
	public void setEvent_num(int event_num) {
		this.event_num = event_num;
	}
	
	
	
}
