package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Types;

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
 * Servlet implementation class updateUserProfile
 */
@WebServlet("/updateUserProfile")
public class updateUserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateUserProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//	Get user details
		String firstName = request.getParameter("fName");
		String lastName = request.getParameter("lName");
		int paymentModeId = Integer.parseInt(request.getParameter("inp-payment"));
		String cardCV = request.getParameter("cc-no");
		
		HttpSession sess = request.getSession();
		User user = (User) sess.getAttribute("user");
		
		try {
			//	Load the JDBC driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//	Make a connection to the database
	        String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
	        Connection conn = DriverManager.getConnection(connURL);
	        
	        //	Prepare SQL Command
	        //	Check if user exists first, if yes, do not insert the user, redirect to error page
	        String userQuery = "UPDATE member SET FirstName = ?, LastName = ? WHERE UserId = ?";
	        PreparedStatement psUpdate = conn.prepareStatement(userQuery);
	        psUpdate.setString(1, firstName);
	        psUpdate.setString(2, lastName);
	        psUpdate.setInt(3, user.getUserId());
	        
	        psUpdate.executeUpdate();
	        
	        //	Prepare SQL command to update payment details
	        String paymentQuery = "UPDATE paymentmethod SET methodID = ?, cardID = ? WHERE fk_userID = ?";
	        PreparedStatement psUpdate2 = conn.prepareStatement(paymentQuery);
	        psUpdate2.setInt(1, paymentModeId);
	        if (cardCV.isEmpty()) {
	        	psUpdate2.setNull(2, Types.INTEGER);
	        } else {
	        	psUpdate2.setInt(2, Integer.parseInt(cardCV));
	        }
	        psUpdate2.setInt(3, user.getUserId());
	        
	        psUpdate2.executeUpdate();
	        
	        conn.close();
	        
	        //	Assign new user details
	        SqlUserQuery userQueryVer = new SqlUserQuery();
			User updatedUser = userQueryVer.getUser(user.getUserId());
			sess.setAttribute("user", updatedUser); 
			response.sendRedirect("userInfo.jsp?message=success");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception " + e);
			response.sendRedirect("userInfo.jsp?message=unsuccess");
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
