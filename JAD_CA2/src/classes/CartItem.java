package classes;

public class CartItem {
	private int quantity = 1;
    private int id; //	Returns PRODUCT ID
    private String stallName;
    private String productName;
    private double price;
    
    //	Constructor
    public CartItem(int id, String stallName ,String productName, double price) {
    	this.id = id;
        this.stallName = stallName;
        this.productName = productName;
        this.price = price;
    }
    
    //	Methods
    public int getId() { return id; }
    public double getPrice() { return price; }
    public String getstallName() { return stallName; }
    public String getproductName() { return productName; }
    public int getQuantity() { return quantity; }

    public void addQuantity() {quantity++;}
    public void subtractQuantity() {quantity--;}
    public int findQuantity(int id) {
    	//	Finds quantity of the product the user has ordered based on the product id
    	return quantity;
    }
}
