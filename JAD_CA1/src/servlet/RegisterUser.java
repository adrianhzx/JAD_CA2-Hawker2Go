package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// User Defined
import config.DbConfigs;
import dao.SqlUserQuery;
import model.User;

/**
 * Servlet implementation class RegisterUser
 */
@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String received_fname = request.getParameter("fname");
		String received_lname = request.getParameter("lname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String repeat_password = request.getParameter("password-cfm");
		
		PrintWriter out = response.getWriter();
		
		User newUser = new User();
		newUser.setUserFName(received_fname);
		newUser.setUserLName(received_lname);
		newUser.setUserEmail(email);
		
		//	Password Match
		if (password.equals(repeat_password)) {
			try {
				//	Load the JDBC driver
				Class.forName("com.mysql.jdbc.Driver");
				
				//	Make a connection to the database
		        String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
		        Connection conn = DriverManager.getConnection(connURL);
		        
		        Statement st = conn.createStatement(); // Do this if there are no parameters
		        
		        //	Prepare SQL Command
		        //	Check if user exists first, if yes, do not insert the user, redirect to error page
		        String userQuery = "SELECT * FROM member WHERE Email=?";
		        PreparedStatement psSelect = conn.prepareStatement(userQuery);
		        psSelect.setString(1, email);
		        
		        //	Execute user query
		        ResultSet rs = psSelect.executeQuery();
		        int rowcount = 0;
		        
		        //	To add a new user, the row should not contain a column that contains the input email
		        while(rs.next()) {
		        	rowcount += 1;
		        }
		        
		        if (rowcount > 0) {
		        	//	User with the email exists
		        	response.sendRedirect("login.jsp?message=userExists");
		        } else {
		        	SqlUserQuery sqlquery = new SqlUserQuery();
		        	int rowAdded = sqlquery.addUser(newUser, password); // row number returned
		        	User addedUser = sqlquery.getUser(rowAdded);
		       
		        	HttpSession session = request.getSession(true);
		        	session.setAttribute("user", addedUser); 
		        	session.setMaxInactiveInterval(3600); // 1 hour
		        	
		        	conn.close();
		        	response.sendRedirect("index.jsp");
		        }
			} catch (Exception e) {
				e.printStackTrace();
				out.println("<br>server error: " + e);
			}
		} else {
			response.sendRedirect("login.jsp?message=pwdMismatch");
		}
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}