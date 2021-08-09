package model;

public class AdminIncomingOrder {
	private int productId;
	private int quantity;
	private String User_address;
	private String orderKey;
	private String UserName;
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getUser_address() {
		return User_address;
	}
	public void setUser_address(String user_address) {
		User_address = user_address;
	}
	public String getOrderKey() {
		return orderKey;
	}
	public void setOrderKey(String orderKey) {
		this.orderKey = orderKey;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	
	
	
}
