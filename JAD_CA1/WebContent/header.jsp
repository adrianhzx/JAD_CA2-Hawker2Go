<!-- To be changed to header.jsp once session is applied -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="classes.CartItem" %>
<%@ page import="java.util.*" %>
<%
	//	Get session attributes
	HttpSession sess = request.getSession();
	
	String firstName = (String) sess.getAttribute("fname");
	String lastName = (String) sess.getAttribute("lname"); 
	
	String fullName = firstName + " " + lastName; 
	
	boolean isAdministrator = false;
	
	if (sess.getAttribute("administrator") != null) {
		isAdministrator = (Boolean) sess.getAttribute("administrator");
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
		<% if (firstName == null && lastName == null) { %>
			<a href="login.jsp" class="head-link" id="login">Login</a>
		<% } else {%>
			<div class="dropdown">
				<div class="head-link" id="user"><%=fullName%></div>
				<div class="dropdown-content">
					<form action="Invalidate" method="post">
						<input type="submit" value="Sign Out"/>
					</form>
				</div>
			</div>
		<% } %>
		</li>
		
		<li><a href="OrderSummary.jsp" class="head-link" id="shopping-cart">
			<i class="fa fa-shopping-cart"></i>
			
			
			
			<%if((Integer)sess.getAttribute("countering") == null){ %>
				0
			<%} %>
			<% if((Integer)sess.getAttribute("countering") != null){%>
				<script type="text/javascript">
				//window.onload = function() {
				//	if(!window.location.hash) {
				//		window.location = window.location + '#';
				//		window.location.reload();
				//	}
				//}
				</script>
				<%out.print((Integer)sess.getAttribute("countering"));%>
				<%-- <%out.print((Integer)sess.getAttribute("countering"));%> --%>
						
			<%};%>
			
			
			
		</a></li>
	</ul>
</header>

<!-- First type of refreshing
<script type="text/javascript">
(function(){
	if( window.localStorage ){
		if( !localStorage.getItem('firstLoad') ){
			localStorage['firstLoad'] = true;
			window.location.reload();
		}else{
			localStorage.removeItem('firstLoad');
		}
	}
})();
</script> -->