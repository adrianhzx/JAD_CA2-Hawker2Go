<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
	<% String getStoreID = request.getParameter("Storeid"); 
	String gettingImgName = request.getParameter("getImgName");
	
	Integer User_ID = (Integer)sess.getAttribute("id");

	boolean checkingadmin = (boolean)sess.getAttribute("administrator");

	if(checkingadmin == false){
		response.sendRedirect("index.jsp");
	}

	//session.setAttribute("User_ID", User_ID);
	//out.print(User_ID);
	
	String switchingForms = "";
	if(getStoreID != null){
		switchingForms = "EditStall";
	}else{
		switchingForms = "AddStall";
	}
	
	String blockingcontent = "disabled";
	if(request.getParameter("getImgName") != null){
		blockingcontent = "";
	}
	%>

	<div class="container">
	
				<div class="row justify-content-center pt-1 pb-1">
				
					
					
						<div class="col-auto">
						<form action="<%=switchingForms %>" method="post">
						<input type="hidden" name="Storeid" value="<%=getStoreID%>">
						<input type="hidden" name="getImgName" value="<%=gettingImgName%>">
						<h3 class="pt-3 pb-3">Modify Stall</h3>
							<div class="pt-2 pb-2">
								<label class="SizingLabel">Stall Name:</label>
								
					
								<input  type="text" name="Stall_Name" size="30" <%=blockingcontent %>>
							
							</div>
							<div class="pt-2 pb-2">
								<label class="SizingLabel">Location:</label>
							 	<input type="text" name="Stall_Location" size="30" <%=blockingcontent %>>
							</div>
							<div class="pt-2 pb-2">
								<label class="SizingLabel">Category:</label>
								<input type="text" name="Stall_Cat" size="30" <%=blockingcontent %>>
							</div>
							<div class="formfield pt-2 pb-2">
								<label for="textarea">Description:</label>
								<textarea id="textarea" cols="30" rows="5" name="Stall_Description" <%=blockingcontent %>></textarea>
							</div>
							<button type="submit" <%=blockingcontent %>>Modify</button>
							</form>
						</div>
		
					<div class="col-auto">
					<!-- ./images/Food/uploadingfile.jsp -->
						<form class="pt-3 pb-3" action="FileUpload" method="post" enctype="multipart/form-data">
							<p class="pt-3 pb-3">*In order to modify,<br>
							 you have to upload<br>
							 an image.* </p>
							<% if(request.getParameter("getImgName") != null){
								
								out.print("<img alt='testing1' src='./images/Food/"+request.getParameter("getImgName")+"' width='193' height='227'>" + "<br>"+ "Image Name : " + request.getParameter("getImgName"));
							}%>
							
							<div class="row pt-3 pb-3">
								<input class="float-right" type="file" name="file"/> 
								<% session.setAttribute("getStoreID", getStoreID); %>
								<input class="float-right" type="submit" value="Upload File"  />
								
							</div>
							
						</form>
					</div>
					
				</div>


	</div>


	<%@include file="footer.html"%>
</body>

</html>