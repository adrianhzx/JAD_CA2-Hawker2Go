package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbConfigs;

import java.io.PrintWriter;
import java.sql.*;

/**
 * Servlet implementation class AddStall
 */
@WebServlet("/AddStall")
public class AddStall extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddStall() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession(true);

		Integer getUserID = (Integer)session.getAttribute("id");
		
		//out.print(getUserID);
		String getStallName = request.getParameter("Stall_Name");
		String getStallLocation = request.getParameter("Stall_Location");
		String getStallCatName = request.getParameter("Stall_Cat");
		String getStallDescription = request.getParameter("Stall_Description");
		String getStallImg = request.getParameter("getImgName");
		
		
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
					
					String AddStall = "Insert into stall (StallName,StallLocation,ImageLocation,Description,CuisineCatID,OwnerID) values (?,?,?,?,?,?)";
					PreparedStatement psAdd = conn.prepareStatement(AddStall);
					psAdd.setString(1, getStallName);
					psAdd.setString(2, getStallLocation);
					psAdd.setString(3, getStallImg);
					psAdd.setString(4, getStallDescription);
					psAdd.setInt(5, CatId);
					psAdd.setInt(6, getUserID);
					int count = psAdd.executeUpdate();
					
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
				out.println("location='AdminUpdateAddStall.jsp';");
				out.println("</script>");
			}
			
			
			// Step 7: Close connection
			conn.close();
			
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
