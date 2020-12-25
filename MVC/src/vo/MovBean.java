package vo;

import java.sql.Date;

public class MovBean {
	
	private String subjet;
	private int movieCd;
	private String genre;
	private Date openDt;
	private String showTm;
	private String director;
	private String cast;
	private String nationNm;
	private String companys;
	private String grade;
	private String post;
	private String stillCut;
	private String[] stillCutFileName;
	private String trailer;
	private String content;
	private int ticketing;
	private float bookingRate;
	
	public String getSubjet() {
		return subjet;
	}
	public void setSubjet(String subjet) {
		this.subjet = subjet;
	}
	public int getMovieCd() {
		return movieCd;
	}
	public void setMovieCd(int movieCd) {
		this.movieCd = movieCd;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public Date getOpenDt() {
		return openDt;
	}
	public void setOpenDt(Date openDt) {
		this.openDt = openDt;
	}
	public String getShowTm() {
		return showTm;
	}
	public void setShowTm(String showTm) {
		this.showTm = showTm;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getCast() {
		return cast;
	}
	public void setCast(String cast) {
		this.cast = cast;
	}
	public String getNationNm() {
		return nationNm;
	}
	public void setNationNm(String nationNm) {
		this.nationNm = nationNm;
	}
	public String getCompanys() {
		return companys;
	}
	public void setCompanys(String companys) {
		this.companys = companys;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getStillCut() {
		return stillCut;
	}
	public String[] getStillCutFileName() {
		return stillCutFileName;
	}
	public void setStillCutFileName(String[] stillCutFileName) {
		this.stillCutFileName = stillCutFileName;
	}
	public void setStillCut(String stillCut) {
		this.stillCut = stillCut;
	}
	public String getTrailer() {
		return trailer;
	}
	public void setTrailer(String trailer) {
		this.trailer = trailer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getTicketing() {
		return ticketing;
	}
	public void setTicketing(int ticketing) {
		this.ticketing = ticketing;
	}
	public float getBookingRate() {
		return bookingRate;
	}
	public void setBookingRate(float bookingRate) {
		this.bookingRate = bookingRate;
	}

}
