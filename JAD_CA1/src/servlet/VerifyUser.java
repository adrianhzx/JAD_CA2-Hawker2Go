package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbConfigs;

/**
 * Servlet implementation class VerifyUser
 */
@WebServlet("/VerifyUser")
public class VerifyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VerifyUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String received_email = request.getParameter("email");
		String received_password = request.getParameter("password");
		
		PrintWriter out = response.getWriter();
		
		try {
			//	Load the JDBC driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//	Make a connection to the database
			String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
	        Connection conn = DriverManager.getConnection(connURL);
	        
	        //	Create Statement
	        // Statement stmt = conn.createStatement();
	        
	        //	Prepare SQL Command
	        String userQuery = "SELECT * FROM member WHERE Email=? AND Password=?";
	        PreparedStatement ps = conn.prepareStatement(userQuery);
	        
	        ps.setString(1, received_email);
	        ps.setString(2, received_password);
	        
	        //	Execute User Query
	        ResultSet rs = ps.executeQuery();
	        int rowcount = 0;
	        
	        int isAdmin = 0, userId = 0;
	        String fname = "", lname = "";
	        
	        while(rs.next()) {
	        	isAdmin = rs.getInt("admin");
	        	fname = rs.getString("firstName");
	        	lname = rs.getString("lastName");
	        	userId = rs.getInt("userId");
	        	rowcount += 1;
	        }
	        
	        //  Check if user details are valid, i.e has a row.
	        if (rowcount > 0) {
	        	//	Apply session management
	        	//  response.sendRedirect("login.jsp?message=validResponse");
	        	
	        	out.println("<br>isAdmin: " + isAdmin + " firstName: " + fname + " lastName: " + lname + " userId: " + userId);
	        	
	        	HttpSession session = request.getSession(true);
	        	session.setAttribute("fname", fname);
	        	session.setAttribute("lname", lname);
	        	
	        	if (isAdmin == 0) {
	        		session.setAttribute("administrator", false); 
	        	} else {
	        		session.setAttribute("administrator", true); 
	        	}
	        	
	        	session.setAttribute("id", userId);
	        	session.setMaxInactiveInterval(3600); // 1 hour 
	        	
	        	conn.close();
	        	response.sendRedirect("index.jsp");
	        } else {
	        	conn.close();
	        	response.sendRedirect("login.jsp?message=invalidResponse");
	        }

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println("<br>server error: " + e);
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
