package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.CartItem;
import config.DbConfigs;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * Servlet implementation class deductionofStocks
 */
@WebServlet("/deductionofStocks")
public class deductionofStocks extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public deductionofStocks() {
    	super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
        
		/*String[] getPID = (String[])session.getAttribute("getProductID");
		String[] getQuantity1 = (String[])session.getAttribute("quantity1"); */
		
		//	Get the information from the check out cart, provided that the cart has at least 1 item.
		ArrayList<CartItem> cart = new ArrayList<CartItem>();
		if (session.getAttribute("cart") != null) {
			cart = (ArrayList<CartItem>) session.getAttribute("cart");
		}
		
		boolean found = false;
		String orderPass = "";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			//Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String sqlStr = "update hawker2go_jad.product set AvailableStock = AvailableStock - ?, StockSold = StockSold + ? where productid = ?";
			
			PreparedStatement psUpdate = conn.prepareStatement(sqlStr);
			
			for (CartItem item : cart) {
				psUpdate.setInt(1, item.getQuantity());
				psUpdate.setInt(2, item.getQuantity());
				psUpdate.setInt(3, item.getId());
				psUpdate.executeUpdate();
				found = true;
			}
			
			/*
			for (int i = 0; i < getPID.length; i++) {
				psUpdate.setString(1, getQuantity1[i]);
				psUpdate.setString(2, getPID[i]);
				psUpdate.executeUpdate();
				found = true; //??
			} */
			
			conn.close();
		} catch (Exception e) {
			out.print("Error" + e);
		}
		
		//	Clear cart
		cart.clear();
		session.removeAttribute("cart");
		
		if(found == true) {
			//orderPass = "Passed";
			//session.setAttribute("orderPass", orderPass);
		
			//session.setMaxInactiveInterval(5);
			session.removeAttribute("countering");
			
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Your order has been placed!')");
			out.println("location='productlist.jsp';");
			out.println("</script>");
			
			//response.sendRedirect("productlist.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
