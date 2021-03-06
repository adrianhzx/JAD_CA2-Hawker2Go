<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.DbConfigs" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Main Page</title>
<link rel="stylesheet" href="headerfooter_style.css" />
<link rel="stylesheet" href="main.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
<!-- bootstrap 4.5 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
	integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
	crossorigin="anonymous"></script>
</head>

</head>
<body>
<%@include file="header.jsp"%>

<div class="container">

<%
Integer User_ID = (Integer)sess.getAttribute("id");

boolean checkingadmin = (boolean)sess.getAttribute("administrator");

if(checkingadmin == false){
	response.sendRedirect("index.jsp");
}


String name = "";
int TotalStocks = 0;
double totalCalculation = 0.0;
try{
	
	// Step1: Load JDBC Driver - TO BE OMITTED for newer drivers
	Class.forName("com.mysql.jdbc.Driver"); 
	
	// Step 2: Define Connection URL
	String connURL = "jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
	
	// Step 3: Establish connection to URL
	Connection conn = DriverManager.getConnection(connURL);
	
	// Step 4: Create Statement object
	Statement stmt = conn.createStatement();
	
	// Step 5: Execute SQL Command
	String sqlStr = "select * from stall as s, product as p, member as m where s.StoreID = p.StoreID and s.OwnerID = m.UserID and m.UserID = "+User_ID+"";
	ResultSet rs = stmt.executeQuery(sqlStr);
	
	// Step 6: Process Result
	while(rs.next()){
		name = rs.getString("FirstName") + " " + rs.getString("LastName");
		TotalStocks += rs.getInt("StockSold");
		totalCalculation += rs.getDouble("Retail_price") * rs.getInt("StockSold");
	}
	
	// Step 7: Close connection
	conn.close();
	
}catch(Exception e){
	out.print("Error" + e);
}
%>
	<h2 class="text-center pt-3 pb-2">Hi,<%=name %></h2>
	<h3 class="text-center pt-3 pb-2">Your Summary</h3>
	<div class="row text-center pt-3 pb-2">
		<div class="col">
			<h1><%=TotalStocks %></h1>
			<p>Total number of product sold</p>
		</div>
		<div class="col">
			<h1>$<%=totalCalculation %></h1>
			<p>Total Sales</p>
		</div>
	</div>
	
	
	
	
	<div class="row justify-content-center pt-3 pb-3">
		<div class="col-auto">
		<h3>My stalls</h3>
			<table class="table">
				<thead>
					<tr>
						<th scope="col">Name</th>
						<th scope="col">Location</th>
						<th scope="col">Category</th>
						<th scope="col">Description</th>
						<th scope="col">Stall Image</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
				
				<%
				String Stall_name;
				String stall_Location;
				String Cat_name;
				String ImageLocation;
				String Description;
				int Storeid;
				
				try{
					
					// Step1: Load JDBC Driver - TO BE OMITTED for newer drivers
					Class.forName("com.mysql.jdbc.Driver"); 
					
					// Step 2: Define Connection URL
					String connURL = "jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
					
					// Step 3: Establish connection to URL
					Connection conn = DriverManager.getConnection(connURL);
					
					// Step 4: Create Statement object
					Statement stmt = conn.createStatement();
					
					// Step 5: Execute SQL Command
					String sqlStr = "SELECT * FROM stall as s, category as c where s.CuisineCatID = c.CusineCatID and ownerid = '"+User_ID+"'";
					ResultSet rs = stmt.executeQuery(sqlStr);
					
					// Step 6: Process Result
					while(rs.next()){
						Stall_name = rs.getString("StallName");
						stall_Location = rs.getString("StallLocation");
						Cat_name = rs.getString("CategoryName");
						ImageLocation = rs.getString("ImageLocation");
						Description = rs.getString("Description");
						Storeid = rs.getInt("StoreID");
						%>
						<tr>
						<th class="align-middle"><%=Stall_name %></th>
						<th class="align-middle"><%=stall_Location %></th>
						<th class="align-middle"><%=Cat_name %></th>
						<th class="align-middle"><%=Description %></th>
						<th><img alt="what" src="./images/Food/<%=ImageLocation %>" width="141" height="180"></th>
						<th>
							<form action="DeleteStall" method="get"><input type="hidden" name="StoreID" value="<%=Storeid%>">
							<button type="submit" class="btn btn-danger"><i class="fa fa-trash" aria-hidden="true"></i>Delete</button>
							</form>
							
							<a href="AdminUpdateAddStall.jsp?Storeid=<%=Storeid%>"><button type="submit" class="btn btn-success"><i class="fa fa-pencil" aria-hidden="true"></i>Edit</button></a>
							<a href="productAdmin.jsp?Storeid=<%=Storeid%>"><button type="submit" class="btn btn-primary">See Product</button></a>
						</th>
						<!-- <a href='//.jsp?StoreID='> </a>-->
						</tr>
						<%
					}
							
					// Step 7: Close connection
					conn.close();
				
				}catch(Exception e){
					out.print("Error" + e);
				}
				%>
				
				</tbody>
			</table>
			<a href="AdminUpdateAddStall.jsp"><button type="button" class="float-right btn btn-primary">Add Stall</button></a>
		</div>
		
	</div>
	
</div>


<%@include file="footer.html"%>
</body>
</html>