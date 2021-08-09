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
		ArrayList orderResult = (ArrayList) request.getAttribute("getOrderResult");
	//System.out.print(orderResult);
	
	//if (orderResult.isEmpty()) {
		//System.out.print("WHAT ARE U DOING HERE!!");
		//out.println("<script type=\"text/javascript\">");
		//out.println("alert('Your order has arrived!')");
		//out.println("location='index.jsp';");
		//out.println("</script>");
		//request.getRequestDispatcher("index.jsp").forward(request, response);
	//}
	%>
	<%@include file="header.jsp"%>

	<div class="container pt-3 pd-3">
		<div>
			<h1>Your orders has been placed!</h1>
		</div>

		<%
			for (int orderCounter = 0; orderCounter < orderResult.size(); orderCounter++) {
			OrderFinish uBean = (OrderFinish) orderResult.get(orderCounter);
		%>
		<div class='row'>

			<div class='col'>

				<h3 class='pt-2 pb-1 stallname important-heading'><%=uBean.getStallname()%></h3>
				<p class='float-right'>
					<strong><%=uBean.getPrice()%></strong>
				</p>
				<p class="pl-2">
					<strong><%=uBean.getQuantity()%>X</strong> &nbsp;
					<%=uBean.getProductName()%></p>
			</div>

		</div>
		<%
			}
		%>
		<div class="d-flex justify-content-end" >
		<a href="index.jsp" class="btn btn-primary p-1 m-1">HOMEPAGE</a>
		<a href="OrderHistoryKey" class="btn btn-primary p-1 m-1">Order History</a>
		</div>
		<!-- <div id="countdown"></div> -->
	</div>
	

	<%@include file="footer.html"%>
	
	<!-- <script type="text/javascript">
		var timeleft = 30;
		var downloadTimer = setInterval(function() {
			if (timeleft <= 0) {
				clearInterval(downloadTimer);
				document.getElementById("countdown").innerHTML = "Finished";
				location.reload();
			} else {
				document.getElementById("countdown").innerHTML = timeleft
						+ " seconds remaining";
			}
			timeleft -= 1;
		}, 1000);	
	</script> -->
</body>
</html>