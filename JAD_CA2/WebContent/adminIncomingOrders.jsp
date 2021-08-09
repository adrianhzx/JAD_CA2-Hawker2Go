<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="config.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Incoming orders</title>
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

	<h1 class="text-center">Incoming orders</h1>

<div class="container">

		<%
		String Stallname;
		String Productname;
		int quantity;
		String address;
		String orderkey;
		String UserName;
		int storeid;
		double subTotal;

		Connection conn = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/" + DbConfigs.db_name + "?user=" + DbConfigs.db_user + "&password="
			+ DbConfigs.db_password + "&serverTimezone=UTC";
			conn = DriverManager.getConnection(connURL);
			PreparedStatement ps = conn.prepareStatement("select s.StallName,p.ProductName, o.quantity, o.address, o.orderkey, concat(m.FirstName,\" \", m.LastName) as name, o.storeID, o.ordertime from stall as s, orders as o,member as m , product as p where s.storeID = o.storeID and o.fk_userID = m.UserID and p.productID = o.productID and s.OwnerID = ?");
			ps.setInt(1, userObj.getUserId());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				double idk = 0;
				Stallname = rs.getString(1);
				Productname = rs.getString(2);
				quantity = rs.getInt(3);
				address = rs.getString(4);
				orderkey = rs.getString(5);
				UserName = rs.getString(6);
				storeid = rs.getInt(7);
		%>


		<section class="order-card px-4 py-2 mb-5 w-75">
			<div class="row">
				<h2 class="pl-4"><%=Stallname%></h2>
			</div>
			<div class="row">
				<div class="col">
					<p class="pl-2">Order From: <%=UserName%></p>
				</div>
				<div class="col">
					<p class="pr-2 text-right"><%=address%></p>
					<p class="pr-2 text-right"><small><%=rs.getTimestamp(8)%></small></p>
				</div>
			</div>
			<hr></hr>
			<%
				
				try {
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection(connURL);
					Statement stmt2 = conn.createStatement();
					ResultSet rs2 = stmt2.executeQuery("SELECT p.ProductName, o.quantity, (o.quantity * p.retail_price) FROM hawker2go_jad.orders AS o, hawker2go_jad.product AS p WHERE p.storeID = o.StoreID AND o.StoreID = "+storeid+" AND o.orderkey = '"+orderkey+"'");
					
					while (rs2.next()) { 
						idk += rs2.getDouble(3);%>
						<div class="row">
							<div class="col-1"><b>X<%=rs2.getInt(2)%></b></div>
							<div class="col-3"><%=rs2.getString(1)%></div>
							<div class="col"><p class="text-right">$<%=rs2.getDouble(3) %></p></div>
						</div>
			<% 		}
					
				} catch (Exception e) {
					System.out.print(e);
				}
			%>
			
			<hr></hr>
			<div class="row">
				<div class="col">
					<p class="pl-2">Subtotal:</p>
				</div>
				
				<div class="col">
					<p class="pr-2 text-right">$<%=idk%></p>
				</div>
			</div>
				<hr></hr>
		</section>


		<%
			}
			conn.close();
		} catch (Exception e) {
			System.out.print(e);
		}
		%>
		
</div>

	<%@include file="footer.html"%>
</body>
</html>