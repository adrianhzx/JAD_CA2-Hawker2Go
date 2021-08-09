<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>User Information</title>
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
		<% if (userObj == null) {
			response.sendRedirect("index.jsp");
		} %>
		<%
			String status = request.getParameter("message");
			System.out.println(status);
			String message = "";
			if (request.getParameter("message") != null) {
				if (status.equals("success")) { %>
					<div class="centered width-50">
						<div class="success-message">
							<i class = "fa fa-info-circle"></i>
							<b>Information updated successfully</b>
						</div>
					</div>
		<%		} else { %>
					<div class="centered width-50">
						<div class="error-message">
							<i class = "fa fa-exclamation-triangle"></i>
							<b>Information cannot be updated</b>
						</div>
					</div>
		<%		}
			}
		%>
		<form action="updateUserProfile" method="POST">
			<h1 class="text-center">User Info</h1>
			<h3 class="mx-3 p-0 important-heading">User Particulars</h3>
			<hr class="mx-3"></hr>
			<div class="row justify-content-center mb-2">
				<div class="col-3">
					<h4><label for="lbl-fName">First Name</label></h4>
					<div id="fName-field">
						<input type="text" id="lbl-fName" name="fName" class="input-styling w-75" value=<%=firstName %> onblur="unfocusInput(this)" readonly>
						<button style="visibility: hidden" onclick="editInput(this)" ><i class="fa fa-edit p-2" style="visibility: visible"></i></button>
					</div>
				</div>
				<div class="col-3">
					<h4><label for="lbl-lName">Last Name</label></h4>
					<div id="lName-field">
						<input type="text" id="lbl-lName" name="lName" class="input-styling w-75" value=<%=lastName %> onblur="unfocusInput(this)" readonly>
						<button style="visibility: hidden" onclick="editInput(this)" >><i class="fa fa-edit p-2" style="visibility: visible"></i></button>
					</div>
				</div>
			</div>
			<div class="row justify-content-center mb-2">
				<div class="col-6">
					<h4><label for="lbl-email">Email Address</label></h4>
					<div class="field">
						<input id="lbl-email" class="input-styling w-75" value=<%=email%> readonly>
					</div>
				</div>
			</div>
			<div class="row justify-content-center mb-2">
				<div class="col-6">
					<h4><label for="lbl-email">Role</label></h4>
					<div class="field">
						<p><%=(userObj.isAdministrator()) ? "Administrator" : "User"%></p>
					</div>
				</div>
			</div>
			<% if (!userObj.isAdministrator()) { %>
				<h3 class="mx-3 p-0 important-heading">Payment Method</h3>
				<hr class="mx-3"></hr>
				<h4 class="text-center font-weight-bold mb-3">You can choose to pay using one of the following payment methods. The default method is by Cash</h4>
				<div class="row justify-content-center mb-2">
					<div class="col-6">
						<h4>Preferred Payment Method</h4>
						<div class="row mb-3">
							<% 
							String[] options = {"Cash", "VISA/Mastercard", "NETS", "NETS Flashpay"};
							String[] icon_classes = {"fa fa-money text-success", "fa fa-credit-card text-warning","fa fa-credit-card text-danger", "fa fa-credit-card text-primary"};
							for (int i = 1; i <= 4; i++) { 
								if (i == pay_details.getMethodID()) { %>
									<div class="col">
										<input type="radio" name="inp-payment" value="<%=i%>" onclick="radioButtonCheck(this.value)" checked><i class="<%=icon_classes[i-1] %> pl-2"></i><%=options[i-1] %>
									</div>
							<%	} else { %>
									<div class="col">
										<input type="radio" name="inp-payment" value="<%=i%>" onclick="radioButtonCheck(this.value)"><i class="<%=icon_classes[i-1] %> pl-2"></i><%=options[i-1] %>
									</div>
							<%  } %>	
							<%} %>
						</div>
					</div>
				</div>
				<div class="row mb-3 justify-content-center">
					<div class="col-6">
						<h4><label for="cc-number">Credit card number (first 8 digits)</label></h4>
						<% if (pay_details.getMethodID() != 0) { %>
							<input type="number" name="cc-no" placeholder="Credit Card Number" value="<%=pay_details.getCvc() %>" id="cc-number" class="input-styling" pattern="^[0-9]{8}$" />
						<% } else { %>
							<input type="number" name="cc-no" placeholder="Credit Card Number" id="cc-number" class="input-styling" pattern="^[0-9]{8}$" disabled/>
						<% } %>
					</div>
				</div>
			<% } %>
			
			<div class="row p-5 justify-content-center">
				<button type="submit" class="page-button">Update Changes</button>
			</div>
		</form>
		
		
		<script>
			function radioButtonCheck(value) {
				console.log("value: " + value);
				if (parseInt(value) == 1) {
					document.getElementById("cc-number").disabled = true;
					document.getElementById("cc-number").value = "";
				} else {
					document.getElementById("cc-number").disabled = false;
				}
			}
			
			function editInput(obj) {
				var objID = obj.id;
				var parent = obj.parentElement;
				var inputField = document.getElementById(parent.id).children[0];
				var button = document.getElementById(parent.id).children[1];
				inputField.removeAttribute("readonly")
				inputField.classList = "input-styling w-100";
				inputField.classList.add("focused");
				
				parent.removeChild(button);
			}
			
			function unfocusInput(obj) {
				var saved_value = obj.value;
				var parent = obj.parentElement;
				var inputElement = document.getElementById(parent.id).children[0];
				inputElement.readOnly = true;
				inputElement.classList = "input-styling w-75";
				inputElement.value = saved_value;
				
				document.getElementById(parent.id).insertAdjacentHTML("beforeend","<button style='visibility: hidden' onclick='editInput(this)'><i class='fa fa-edit p-2' style='visibility: visible'></i></button>" ) 
			}
		</script>
		
		<%@include file="footer.html" %>
	</body>
</html>