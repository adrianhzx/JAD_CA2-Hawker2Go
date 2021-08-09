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
	ArrayList orderHistoryKeyResult = (ArrayList) request.getAttribute("getOrderHistoryKeyResult");
%>
	
	
		
		
	<%@include file="header.jsp"%>

	<div class="container">
		<h1>Order History</h1>
	<%
		for (int orderCounter = 0; orderCounter < orderHistoryKeyResult.size(); orderCounter++) {
			OrderHistoryKey uBean = (OrderHistoryKey) orderHistoryKeyResult.get(orderCounter);
		%>
		<div class="border border-primary">
			<p>Receipt: <%=uBean.getOrderkey() %></p>
			<p>Date: <%=uBean.getDate() %></p>
			<p>Time: <%=uBean.getTime() %></p>
		
			<form action="OrderHistory" method="get" >
				<input type="hidden" value="<%=uBean.getOrderkey() %>" name="getKey"/>
				<button type="submit">View More</button>
	
			</form>
			
		</div>
		<%} %>
		<!-- <div>
			<h1>Curry Rice</h1>
		</div> -->
	</div>

	<%@include file="footer.html"%>
	
</body>
</html>