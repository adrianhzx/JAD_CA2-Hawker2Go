<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.*" %>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Stall Statistics</title>
		
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
	<body>
		<%@include file="header.jsp"%>
		<h1 class="text-center">Stall Statistics</h1>
		<%
			//String multi = "SELECT * FROM orders AS o, product AS p, stall AS s WHERE s.storeID = p.StoreID AND p.StoreID = ?";
			String base = "SELECT"
			.concat(" ifnull(SUM(o.quantity), 0) 'Total stock',")
			.concat(" ifnull(SUM(o.quantity + (p.Retail_Price - p.Cost_Price)), 0) 'Total Profit',")
			.concat(" ifNull((SELECT sum(o.quantity) FROM hawker2go_jad.orders AS o WHERE CAST(o.ordertime AS DATE) = CURDATE()),0) 'Today stock',")
			.concat(" ifNull((SELECT sum(o.quantity + (p.Retail_Price - p.Cost_Price)) FROM hawker2go_jad.orders AS o WHERE CAST(o.ordertime AS DATE) = CURDATE()),0) 'Today sales'")
			.concat(" FROM hawker2go_jad.product AS p, hawker2go_jad.stall AS s, hawker2go_jad.orders AS o")
			.concat(" WHERE p.StoreID = s.StoreID AND o.productID = p.productID AND o.StoreID = ?");
			
			System.out.println(base);
			
			int today_quantity = 0, total_quantity = 0;
			double total_sales = 0, today_sales = 0;
			
			try {
				// Step1: Load JDBC Driver - TO BE OMITTED for newer drivers
				Class.forName("com.mysql.jdbc.Driver");
	
				// Step 2: Define Connection URL
				String connURL = "jdbc:mysql://localhost/" + DbConfigs.db_name + "?user=" + DbConfigs.db_user + "&password="
				+ DbConfigs.db_password + "&serverTimezone=UTC";
	
				// Step 3: Establish connection to URL
				Connection conn = DriverManager.getConnection(connURL);
				
				System.out.println(base);
				// Step 4: Create Statement object
				PreparedStatement ps = conn.prepareStatement(base);
				ps.setInt(1, Integer.parseInt(request.getParameter("storeID")));
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) {
					total_quantity = rs.getInt(1);
					total_sales = rs.getDouble(2);
					today_quantity = rs.getInt(3);
					today_sales = rs.getDouble(4);
				}
			} catch (Exception e) {
				System.out.println("Exception" + e);
			}
		%>
		<div class="row justify-content-center mb-4">
			<div class="col-2">
				<h1><%=today_quantity%></h1>
				<p>Stock sold today</p>
			</div>
			<div class="col-2">
				<h1><%=total_quantity%></h1>
				<p>Overall stock sold</p>
			</div>
			<div class="col-2">
				<h1><%=String.format("$%.2f",today_sales)%></h1>
				<p>Today's profit</p>
			</div>
			<div class="col-2">
				<h1><%=String.format("$%.2f",total_sales)%></h1>
				<p>Overall profit</p>
			</div>
		</div>
		
		<h3 class="text-center important-heading">Sales Overview for <%=LocalDate.now()%></h3>
		<div class="row justify-content-center">
			<div class="col-10">
				<table class="table">
					<tr>
						<th>&nbsp&nbsp</th>
						<th>Product Name</th>
						<th>Stock sold today</th>
						<th>Today's Profit($)</th>
						<th>Total stock sold</th>
						<th>Total Profit($)</th>
						<th>Stock Left</th>
					</tr>
					<%
						//String multi = "SELECT * FROM orders AS o, product AS p, stall AS s WHERE s.storeID = p.StoreID AND p.StoreID = ?";
						String multi = "SELECT"
						.concat(" p.productName,")
						.concat("ifnull((SELECT SUM(o.quantity) FROM hawker2go_jad.orders AS o WHERE p.ProductID = o.productID AND CAST(o.ordertime AS DATE) = CURDATE()), 0) 'Today quantity',")
						.concat("ifnull((SELECT SUM(o.quantity * (p.Retail_Price - p.Cost_Price)) FROM hawker2go_jad.orders AS o WHERE p.ProductID = o.productID AND CAST(o.ordertime AS DATE) = CURDATE()), 0) 'Today profit',")
						.concat("ifnull((SELECT SUM(o.quantity) FROM hawker2go_jad.orders AS o WHERE p.ProductID = o.productID), 0) 'Total sold',")
						.concat("ifnull((SELECT SUM(o.quantity * (p.Retail_Price - p.Cost_Price)) FROM hawker2go_jad.orders AS o WHERE p.ProductID = o.productID), 0) 'Total profit',")
						.concat("p.AvailableStock 'Stock Left'")
						.concat("FROM orders AS o, product AS p, stall AS s ")
						.concat("WHERE s.StoreID = p.StoreID AND p.storeID = ? GROUP BY p.productName")
						.concat(" ORDER BY 2 DESC;");
						
						System.out.println(multi);
						try {
							// Step1: Load JDBC Driver - TO BE OMITTED for newer drivers
							Class.forName("com.mysql.jdbc.Driver");

							// Step 2: Define Connection URL
							String connURL = "jdbc:mysql://localhost/" + DbConfigs.db_name + "?user=" + DbConfigs.db_user + "&password="
							+ DbConfigs.db_password + "&serverTimezone=UTC";

							// Step 3: Establish connection to URL
							Connection conn = DriverManager.getConnection(connURL);
							
							System.out.println(multi);
							// Step 4: Create Statement object
							PreparedStatement ps = conn.prepareStatement(multi);
							ps.setInt(1, Integer.parseInt(request.getParameter("storeID")));
							ResultSet rs = ps.executeQuery();
							
							int count = 0;
							while(rs.next()) { 
								String[] medals = {"gold","silver","bronze"};
								String others = "";
								
								//	Running out of stock
								if (rs.getInt(6) < 10 && rs.getInt(6) > 0) {
									others += "<i class='ml-3 fa fa-exclamation' data-toggle='tooltip' data-placement='top' title='Stock is running out'></i>";
								}
								
								if (rs.getInt(6) == 0) {
									others += "<i class='ml-3 fa fa-ban' data-toggle='tooltip' data-placement='top' title='No more stock'></i>";
								}
							%>
								<tr>
									<% if (count < medals.length) {%>
										<td><i class="fa fa-certificate <%=medals[count]%>"></i><%=others%></td>
									<% }else{ %>
										<td><%=others%></td>
									<% } %>
									<td><%=rs.getString(1)%></td>
									<td><b class="text-success">+ <%=rs.getInt(2)%></b></td>
									<td><b class="text-success">+ <%=String.format("$%.2f", rs.getDouble(3))%></b></td>
									<td><%=rs.getInt(4)%></td>
									<td><%=String.format("$%.2f",rs.getDouble(5))%></td>
									<td><%=rs.getInt(6)%></td>
								</tr>
						<%  	count++;
							}
							System.out.println("executed");
						} catch (Exception e) {
							System.out.println(e);
							e.printStackTrace();
						}
					%>
					
				</table>
			</div>
		</div>
		
		<!-- Enable tooltip -->
		<script>
		$(document).ready(function(){
		  $('[data-toggle="tooltip"]').tooltip();
		});
		</script>
		<%@include file="footer.html"%>
	</body>
</html>