<%@ page import="java.sql.*" %>
<%@ page import="config.DbConfigs" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List of Products</title>
<link rel="stylesheet" href="headerfooter_style.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- bootstrap 4.5 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</head>



<body>
	<%@include file="header.jsp"%>
	<!-- Search bar with buttons p-4 pt-5" -->
	<div class="container">
	
<% 

String getUserSessionName = "";
getUserSessionName = (String)session.getAttribute("fname");
out.print(getUserSessionName);

%>

<!-- productlist-processing.jsp -->
	<form action="productlist-processing.jsp" method="post">
	<div class="row p-4 pt-5">
		
		<div class="col-md-4">
			<div class="input-group rounded">
				<input type="search" class="form-control rounded"
					placeholder="Search" aria-label="Search"
					aria-describedby="search-addon" name="SearchProcessing"/>
			</div>
		</div>
		<div class="col-md-4">
			<div class="dropdown">
				<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"> Type of Cuisine <span class="caret"></span>
				</button>
				<ul class="dropdown-menu p-2">
					<%


String Category_Name;
int Category_cusineCatID;


try{
	
	// Step1: Load JDBC Driver - TO BE OMITTED for newer drivers
	Class.forName("com.mysql.jdbc.Driver"); 
	
	// Step 2: Define Connection URL
	String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
	
	// Step 3: Establish connection to URL
	Connection conn = DriverManager.getConnection(connURL);
	
	// Step 4: Create Statement object
	Statement stmt = conn.createStatement();
	
	// Step 5: Execute SQL Command
	String sqlStr = "select * from category";
	ResultSet rs = stmt.executeQuery(sqlStr);
	
	// Step 6: Process Result
	while(rs.next()){
		Category_Name = rs.getString("CategoryName");
		Category_cusineCatID = rs.getInt("CusineCatID");
		
		%>
		<div class='radio'>
			<label><input type='radio' value='<%=Category_cusineCatID %>' name='optradio'><%=Category_Name %></label>
		</div>
		<%
	}
	
	// Step 7: Close connection
	conn.close();
	
}catch(Exception e){
	out.print("Error" + e);
}

%>
				</ul>
			</div>
		</div>
		<div class="ml-auto">
			<button type="submit" class="btn btn-primary">Search</button>
		</div>
		
	</div>
	</form>
	</div>

	<!-- name of head -->
	<h2 class="d-flex justify-content-center">Products</h2>
	
	<!-- testing layout of img first -->
	
	<div class="container-xl">
		<div class="row p-4">
			<% // getting results for all

String stall_category_name;
String stall_location;
String stall_name;
String stall_img;
int stall_storeid;

try{
	
	// Step1: Load JDBC Driver - TO BE OMITTED for newer drivers
	Class.forName("com.mysql.jdbc.Driver"); 
	
	// Step 2: Define Connection URL
	String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
	
	// Step 3: Establish connection to URL
	Connection conn = DriverManager.getConnection(connURL);
	
	// Step 4: Create Statement object
	Statement stmt = conn.createStatement();
	
	// Step 5: Execute SQL Command
	String sqlStr = "select * from stall as s, category as c where s.CuisineCatID = c.CusineCatID";
	ResultSet rs = stmt.executeQuery(sqlStr);
	
	// Step 6: Process Result
	while(rs.next()){
		stall_category_name = rs.getString("CategoryName");
		stall_location = rs.getString("StallLocation");
		stall_name = rs.getString("StallName");
		stall_img = rs.getString("ImageLocation");
		stall_storeid = rs.getInt("StoreID");
		if(getUserSessionName != null){
			%>
			<div class='col-md-4'>
				<img alt='testing1' src='./images/Food/<%=stall_img%>'
					width='288' height='369'>
				<h3 class='Product-Category-name'><%=stall_category_name%></h3>
				<p class='Product-Location-name'>
					<i class='fa fa-map-marker' aria-hidden='true'></i><%=stall_location%></p>
				<h3 class='Product-name'><%=stall_name%></h3>
				<div class='float-right pr-5 pt-3 pb-3'>
					<a href='selectOrder.jsp?StoreID=<%=stall_storeid%>'
						class='btn btn-danger' role='button'>More Info</a>
				</div>
			</div>
			<%
		}else{
			%>
			<div class='col-md-4'>
				<img alt='testing1' src='./images/Food/<%=stall_img%>'
					width='288' height='369'>
				<h3 class='Product-Category-name'><%=stall_category_name%></h3>
				<p class='Product-Location-name'>
					<i class='fa fa-map-marker' aria-hidden='true'></i><%=stall_location%></p>
				<h3 class='Product-name'><%=stall_name%></h3>
				<div class='float-right pr-5 pt-3 pb-3'>
					<button type='button' class='btn btn-primary' data-toggle='modal'
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
				</div>
			</div>
			<%
		};
		
	}
	
	// Step 7: Close connection
	conn.close();
	
}catch(Exception e){
	out.print("Error" + e);
}

%>
	
		</div>
	</div>
	<%@include file="footer.html"%>
</body>
<script type="text/javascript">
/* $('#myModal').on('shown.bs.modal', function () {
	  $('#myInput').trigger('focus')
	}) */
	$("#getModal").modal('show');
</script>

</html>

