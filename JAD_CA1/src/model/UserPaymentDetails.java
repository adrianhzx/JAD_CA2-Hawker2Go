package model;

public class UserPaymentDetails {
	private int userID;
	private int methodID;
	private int cvc;
	
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public int getMethodID() {
		return methodID;
	}
	public void setMethodID(int methodID) {
		this.methodID = methodID;
	}
	public int getCvc() {
		return cvc;
	}
	public void setCvc(int cvc) {
		this.cvc = cvc;
	}
	
}
