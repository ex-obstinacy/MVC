package vo;


import java.sql.Timestamp;

public class StoreBean {
	private int goodsId; //상품번호
	private int basketId; //장바구니번호
	private int orderId; //구매번호
	private String ctg; //카테고리
	private String name; //상품이름
	private int price; //상품가격
	private int totalPrice; //총가격
	private int sumPrice;//할인적용후최종가격
	private int sale; //할인율
	private int sellCount; //판매수량
	private String component; //상품구성
	private String file; //이미지파일
	private String content; //상세내용
	private Timestamp date; //현재날짜
	private int basketCount; //장바구니 수량
	private int orderCount; //결제 수량
	private String orderNum; //주문 번호
	private String reserveNum; //예약 번호
	private String expiredate; //유효 기간
	private boolean status; //사용상태확인
	private String member_id; // 멤버아이디 
	private int goods_goodsId; // 상품번호 (외래키) 
	private String member_name; //멤버이름

	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public int getBasketId() {
		return basketId;
	}
	public void setBasketId(int basketId) {
		this.basketId = basketId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getCtg() {
		return ctg;
	}
	public void setCtg(String ctg) {
		this.ctg = ctg;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public int getSumPrice() {
		return sumPrice;
	}
	public void setSumPrice(int sumPrice) {
		this.sumPrice = sumPrice;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	public int getSellCount() {
		return sellCount;
	}
	public void setSellCount(int sellCount) {
		this.sellCount = sellCount;
	}
	public String getComponent() {
		return component;
	}
	public void setComponent(String component) {
		this.component = component;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
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
	public int getBasketCount() {
		return basketCount;
	}
	public void setBasketCount(int basketCount) {
		this.basketCount = basketCount;
	}
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getReserveNum() {
		return reserveNum;
	}
	public void setReserveNum(String reserveNum) {
		this.reserveNum = reserveNum;
	}
	public String getExpiredate() {
		return expiredate;
	}
	public void setExpiredate(String expiredate) {
		this.expiredate = expiredate;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	
	public int getGoods_goodsId() {
		return goods_goodsId;
	}
	
	public void setGoods_goodsId(int goods_goodsId) {
		this.goods_goodsId = goods_goodsId;
	}
	
	public String getMember_name() {
		return member_name;
	}
	
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	
}
