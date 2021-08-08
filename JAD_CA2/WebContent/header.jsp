<!-- To be changed to header.jsp once session is applied -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="classes.CartItem" %>
<%@ page import="model.*" %>
<%@ page import="dao.SqlPaymentInfoQuery" %>
<%@ page import="java.util.*" %>
<%
	//	Get session attributes
	HttpSession sess = request.getSession();
	
	User userObj = (User) sess.getAttribute("user");
	String firstName = "", fullName = "", lastName = "", email = "";
	boolean isAdministrator = false;
	if (userObj != null) {
		firstName = userObj.getUserFName();
		lastName = userObj.getUserLName();
		fullName = firstName + " " + lastName; 
		isAdministrator = userObj.isAdministrator();
		email = userObj.getUserEmail();
	}
	
	//	User payment information
	UserPaymentDetails pay_details = null;
	if (userObj != null && !userObj.isAdministrator()) {
		SqlPaymentInfoQuery payQuery = new SqlPaymentInfoQuery();
		pay_details = payQuery.getPaymentMethod(userObj.getUserId());
	}
	
	ArrayList<CartItem> cart = new ArrayList<CartItem>();
	
	if (sess.getAttribute("cart") != null) {
		cart = (ArrayList<CartItem>) sess.getAttribute("cart");
	}
%>
<header>
	<a href="index.jsp">
		<img src="images/logo.png" alt="logo" />
	</a>
	<ul id="head-link-container">
		<li><a href="Product" class="head-link">Products</a></li>
		<li><a href="#" class="head-link">About</a></li>
		
		<% if (isAdministrator) { %>
		<li>
			<a href="admin.jsp" class="head-link">Admin Options</a>
		</li>
		<% } %>
		
		<li>
		<% if (firstName.equals("") && lastName.equals("")) { %>
			<a href="login.jsp" class="head-link" id="login">Login</a>
		<% } else {%>
			<div class="dropdown">
				<div class="head-link" id="user"><%=fullName%></div>
				<div class="dropdown-content">
					<button onclick="window.location.href = 'userInfo.jsp'">Your Info</button>
					<form action="Invalidate" method="post">
						<input type="submit" value="Sign Out"/>
					</form>
				</div>
			</div>
		<% } %>
		</li>
		
		<% if (userObj != null && userObj.isAdministrator()) {%>
			<li>
				<a href="adminIncomingOrders.jsp" class="head-link" id="shopping-cart">
					<i class="fa fa-cart-arrow-down"></i>
					0
				</a>
			</li>
		<% } else { %>
			<li>
				<a href="OrderSummary.jsp" class="head-link" id="shopping-cart">
					<i class="fa fa-shopping-cart"></i>
					<%if(cart == null || cart.isEmpty()){ %>
						0
					<%} else { %>
						<%out.print(cart.size());%>
					<%};%>
				</a>
			</li>
		<% } %>
		
	</ul>
</header>
