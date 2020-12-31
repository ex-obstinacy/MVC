package vo;

import java.sql.Timestamp;

public class MovCommentBean {

	private int num; //댓글번호
	private String member_id; //작성자
	private String content; //댓글내용
	private Timestamp date;  //작성일
	private int cmgrade; //평점
	private int movie_board_movCode; //가져올값
	private String post;
	private String subjet;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getCmgrade() {
		return cmgrade;
	}
	public void setCmgrade(int cmgrade) {
		this.cmgrade = cmgrade;
	}
	public int getMovie_board_movCode() {
		return movie_board_movCode;
	}
	public void setMovie_board_movCode(int movie_board_movCode) {
		this.movie_board_movCode = movie_board_movCode;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getSubjet() {
		return subjet;
	}
	public void setSubjet(String subjet) {
		this.subjet = subjet;
	}
	
}
