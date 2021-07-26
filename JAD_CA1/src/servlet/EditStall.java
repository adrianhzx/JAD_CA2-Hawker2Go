package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import config.DbConfigs;

import java.io.PrintWriter;
import java.sql.*;
/**
 * Servlet implementation class EditStall
 */
@WebServlet("/EditStall")
public class EditStall extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditStall() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter();
		String getStoreId = request.getParameter("Storeid");
		String getStallName = request.getParameter("Stall_Name");
		String getStallLocation = request.getParameter("Stall_Location");
		String getStallCatName = request.getParameter("Stall_Cat");
		String getStallDescription = request.getParameter("Stall_Description");
		String getStallImg = request.getParameter("getImgName");
	
		//out.print("Stall Name = " + getStallName + "<br>" + "Stall Location = " + getStallLocation + "<br>" + "Stall Cat Name = " + getStallCatName + "<br>" + "Stall Description = " + getStallDescription + "<br>" + "Stall Img = " + getStallImging);
		
		int CatNameConvertCatID;
		int CatId = 0;
		boolean catConvertion = false;
		try{
			
			// Step1: Load JDBC Driver - TO BE OMITTED for newer drivers
			Class.forName("com.mysql.jdbc.Driver"); 
			
			// Step 2: Define Connection URL
			String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			
			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			
			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();
			
			// Step 5: Execute SQL Command
			String sqlStr = "select CusineCatID from category where CategoryName like '"+getStallCatName+"%'";
			ResultSet rs = stmt.executeQuery(sqlStr);
			
			// Step 6: Process Result
			while(rs.next()){
				CatNameConvertCatID = rs.getInt("CusineCatID");
				CatId = CatNameConvertCatID;
				catConvertion = true;
			}
			
			
			if(catConvertion == true) {
				
				boolean recordUpdated = false;
				
				try{
					
					String UpdateStall = "UPDATE stall SET StallName = ?, StallLocation = ?, ImageLocation = ?, Description = ?, CuisineCatID = ? WHERE StoreID = ?;";
					PreparedStatement psUpdate = conn.prepareStatement(UpdateStall);
					psUpdate.setString(1, getStallName);
					psUpdate.setString(2, getStallLocation);
					psUpdate.setString(3, getStallImg);
					psUpdate.setString(4, getStallDescription);
					psUpdate.setInt(5, CatId);
					psUpdate.setString(6, getStoreId);
					int count = psUpdate.executeUpdate();
					
					// Step 6: Process Result
					
					if(count>0) {
						out.print(count + " Recond has been updated");
						recordUpdated = true;
					}
					
					if(recordUpdated == true) {
						response.sendRedirect("admin.jsp");
					}
					// Step 7: Close connection
					conn.close();
					
				}catch(Exception e){
					out.print("Error" + e);
				}
			}
			
			if(catConvertion == false) {
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error! Please check that Category is correct!');");
				out.println("location='AdminUpdateAddStall.jsp?Storeid="+getStoreId+"';");
				out.println("</script>");
			}
			
				
			// Step 7: Close connection
			conn.close();
			
			//out.print(CatId);
			
		}catch(Exception e){
			out.print("Error" + e);
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
