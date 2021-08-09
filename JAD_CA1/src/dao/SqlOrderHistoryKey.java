package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.OrderHistoryKey;

import config.DbConfigs;
public class SqlOrderHistoryKey {
	public ArrayList<OrderHistoryKey> getOrderHistoryKeyResult(int UserId){
		ArrayList<OrderHistoryKey> setOrderHistoryKeyResult = new ArrayList<OrderHistoryKey>();
		
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select o.orderkey, date(o.ordertime), time(o.ordertime) from orders as o, member as m , stall as s, product as p where o.fk_userID=m.UserID AND s.storeID = o.storeID AND o.productID = p.productID AND o.fk_userID = "+UserId+" group by orderkey order by 3 desc");
			
			while(rs.next()) {
				OrderHistoryKey uBean = new OrderHistoryKey();
				
				uBean.setOrderkey(rs.getString(1));
				uBean.setDate(rs.getString(2));
				uBean.setTime(rs.getString(3));
				//uBean.setStallname(rs.getString(4));
				
				setOrderHistoryKeyResult.add(uBean);
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
		return setOrderHistoryKeyResult;
	}
}
