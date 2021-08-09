package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.OrderFinish;
import model.OrderHistory;

import config.DbConfigs;
public class SqlOrderHistory {
	public ArrayList<OrderHistory> getOrderHistoryResult(String OrderKey){
		ArrayList<OrderHistory> setOrderHistoryResult = new ArrayList<OrderHistory>();
		
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select  p.ProductName,o.quantity, p.Retail_Price, s.StallName from orders as o, member as m , stall as s, product as p where o.fk_userID=m.UserID AND s.storeID = o.storeID AND o.productID = p.productID AND orderkey = '"+OrderKey+"' ");
			
			while(rs.next()) {
				OrderHistory uBean = new OrderHistory();
				
				uBean.setProductName(rs.getString(1));
				uBean.setQuantity(rs.getInt(2));
				uBean.setPrice(rs.getDouble(3));
				uBean.setStallName(rs.getString(4));
				
				setOrderHistoryResult.add(uBean);
			}
			
		}catch(Exception e) {
			System.out.print(e);
		}
		finally {
			try {
				conn.close();
			}catch (Exception e) {
				// TODO: handle exception
				System.out.print(e);
			}
		}
		//System.out.print("TEST!");
		return setOrderHistoryResult;
	}
}
