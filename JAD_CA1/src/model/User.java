package model;

public class User {
	private int userId;
	private String userFName;
	private String userLName;
	private String userEmail;
	private boolean administrator;
	
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getUserId() {
		return userId;
	}
	public String getUserFName() {
		return userFName;
	}
	public void setUserFName(String userFName) {
		this.userFName = userFName;
	}
	public String getUserLName() {
		return userLName;
	}
	public void setUserLName(String userLName) {
		this.userLName = userLName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public boolean isAdministrator() {
		return administrator;
	}
	public void setAdministrator(boolean administrator) {
		this.administrator = administrator;
	}
}
