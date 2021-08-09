package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import config.DbConfigs;
import model.User;

public class SqlUserQuery {
	private String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
	private Connection conn = null;
	
	//	Get user
	public User getUser(int userId) {
		//	Get the user bean
		User user = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			String query = "SELECT * FROM member WHERE UserID = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, userId);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				user = new User();
				user.setUserId(rs.getInt(1));
				user.setUserFName(rs.getString(2));
				user.setUserLName(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				user.setAdministrator((rs.getInt(6) == 1) ? true : false);
			}
			
			conn.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return user;
	}
	
	//	Add user
	public int addUser(User user, String password) {
		//	Get the user bean
		User userToAdd = user;
		int addedId = 0;
		try {
			//	Add then get new id
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			String query = "INSERT INTO member(FirstName, LastName, Email, Password) VALUES (?, ?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, userToAdd.getUserFName());
			ps.setString(2, userToAdd.getUserLName());
			ps.setString(3, userToAdd.getUserEmail());
			ps.setString(4, password);
			
			ps.executeUpdate();
			
			//	Get new Id
			String idQuery = "SELECT UserID FROM member ORDER BY UserID desc LIMIT 1;";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(idQuery);
			
			while(rs.next()) {
				addedId = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return addedId;
	}

	//	Verify user
	public User verifyUser(String email, String password) {
		User user = null;
		try {
			//	Load the JDBC driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//	Make a connection to the database
			String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
	        Connection conn = DriverManager.getConnection(connURL);
	        
	        //	Prepare SQL Command
	        String userQuery = "SELECT * FROM member WHERE Email=? AND Password=?";
	        PreparedStatement ps = conn.prepareStatement(userQuery);
	        ps.setString(1, email);
	        ps.setString(2, password);
	        
	        //	Execute User Query
	        ResultSet rs = ps.executeQuery();
	        
	        while(rs.next()) {
	        	System.out.println("i'm going in");
	        	user = new User();
	        	user.setAdministrator((rs.getInt("admin") == 1) ? true : false);
	        	user.setUserFName(rs.getString("firstName"));
	        	user.setUserLName(rs.getString("lastName"));
	        	user.setUserEmail(rs.getString("Email"));
	        	user.setUserId(rs.getInt("userId"));
	        	System.out.println("New user" + user.getUserFName());
	        }
	            
	        conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("<br>server error: " + e);
		}
		
		return user;
	}
}
