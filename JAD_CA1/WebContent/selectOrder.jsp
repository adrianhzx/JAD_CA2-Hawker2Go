<%@ page import="java.sql.*" %>
<%@ page import="config.DbConfigs" %>
<%@ page import="classes.CartItem" %>
<%@ page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Insert title here</title>
	<link rel="stylesheet" href="headerfooter_style.css" />
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
		
	<script>
		document.addEventListener("DOMContentLoaded", function(event) {
			var scrollY = localStorage.getItem('scrollY');
			window.scrollTo(0, scrollY);
			localStorage.clear();
		})
	</script>
	</head>
	<body>
		<%@include file="header.jsp"%>
		<%
		
		// do some math
		int ifusergetvalue = 0;
		
		boolean checkingifvaluepassed = false;
		
		//boolean checkingifvaluepassed = false;
		
		//System.out.print(checkingifvaluepassed);
		
		ArrayList<CartItem> cartlist = new ArrayList<CartItem>();
		
		if (sess.getAttribute("cart") != null) {
			cartlist = (ArrayList<CartItem>) sess.getAttribute("cart");
		}
		 
		String getStoreId = request.getParameter("StoreID");
		
		String stall_img = "";
		String stall_location = "";
		String stall_description = "";
		String stall_name = "";
		
		//boolean found = false;
		try{
			Class.forName("com.mysql.jdbc.Driver"); 
			
			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			
			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			
			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();
			
			// Step 5: Execute SQL Command
			String sqlStr = "SELECT * FROM stall WHERE StoreID='"+ getStoreId +"' ";
		
			ResultSet rs = stmt.executeQuery(sqlStr);
			
			// Step 6: Process Result
			if(rs.next()){
				//out.print("record found<br>");
				stall_img = rs.getString("ImageLocation");
				stall_location = rs.getString("StallLocation");
				stall_description = rs.getString("Description");
				stall_name = rs.getString("StallName");
				//out.println("User: " + user + " , Password: " + pwd + "<br>");
				//out.print("testing" + stall_name);
				//found = true;
			}else{
				out.print("test");
			}
			// Step 7: Close connection
			conn.close();
		
			
		}catch(Exception e){
			out.print("Error" + e);
		};
		
		%>
	
		<!-- <h1>My Orders Page</h1> -->
		<!--  <form action="OrderSummary.jsp" method="post"> -->
		<div class="container">
			<div class="row">
				<div class="pt-4 pb-4 col"><img alt="testing1" src="./images/Food/<%=stall_img%>" width="288" height="369"></div>
				<div class="col">
						<br><h3 class="float-right Product-Category-name"><%=stall_name%></h3><br>
						<br><p class="float-right Product-Location-name"><%=stall_location%></p><br>
						<br><p class="float-right"><%=stall_description%></p><br>                      			
				</div>
			</div>
			
			<!--  Menu Items with table -->
			<h2 class="pt-2 pb-1"><i class="fa fa-cutlery" aria-hidden="true"></i> Menu Items</h2>
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">Product</th>
			    
			      <th scope="col">Stock Left</th>
			      <th scope="col">Price</th>
			      <th scope="col">Quantity</th>
			    </tr>
			  </thead>
			  <tbody>
				<%
				
				String product_name = "";
				int available_stock = 0;
				double retail_price = 0;
				int product_id = 0;
				
				String pid = "";
				
				
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
					String sqlStr = "select * from product as p,stall as s where p.StoreID = s.StoreID and s.StoreID='"+ getStoreId +"'";
					ResultSet rs = stmt.executeQuery(sqlStr);
					
					// Step 6: Process Result
					while(rs.next()){
						product_name = rs.getString("ProductName");
						available_stock = rs.getInt("AvailableStock");
						retail_price = rs.getDouble("Retail_Price");
						product_id = rs.getInt("ProductID");
						
						pid += product_id; 
						
					%>
						<tr>
							<td><%=product_name%></td>
							<td><%=available_stock%></td>
							<td>$<%=retail_price%></td>
							<td>
								<form action="AddToCart?sID=<%=request.getParameter("StoreID")%>" onsubmit="submitWithoutRefresh(this)" method="POST">
									<input type='hidden' name='stallName' value="<%=stall_name%>" />
									<input type='hidden' name='productName' value="<%=product_name%>" />
									<input type='hidden' name='retailPrice' value="<%=retail_price%>" />
									<input type='hidden' name='productID' value="<%=product_id%>" />
									
									<button type="submit" name="btnAction" value="+">
										<i class="fa fa-plus"></i>
									</button>
									
									<% 
									
										if (cartlist.isEmpty()) {
											out.println("<input type='number' name='counter' value='0' readonly>");
										} else {
											for (int i = 0; i < cartlist.size(); i++) {
												CartItem item = cartlist.get(i);
												if (product_id == item.getId()) { 
													out.println("<input type='number' name='counter' value='"+item.findQuantity(product_id)+"' readonly> ");
													ifusergetvalue += 1;
													checkingifvaluepassed = true;
										 			break;
												} else if (i == cartlist.size() - 1) {
													out.println("<input type='number' name='counter' value='0' readonly>");
													
												}
											}
										}
									
									
									sess.setAttribute("countering", ifusergetvalue);
									sess.setAttribute("trueorfalse", checkingifvaluepassed);
									
									//sess.removeAttribute("trueorfalse");
									
									%>
									
									<button type="submit" name="btnAction" value="-">
										<i class="fa fa-minus"></i>
									</button>
									
									<!--<input type='hidden' name='mydata' value='0'>-->
								</form>
							</td>
						</tr>
					<%	session.setAttribute("pid",pid);
						session.setAttribute("product_id",product_id);
						session.setAttribute("getStoreId", getStoreId);
					}
					
					// Step 7: Close connection
					conn.close();
				}catch(Exception e){
					out.print("Error" + e);
				}
				%>
			  </tbody>
			</table>
			<div class="pt-2 pb-3">
		<!--<input type="submit" value="Order"> -->
		</div>
		</div>
		
		<script>
			function submitWithoutRefresh(obj) {
				//event.preventDefault();
				
				//	Save Y position of the current page before refresh
				window.addEventListener("beforeunload", function(event) {
					alert(window.scrollY);
					localStorage.setItem("scrollY", window.scrollY);
				})
				
				obj.submit();
			}
		</script>
		<!--  </form> -->
		<%@include file="footer.html"%>
		
	</body>

</html>