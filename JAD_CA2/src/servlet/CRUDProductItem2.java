package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbConfigs;

/**
 * Servlet implementation class CRUDProductItem2
 */
@WebServlet("/CRUDProductItem2")
public class CRUDProductItem2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CRUDProductItem2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());

		String stallID = request.getParameter("Storeid");
		//System.out.println("stallid = " + stallID);
		
		String type = request.getParameter("changed-button");
		int productid = Integer.parseInt(request.getParameter("id"));
	    
		//	Create http session to store product and stall info
		HttpSession session = request.getSession();
		
		switch (type) {
			case "delete": {
				try {
					//	Load the JDBC driver
					Class.forName("com.mysql.jdbc.Driver");
					
					//	Make a connection to the database
					String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			        Connection conn = DriverManager.getConnection(connURL);
			        
			        //	Check if session contains the affected productid
			        if (session.getAttribute("tempProductId") != null && (Integer) session.getAttribute("tempProductId") == productid) {
			        	// Does not exist anymore so remove it.
			        	session.removeAttribute("tempProductId"); 
			        }
			        
			        //	Prepare SQL Command
			        String deleteProduct = "DELETE FROM product WHERE ProductID = ?";
			        PreparedStatement ps = conn.prepareStatement(deleteProduct);
			        ps.setInt(1, productid);
			        
			        ps.executeUpdate();
			        
			        //	Close the connection
			        conn.close();
				} catch (Exception e) {
					System.out.println(e);
					
					//	Possibly add an error to check if column unable to delete
					response.sendRedirect("productAdmin.jsp?Storeid="+stallID+"&err=deletionError");
					
					//  End the function
					return ;
				}
				break;
			}
			case "edit": {
				//	Store the id of the product
				session.setAttribute("tempProductId", productid);
				break;
			}
			case "Add Product": {
				//	Get the information of the product to be added
				String name = request.getParameter("inp-pName");
				String StoreID = request.getParameter("Storeid");
			    int stock = Integer.parseInt(request.getParameter("inp-stock"));
			    double cost_price = Double.parseDouble(request.getParameter("inp-cost"));
			    double sell_price = Double.parseDouble(request.getParameter("inp-rtail"));
			    String desc = request.getParameter("inp-desc");
			    
				try {
					//	Load the JDBC driver
					Class.forName("com.mysql.jdbc.Driver");
					
					//	Make a connection to the database
					String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			        Connection conn = DriverManager.getConnection(connURL);
			       
			        //	Prepare SQL Command
			        String deleteProduct = "INSERT INTO product (AvailableStock, Cost_Price, Retail_Price, ProductName, Description,StoreID,StockSold) VALUES ( ?, ?, ?, ?, ?,?,?)";
			        PreparedStatement ps = conn.prepareStatement(deleteProduct);
			        ps.setInt(1, stock);
			        ps.setDouble(2, cost_price);
			        ps.setDouble(3, sell_price);
			        ps.setString(4, name);
			        ps.setString(5, desc);
			        ps.setString(6, StoreID);
			        ps.setInt(7, 0);
			        
			        //	Execute insert query
			        int rows = ps.executeUpdate();
			        System.out.println(rows + " rows affected");
			        
			        //	Close the connection
			        conn.close();
				} catch (Exception e) {
					System.out.println(e);
					//	Possibly add an error to check if user input is invalid
					response.sendRedirect("productAdmin.jsp?Storeid="+StoreID+"&err=insertError");
					
					//  End the function
					return ;
				}
				break;
			}
			case "Update Product": {
				//	Get the information of the product to be updated
				String name = request.getParameter("inp-pName");
			    int stock = Integer.parseInt(request.getParameter("inp-stock"));
			    double cost_price = Double.parseDouble(request.getParameter("inp-cost"));
			    double sell_price = Double.parseDouble(request.getParameter("inp-rtail"));
			    String desc = request.getParameter("inp-desc");
				System.out.println("Update Product");
				
				try {
					//	Load the JDBC driver
					Class.forName("com.mysql.jdbc.Driver");
					
					//	Make a connection to the database
					String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			        Connection conn = DriverManager.getConnection(connURL);
			       
			        //	Prepare SQL Command
			        String deleteProduct = "UPDATE product SET AvailableStock=?, Cost_Price=?, Retail_Price=?, ProductName=?, Description=?, StoreID=? WHERE ProductId=?";
			        PreparedStatement ps = conn.prepareStatement(deleteProduct);
			        ps.setInt(1, stock);
			        ps.setDouble(2, cost_price);
			        ps.setDouble(3, sell_price);
			        ps.setString(4, name);
			        ps.setString(5, desc);
			        ps.setString(6, stallID);
			        ps.setInt(7, productid);
			        
			        //	Execute insert query
			        int rows = ps.executeUpdate();
			        System.out.println(rows + " rows affected");
			        
			        //	Close the connection
			        conn.close();
				} catch (Exception e) {
					System.out.println(e);
					//	Possibly add an error to check if user input is invalid
					response.sendRedirect("productAdmin.jsp?Storeid="+stallID+"&err=updateError");
					
					//  End the function
					return ;
				}
				break;
			}
		}
		response.sendRedirect("productAdmin.jsp?Storeid=" + stallID);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
