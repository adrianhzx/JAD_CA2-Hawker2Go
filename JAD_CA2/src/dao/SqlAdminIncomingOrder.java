package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import config.DbConfigs;
import model.AdminIncomingOrder;

public class SqlAdminIncomingOrder {
	public ArrayList<AdminIncomingOrder> getOrdertoAdminResult(int StoreID) {

		ArrayList<AdminIncomingOrder> setOrderResult = new ArrayList<AdminIncomingOrder>();
		// ProductSearch uBean = null;
		Connection conn = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/" + DbConfigs.db_name + "?user=" + DbConfigs.db_user + "&password="
					+ DbConfigs.db_password + "&serverTimezone=UTC";
			conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(
					"select o.productID, o.quantity, o.address, orderkey, concat(m.FirstName,\" \", m.LastName) as name from stall as s, orders as o,member as m where s.storeID = o.storeID and o.fk_userID = m.UserID and s.storeID = "+ StoreID +" and ordertime >= NOW() - INTERVAL 10 MINUTE;");

			while (rs.next()) {
				AdminIncomingOrder uBean = new AdminIncomingOrder();

				uBean.setProductId(rs.getInt(1));
				uBean.setQuantity(rs.getInt(2));
				uBean.setUser_address(rs.getString(3));
				uBean.setOrderKey(rs.getString(4));
				uBean.setUserName(rs.getString(5));

				setOrderResult.add(uBean);
			}

		} catch (Exception e) {
			System.out.print(e);
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				// TODO: handle exception
				System.out.print(e);
			}
		}
		// System.out.print("TEST!");
		return setOrderResult;
	}
}
