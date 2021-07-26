package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import config.DbConfigs;

import java.io.PrintWriter;
import java.sql.*;

/**
 * Servlet implementation class DeleteStall
 */
@WebServlet("/DeleteStall")
public class DeleteStall extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteStall() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String RemoveStall = request.getParameter("StoreID");
		
		boolean ifdeleted = false;
		//out.print(testing12345);
		try{
			
			// Step1: Load JDBC Driver - TO BE OMITTED for newer drivers
			Class.forName("com.mysql.jdbc.Driver"); 
			
			// Step 2: Define Connection URL
			String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			
			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			
			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();
			
			// Step 5: Execute SQL Command
			String sqlStr = "Delete from stall where StoreID =" + RemoveStall;
			int i = stmt.executeUpdate(sqlStr);
			
			if(i>0) {
				out.print( i + " Record has been deleted");
				ifdeleted = true;
			}
			
			if(ifdeleted == true) {
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Record has been deleted!');");
				out.println("location='admin.jsp';");
				out.println("</script>");
				//response.sendRedirect("admin.jsp");
			}
			
			
			// Step 7: Close connection
			conn.close();
			
		}catch(SQLIntegrityConstraintViolationException e) {
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Please remove all the items in the Product in order to delete the stall. :{');");
			out.println("location='admin.jsp';");
			out.println("</script>");
		}
		catch(Exception e){
			out.print("Error" + e);
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
