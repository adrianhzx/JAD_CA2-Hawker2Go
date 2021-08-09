package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import config.DbConfigs;
import model.UserPaymentDetails;

public class SqlPaymentInfoQuery {
	private String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
	private Connection conn = null;
	
	public UserPaymentDetails getPaymentMethod(int id) {
		UserPaymentDetails details = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			String query = "SELECT * FROM paymentmethod WHERE fk_userID = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, id);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				details = new UserPaymentDetails();
				details.setMethodID(rs.getInt(1));
				details.setCvc(rs.getInt(2));
				details.setUserID(rs.getInt(3));
				rs.next();
			}
			
			conn.close();
			return details;
		} catch (Exception e) {
			System.out.println("Exception " + e);
		}
		return details;
	}
}
