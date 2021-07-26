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
	</head>
	<body>
	
	
		<%@include file="header.jsp"%>
		
		<div class="container">
			<h2 class="pt-2 pb-2 cart-h2">
				<i class="fa fa-shopping-cart" aria-hidden="true"></i> Your Cart
			</h2>
	
			<%
				String product_name;
				String stall_name;
				double price;
				
				int counter = 0;
		
				double subtotal = 0;
				boolean checkForSubtotal = false;
				
				// ------------>	MODIFIED 
				ArrayList<CartItem> cart = new ArrayList<CartItem>();
				if (sess.getAttribute("cart") != null) {
					cart = (ArrayList<CartItem>) sess.getAttribute("cart");
				}
				
				//	Check if the cart is empty
				if (cart.isEmpty()) { %>
					<div>
						<h3 class='pt-2 pb-1'>Oh no! Looks like your cart is empty. <i class='fa fa-frown-o' aria-hidden='true'></i></h3>
					</div>
					<div class='pt-2 pb-1'>
						<button type='reset' name='button' class='btn btn-danger' id='buttonReturn' value='Return'>Return</button>
					</div>
			<%	} else {
					checkForSubtotal = true;
					for (CartItem item : cart) { 
						subtotal += item.getPrice() * item.getQuantity();
						counter++;
						String formatted_price = String.format("$%.2f", item.getPrice() * item.getQuantity());
			%>
			<% sess.setAttribute("countering", counter); %>
					<div class='row'>
						<div class='col'>
							<h3 class='pt-2 pb-1 stallname'><%=item.getstallName()%></h3>
							<p class='float-right'><strong><%=formatted_price %></strong></p>
							<p><strong><%=item.getQuantity()%> X</strong> &nbsp; <%=item.getproductName() %></p>
						</div>
					</div>
			<%		}	
				}
			%>
	
	
			<% if (checkForSubtotal == true) { %>
				<p style="border-top: 2px solid; padding-top: 2px"></p>
				<div class="row">
					<div class="col">
						<p>
							<strong>Subtotal</strong>
						</p>
					</div>
					<div class="col">
						<p class="float-right">
							<strong><%=String.format("$%.2f", subtotal)%></strong>
						</p>
					</div>
				</div>
				<div class="row">
					<div class="col ">
						<form action="deductionofStocks" method="GET">
							<!-- <input type="hidden" name="mydata" value=""> -->
							<%
								//session.setAttribute("quantity1", quantity1);
								//session.setAttribute("getProductID", getProductID);
							%>
							<input class="float-right btn btn-primary" type="submit"
								value="Check Out" />
						</form>
					</div>
				</div>
			<% } %>
		</div>
	
		<%@include file="footer.html"%>
	</body>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#buttonReturn").click(function() {
				history.go(-1);
			});
		});
	</script>
</html>