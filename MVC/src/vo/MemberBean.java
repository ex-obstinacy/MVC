package vo;

import java.sql.Date;

public class MemberBean {
	
	private String id;
	private String pass;
	private String name;
	private String phone;
	private Date birthday;
	private String gender;
	private String email;
	private String postcode;
	private String address;
	private String detailAddress;
	private String extraAddress;
	private int coupon_1000;
	private int coupon_2000;
	private int coupon_3000;
	private int membership;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date date) {
		this.birthday = date;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getExtraAddress() {
		return extraAddress;
	}
	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}
	public int getCoupon_1000() {
		return coupon_1000;
	}
	public void setCoupon_1000(int coupon_1000) {
		this.coupon_1000 = coupon_1000;
	}
	public int getCoupon_2000() {
		return coupon_2000;
	}
	public void setCoupon_2000(int coupon_2000) {
		this.coupon_2000 = coupon_2000;
	}
	public int getCoupon_3000() {
		return coupon_3000;
	}
	public void setCoupon_3000(int coupon_3000) {
		this.coupon_3000 = coupon_3000;
	}
	public int getMembership() {
		return membership;
	}
	public void setMembership(int membership) {
		this.membership = membership;
	}
	
}
