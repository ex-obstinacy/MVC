package vo;

import java.sql.Timestamp;

public class QnaBean {

	private int num;  
	private String subject;
	private String content;
	private int readcount;
	private String file;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private Timestamp date;
	private String member_id;
	private String p_member_id;  // 원글 글쓴이 (로그인한 회원에 따라 admin 일때는 본인글 조회, 
								 //일반회원은 본인 글과 본인글의 답글만 조회하기 위해 추가함
	
	
	
	public String getP_member_id() {
		return p_member_id;
	}
	public void setP_member_id(String p_member_id) {
		this.p_member_id = p_member_id;
	}
	
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
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}

	
	
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	
}
