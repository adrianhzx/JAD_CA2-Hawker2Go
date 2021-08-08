<%@page import="model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="config.DbConfigs"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>List of Products</title>
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
			String getUserSessionName = "";
		getUserSessionName = (String) session.getAttribute("fname");
		//out.print(getUserSessionName);
		%>

		<%
			ArrayList catResult = (ArrayList) request.getAttribute("getallCat");
		%>
		<%
			
			ArrayList getsearchandidResult = (ArrayList) request.getAttribute("Findallwithsearchandcatid");
		%>
		<%
			
			String GetSearch = (String) request.getAttribute("GetSearch");
		%>
			<%
			
			Integer GetCatId = (Integer) request.getAttribute("GetCatId");
		%>
	
		<%@include file="header.jsp"%>
		<!-- Search bar with buttons p-4 pt-5" -->
		<div class="container">
			<div class="row ml-2 mt-5 mr-5 mb-3">
				<div class="col">
					<form action="ProductSearching" method="post">
						<input class="input-styling" type="text" placeholder="E.g Beauty World Porridge" style="width: 300px;" name="name" value="<%=GetSearch%>"/>
						<select class="input-styling" name="category">
							<option value='0'>All</option>
							<%
								for (int catCounter = 0; catCounter < catResult.size(); catCounter++) {
								ProductSearch uBean = (ProductSearch) catResult.get(catCounter);
								if(uBean.getCategoryId() == GetCatId){
							%>
							<option value="<%=uBean.getCategoryId()%>" selected><%=uBean.getCategoryName()%></option>
							<%
								} else {
							%>
							<option value="<%=uBean.getCategoryId()%>"><%=uBean.getCategoryName()%></option>
							<%
								}
							%>
							<%
								}
							%>
						</select>
						<button type="submit" class="input-styling float-right">Search</button>
					</form>
				</div>
			</div>
		</div>
	
		<!-- name of head -->
		<h1 class="d-flex justify-content-center">Products</h1>
	
		<div class="container-xl">
			<div class="row p-4">
				<%
				for (int productCounter = 0; productCounter < getsearchandidResult.size(); productCounter++) {
				FindProduct uBean = (FindProduct) getsearchandidResult.get(productCounter);
			%>
				<div class='col-md-4'>
					<img alt='testing1' src='./images/Food/<%=uBean.getStall_img()%>' width='288'
						height='369'>
					<h3 class="important-heading"><%=uBean.getCategory_name().toUpperCase()%></h3>
					<p class='m-0 pl-1 text-secondary'>
						<i class='fa fa-map-marker' aria-hidden='true'></i><%=uBean.getStall_location()%></p>
					<h2 class="font-weight-normal text-dark"><%=uBean.getStall_name()%></h2>
					<div class='float-right pr-5 pt-3 pb-3'>
						<%
				if (getUserSessionName == null) { 
			%>
						<button type='button' class='page-button' data-toggle='modal'
							data-target='#exampleModal'>More Info</button>
						<div class='modal fade' id='exampleModal' tabindex='-1'
							role='dialog' aria-labelledby='exampleModalLabel'
							aria-hidden='true'>
							<div class='modal-dialog' role='document'>
								<div class='modal-content'>
									<div class='modal-header'>
										<h5 class='modal-title' id='exampleModalLabel'>Have you
											created an account?</h5>
										<button type='button' class='close' data-dismiss='modal'
											aria-label='Close'>
											<span aria-hidden='true'>&times;</span>
										</button>
									</div>
									<div class='modal-body'>Hi there! In order to buy foods,
										please sign up an account with us. If you're an existing user,
										please log in to your account.</div>
									<div class='modal-footer'>
										<button type='button' class='btn btn-secondary'
											data-dismiss='modal'>Close</button>
										<a href='login.jsp' role='button' class='btn btn-primary'>SignUp/Login</a>
									</div>
								</div>
							</div>
						</div>
						<%	} else { %>
						<button type='button' class='page-button' data-toggle='modal'
							data-target='#exampleModal'
							onclick="window.location.href='selectOrder.jsp?StoreID=<%=uBean.getStall_storeid()%>';">More
							Info</button>
						<%  } %>
					</div>
				</div>
				
			<%
				}
			%>
			
	
			</div>
		</div>

		<%@include file="footer.html"%>
	</body>
	<script type="text/javascript">
		$(document).ready(
				function() {
					$("#myInput").on(
							"keyup",
							function() {
								var value = $(this).val().toLowerCase();
								$(".dropdown-menu li").filter(
										function() {
											$(this).toggle(
													$(this).text().toLowerCase()
															.indexOf(value) > -1)
										});
							});
				});
	</script>
</html>