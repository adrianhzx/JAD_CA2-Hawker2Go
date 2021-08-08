<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Login/Sign Up</title>
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
		<div id="bg-image-login"></div>
		
		<%	
			String errName = request.getParameter("message");
			String message = "";
			if (errName != null) {
				//	Find the name of the error
				switch(errName) {
					case "invalidResponse": message = "Invalid login details. The email or password could be incorrect."; break;
					case "pwdMismatch": message = "Passwords do not match"; break;
					case "userExists": message = "This account already exists. Try creating an account using a different email"; break;
				}%>
				<div class="centered width-50">
					<div class="error-message">
						<i class = "fa fa-exclamation-triangle"></i>
						<b><%=message%></b>
					</div>
				</div>
		<%	}
		%>
		<div id="login-container">
			<section>
				<div class="centered width-75">
					<p><small>Don't have an account, sign up today</small></p><br>
					<form action="RegisterUser" method="POST">
						<div class="input-icons">
							<i class="fa fa-user icon"></i>
							<input class="input-styling bottom-border" type="text" placeholder="First Name" name="fname" style="width:40%" required/>    
							<input class="input-styling bottom-border" type="text" placeholder="Last Name" name="lname" style="width:40%" required/><br><br>
							
							<i class="fa fa-envelope icon"></i>
							<input class="input-styling bottom-border" type="text" placeholder="Email" name="email" style="width:85%" required/><br><br>
							<i class="fa fa-lock icon"></i>
							<input class="input-styling bottom-border" type="password" placeholder="Password" name="password" style="width:85%" required/><br><br>
							<i class="fa fa-lock icon"></i>
							<input class="input-styling bottom-border" type="password" placeholder="Confirm Password" name="password-cfm" style="width:85%" required/><br><br>
							
							<input class="input-styling" type="submit" name="register" value="Sign Up" />
						</div>
					</form>
				</div>
			</section>
			<div class="vl"></div>
			<section>
				<div class="centered width-75">
					<p><small>Have an account?</small></p><br>
					<form action="VerifyUser" method="POST">
						<div class="input-icons">
							<i class="fa fa-envelope icon"></i>
							<input class="input-styling bottom-border" type="text" placeholder="Email" name="email" style="width:75%" required/><br><br>
							<i class="fa fa-lock icon"></i>
							<input class="input-styling bottom-border" type="password" placeholder="Password" name="password" style="width:75%" required/><br><br>
							
							<p><small style="color: #bb0959;">Forgot your password</small></p><br>
							<input class="input-styling" type="submit" name="login" value="Log In" />
						</div>
					</form>
				</div>
			</section>
		</div>
		
		<%@include file="footer.html" %>
	</body>
</html>