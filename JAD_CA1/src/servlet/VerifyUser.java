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
import dao.SqlUserQuery;
import model.User;

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
		
		SqlUserQuery userQuery = new SqlUserQuery();
		User verifiedUser = userQuery.verifyUser(received_email, received_password);
	
		//  Check if user details are valid, i.e has a row.
		//System.out.print("UserID" + verifiedUser.getUserId());
		System.out.println("oaeoa" + verifiedUser);
        if (verifiedUser != null) {
        	HttpSession session = request.getSession(true);
        	session.setAttribute("user", verifiedUser); 
        	session.setAttribute("id", verifiedUser.getUserId());
        	session.setMaxInactiveInterval(3600);
        	//	Apply session management
        	response.sendRedirect("index.jsp");
        } else {
        	response.sendRedirect("login.jsp?message=invalidResponse");
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
