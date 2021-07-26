<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Login/Sign Up</title>
		<style>	
			<%@include file="headerfooter_style.css" %>
			<%@include file="main.css" %>
		</style>
		<!--  <link rel="stylesheet" href="headerfooter_style.css" /> -->
		<link rel="stylesheet" href="main.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
							<input class="input-styling bottom-border" type="text" placeholder="First Name" name="fname" required/>    
							<input class="input-styling bottom-border" type="text" placeholder="Last Name" name="lname" required/><br><br>
							
							<i class="fa fa-envelope icon"></i>
							<input class="input-styling bottom-border" type="text" placeholder="Email" name="email" style="width:75%" required/><br><br>
							<i class="fa fa-lock icon"></i>
							<input class="input-styling bottom-border" type="password" placeholder="Password" name="password" style="width:75%" required/><br><br>
							<i class="fa fa-lock icon"></i>
							<input class="input-styling bottom-border" type="password" placeholder="Confirm Password" name="password-cfm" style="width:75%" required/><br><br>
							
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