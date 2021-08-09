<%@ page import="java.sql.*"%>
<%@ page import="config.DbConfigs" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Your Stalls</title>
		<link rel="stylesheet" href="headerfooter_style.css" />
		<link rel="stylesheet" href="main.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
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
	<body>
		<%@include file="header.jsp"%>
		<%
			String StoreID = request.getParameter("Storeid");
			
			// Check for administrator
			if (!userObj.isAdministrator()) {
				response.sendRedirect("index.jsp");
			}
		%>
		<div class="container">
			<%	
				String errName = request.getParameter("err");
				String message = "";
				if (errName != null) {
					//	Find the name of the error
					switch(errName) {
						case "insertError": message = "There was a problem adding the product. Please try again later."; break;
						case "updateError": message = "There was a problem updating the product. Please ensure that you had entered all input fields correctly."; break;
						case "deletionError": message = "There was a problem deleting the product"; break;
					}%>
					<div class="centered width-50">
						<div class="error-message">
							<i class = "fa fa-exclamation-triangle"></i>
							<b><%=message%></b>
						</div>
					</div>
			<%	} %>
			<h2>My Products</h2>
		
			<table class="table" id="products">
				<tr>
					<th scope="col">ProductCode</th>
			        <th scope="col">Name</th>
			        <th scope="col">Cost Price ($)</th>
			        <th scope="col">Sell Price ($)</th>
			        <th scope="col">Description</th>
			        <th scope="col">Available Stock</th>
			        <th scope="col"></th>
			        <th scope="col"></th>
				</tr>

				<% 
					//	Load the JDBC driver
					Class.forName("com.mysql.jdbc.Driver");
					
					//	Make a connection to the database
			        String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			        Connection conn = DriverManager.getConnection(connURL);
			        
			        String userQuery = "SELECT * FROM product WHERE StoreID="+StoreID+"";
			        PreparedStatement psSelect = conn.prepareStatement(userQuery);
			        
			        ResultSet rs = psSelect.executeQuery();
			        
			        while(rs.next()) {
			        	int pid = rs.getInt("ProductID");
			        	int quantity = rs.getInt("AvailableStock");
			        	double cost = rs.getDouble("Cost_Price");
			            double sell = rs.getDouble("Retail_Price");
			            String name = rs.getString("ProductName");
			            String desc = rs.getString("Description");
			    %> 
			        <tr class="clickable-row">
			        	<td class="pt-1 pb-1"><%=pid%></td>
			        	<td class="pt-1 pb-1"><%=name%></td>
			        	<td class="pt-1 pb-1"><%=cost%></td>
			        	<td class="pt-1 pb-1"><%=sell%></td>
			        	<td class="pt-1 pb-1"><%=desc%></td>
			        	<td class="pt-1 pb-1"><%=quantity%></td>
			        	<td class="py-0 px-0">
			        		<form action="CRUDProductItem2" method="POST">
			        			<input type="hidden" value=<%=pid%> name="id" />
			        			<input type="hidden" value=<%=StoreID%> name="Storeid" />
			        			<button style="visibility: hidden" type="submit" name="changed-button" value="edit"><i class="fa fa-pencil" style="visibility: visible"></i></button>
			       			</form>
			        	</td>
			        	<td class="py-0 px-0">
			        		<form action="CRUDProductItem2" method="POST">
			        			<input type="hidden" value=<%=pid%> name="id" />
			        			<input type="hidden" value=<%=StoreID%> name="Storeid" />
			        			<button style="visibility: hidden" type="submit" name="changed-button" value="delete"><i class="fa fa-trash" style="visibility: visible"></i></button>
			        		</form>
			        	</td>
			        </tr>
				<% }
				%>
			</table>
			
			<br><h2>Product Information</h2>
			<%
				String inp_name = "";
			    int inp_stock = 0;
			    double inp_cost = 0;
			    double inp_sell = 0;
			    String inp_desc = "";
			    
			    int temp_id = 0;
			    if (sess.getAttribute("tempProductId") != null) {
			    	temp_id = (Integer) sess.getAttribute("tempProductId");
			    	String getProductById = "SELECT * FROM product WHERE StoreID="+StoreID+" AND ProductID=?";
			    	PreparedStatement psSelectById = conn.prepareStatement(getProductById);
			    	
			    	psSelectById.setInt(1, (Integer) sess.getAttribute("tempProductId"));
			    	
			    	//	Get stall information needed for editing
			    	ResultSet rsId = psSelectById.executeQuery();
			   
			    	while (rsId.next()) {
			        	inp_stock = rsId.getInt("AvailableStock");
			        	inp_cost = rsId.getDouble("Cost_Price");
			            inp_sell = rsId.getDouble("Retail_Price");
			            inp_name = rsId.getString("ProductName");
			            inp_desc = rsId.getString("Description");
			    	}
			    }
			    conn.close(); // Close the connection
			%>

			<form class= "p-2" action="CRUDProductItem2" method="POST">
				<div class=" bg-light row">
					<div class="col p-2">
						<div class="row">
							<label class="m-1 col-3">Product Name</label>
							<input type="text" name="inp-pName" class="input-styling col w-50" value="<%=inp_name%>"/><br>
							<div class="col-1"></div>
						</div>
						<br>
						<div class="row">
							<label class="m-1 col-3">Available Stock</label>
							<input type="number" name="inp-stock" class="input-styling col w-50" value="<%=inp_stock%>" min="0"/><br>
							<div class="col-1"></div>
						</div>
						<br>
						<div class="row">
							<label class="m-1 col-3">Cost Price</label>
							<input type="number" name="inp-cost" class="input-styling col w-50" value="<%=inp_cost%>" min="0" step="any"/><br>
							<div class="col-1"></div>
						</div>
						<br>
						<div class="row">
							<label class="m-1 col-3">Retail Price</label>
							<input type="number" name="inp-rtail" class="input-styling col w-50" value="<%=inp_sell%>" min="0" step="any"/><br>
							<div class="col-1"></div>
						</div>
						<input type="hidden" name="Storeid" value="<%=StoreID %>" />
					</div>
					<div class="col p-2">
						<label class="m-1">Description</label><br>
						<textarea name="inp-desc" rows="5" cols="60" class="input-styling" name="inp-desc"><%=inp_desc%></textarea>
					</div>
				</div>
				<div class="row">
					<div class="col p-2">
						<input type="hidden" value="<%=temp_id%>" name="id" />
						<input type="submit" name="changed-button" value="Add Product" class="input-styling float-right" style="background-color:green;"/>
						<% if (sess.getAttribute("tempProductId") == null) {%>
							<input type="submit" name="changed-button" value="Update Product" class="input-styling float-right" disabled/>
						<% } else { %>
							<input type="submit" name="changed-button" value="Update Product" class="input-styling float-right" />
						<% } %>
					</div>
				</div>
			</form>
		</div>
		
	
		<%@include file="footer.html" %>
	</body>
</html>