package model;

public class OrderFinish {
	private String productName;
	private int Quantity;
	private double price;
	private String stallname;
	
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getQuantity() {
		return Quantity;
	}

	public void setQuantity(int quantity) {
		Quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getStallname() {
		return stallname;
	}

	public void setStallname(String stallname) {
		this.stallname = stallname;
	}

}
