package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.CartItem;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//	Get stock
		int max_stock = Integer.parseInt(request.getParameter("max"));
		
		//	Get action parameter
		String action = request.getParameter("btnAction");
		
		// 	Get the session object
		HttpSession sess = request.getSession();
		
		//	Create an array list that stores order information.
		ArrayList<CartItem> cart = new ArrayList<CartItem>();
		
		//	Get the information from the check out cart, provided that the cart has at least 1 item.
		if (sess.getAttribute("cart") != null) {
			cart = (ArrayList<CartItem>) sess.getAttribute("cart");
		}
		
		//	Get Parameters from the form and servlet url
		String storeid = request.getParameter("sID");
		
		/*
			<input type='hidden' name='stallName' value="<%=stall_name%>" />
			<input type='hidden' name='productName' value="<%=product_name%>" />
			<input type='hidden' name='retailPrice' value="<%=retail_price%>" />
			<input type='hidden' name='productID' value="<%=product_id%>" />
		 */
		
		int productid = Integer.parseInt(request.getParameter("productID"));
		String productName = request.getParameter("productName");
		double retailPrice = Double.parseDouble(request.getParameter("retailPrice"));
		String stallName = request.getParameter("stallName");
		
		//	Perform adding or removal of items based on action
		if (action.equals("+")) {
			if (cart.isEmpty()) {
				System.out.println("CART SIZE IS ZERO");
				cart.add(new CartItem(productid, stallName, productName, retailPrice));
			} else {
				for (int i = 0; i < cart.size(); i++) {
					CartItem itemToCheck = cart.get(i);
					if (itemToCheck.getId() == productid && itemToCheck.getQuantity() < max_stock) {
						itemToCheck.addQuantity();
						//	-----------------------------
						//	PRINT FOR DEBUGGING PURPOSES
						//	-----------------------------
						System.out.println("Added one more of" + itemToCheck.getproductName() + " to cart. No of items: " + itemToCheck.getQuantity());
						break;
					} else if (i == cart.size() - 1) {
						//	Add to last index
						//	-----------------------------
						//	PRINT FOR DEBUGGING PURPOSES
						//	-----------------------------
						System.out.println("New item" + productName + "added to cart");
						cart.add(new CartItem(productid, stallName, productName, retailPrice));
						break;
					}
				}
			}
		} else {
			for (int i = 0; i < cart.size(); i++) {
				CartItem itemToCheck = cart.get(i);
				if (itemToCheck.getId() == productid) {
					itemToCheck.subtractQuantity();
					//	-----------------------------
					//	PRINT FOR DEBUGGING PURPOSES
					//	-----------------------------
					System.out.println("Item " + itemToCheck.getproductName() + " removed by 1. No of items: " + itemToCheck.getQuantity());
					
					//	Check if the quantity of the cart item is less than 1
					if (itemToCheck.getQuantity() < 1) {
						cart.remove(i);
						System.out.println("Item " + itemToCheck.getproductName() + " is removed from the cart" );
					}
					break;
				}
			}
		}
		
		//	Set session attribute "cart" to the current list of items 
		sess.setAttribute("cart", cart);
		
		//	Redirect to selectOrders
		response.sendRedirect("selectOrder.jsp?StoreID="+storeid);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
