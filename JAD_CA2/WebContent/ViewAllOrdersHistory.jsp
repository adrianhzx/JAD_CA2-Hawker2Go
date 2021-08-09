<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="config.*"%>
<%@page import="model.*"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Hawker2Go</title>
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
<%
	ArrayList orderHistoryResult = (ArrayList) request.getAttribute("getOrderHistoryResult");
%>
	
		
	<%@include file="header.jsp"%>

	<div class="container">
		<h1>Your Orders</h1>
	<%
		for (int orderCounter = 0; orderCounter < orderHistoryResult.size(); orderCounter++) {
			OrderHistory uBean = (OrderHistory) orderHistoryResult.get(orderCounter);
		%>
		<div class='row'>
			<div class='col'>
				<h3 class='pt-2 pb-1 stallname important-heading'><%=uBean.getStallName()%></h3>
				<p class='float-right'>
					<strong><%=uBean.getPrice()%></strong>
				</p>
				<p class="pl-2">
					<strong><%=uBean.getQuantity()%>X</strong> &nbsp;
					<%=uBean.getProductName()%></p>
			</div>



		</div>
		<%} %>
		
	</div>

	<%@include file="footer.html"%>
	
</body>
</html>