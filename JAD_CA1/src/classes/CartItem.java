package classes;

public class CartItem {
	private int quantity = 1;
    private int id; //	Returns PRODUCT ID
    private String stallName;
    private String productName;
    private double price;
 // ======= adding storeid and productid =====
    private int Store_Id;
    private int User_Id;
    
    //	Constructor
    public CartItem(int id, String stallName ,String productName, double price ,int Store_Id, int User_Id) {
    	this.id = id;
        this.stallName = stallName;
        this.productName = productName;
        this.price = price;
        this.Store_Id = Store_Id;
        this.User_Id = User_Id;
    }
    
    //	Methods
    public int getId() { return id; }
    public double getPrice() { return price; }
    public String getstallName() { return stallName; }
    public String getproductName() { return productName; }
    public int getQuantity() { return quantity; }
    public int getStoreId() { return Store_Id; }
    public int getUserId() { return User_Id; }

    public void addQuantity() {quantity++;}
    public void subtractQuantity() {quantity--;}
    public int findQuantity(int id) {
    	//	Finds quantity of the product the user has ordered based on the product id
    	return quantity;
    }
}
