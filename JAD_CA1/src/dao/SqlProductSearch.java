package dao;
import java.sql.*;
import java.util.ArrayList;

import config.DbConfigs;
import model.*;

public class SqlProductSearch {

	public ArrayList<ProductSearch> getCategoryResult() {
		// TODO Auto-generated constructor stub
		ArrayList<ProductSearch> setSearch= new ArrayList<ProductSearch>();
		//ProductSearch uBean = null;
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select CusineCatID, CategoryName from category");
			
			while(rs.next()) {
				ProductSearch uBean = new ProductSearch();
				
				uBean.setCategoryId(rs.getInt(1));
				uBean.setCategoryName(rs.getString(2));
				
				setSearch.add(uBean);
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
		return setSearch;
		//System.out.print("TEST!");
	}
	
	public ArrayList<FindProduct> getListofProduct() {
		// TODO Auto-generated constructor stub
				ArrayList<FindProduct> list_of_Product = new ArrayList<FindProduct>();
				//ProductSearch uBean = null;
				Connection conn = null;
				
				try {
					Class.forName("com.mysql.jdbc.Driver");
					String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
					conn = DriverManager.getConnection(connURL);
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("select CategoryName,StallLocation,StallName,ImageLocation,StoreID from stall as s, category as c where s.CuisineCatID = c.CusineCatID");
					
					while(rs.next()) {
						FindProduct uBean = new FindProduct();
						
						uBean.setCategory_name(rs.getString(1));
						uBean.setStall_location(rs.getString(2));
						uBean.setStall_name(rs.getString(3));
						uBean.setStall_img(rs.getString(4));
						uBean.setStall_storeid(rs.getInt(5));
						
						list_of_Product.add(uBean);
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
				return list_of_Product;	
	}
	public ArrayList<FindProduct> getListofProductWithName(String SearchofName, String Catvalue, String indexName, String indexCatName){
		
		ArrayList<FindProduct> List_of_NameandcatProduct = new ArrayList<FindProduct>();
		
		Connection conn = null;
		
		String getNameCategory = "";
		if(indexCatName != null){
			getNameCategory = " and c.CategoryName='" + indexCatName + "' ";
		}else{
			getNameCategory = "";
		}
		
		String getNameSearch = "";
		if(indexName != null){
			getNameSearch = " and s.stallName like '"+indexName+"%' " ;
		}else{
			getNameSearch = "";
		}
		
		String FindWithSearch;
		if (SearchofName != null) {
			FindWithSearch = " and s.stallName like '" + SearchofName + "%' ";
		} else {
			FindWithSearch = "";
		}

		String FindWithCategoryID;
		if (Catvalue != null) {
			FindWithCategoryID = " and s.CuisineCatID='" + Catvalue + "' ";
		} else {
			FindWithCategoryID = "";
		}
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();
			//String sqlStr = "select c.CategoryName, s.StallLocation, s.StallName, s.ImageLocation, s.StoreID from stall as s, category as c where s.CuisineCatID = c.CusineCatID "+FindWithSearch+" "+FindWithCategoryID+" order by stallName";
			String sqlStr = "";
			if(indexCatName != null){
				sqlStr = "select c.CategoryName, s.StallLocation, s.StallName, s.ImageLocation, s.StoreID from stall as s, category as c where s.CuisineCatID = c.CusineCatID "+getNameCategory+" order by stallName";
			}else if (indexName != null){
				sqlStr = "select c.CategoryName, s.StallLocation, s.StallName, s.ImageLocation, s.StoreID from stall as s, category as c where s.CuisineCatID = c.CusineCatID "+getNameSearch+" order by stallName";
			}
			else{
			sqlStr = "select c.CategoryName, s.StallLocation, s.StallName, s.ImageLocation, s.StoreID from stall as s, category as c where s.CuisineCatID = c.CusineCatID "+FindWithSearch+" "+FindWithCategoryID+" order by stallName";
			}
			ResultSet rs = stmt.executeQuery(sqlStr);
			
			while(rs.next()) {
				FindProduct uBean = new FindProduct();
				
				uBean.setCategory_name(rs.getString(1));
				uBean.setStall_location(rs.getString(2));
				uBean.setStall_name(rs.getString(3));
				uBean.setStall_img(rs.getString(4));
				uBean.setStall_storeid(rs.getInt(5));
				
				List_of_NameandcatProduct.add(uBean);
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
		return List_of_NameandcatProduct;
	}

}
