<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="config.DbConfigs" %>
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
		
		<% 
		String getStoreID = request.getParameter("Storeid"); 
		String gettingImgName = request.getParameter("getImgName");
		Integer User_ID = (Integer)sess.getAttribute("id");
		
		if (!userObj.isAdministrator()) {
			response.sendRedirect("index.jsp");
		}
	
		//session.setAttribute("User_ID", User_ID);
		//out.print(User_ID);
		
		String switchingForms = "";
		String Nametypes = "";
		if(getStoreID != null){
			switchingForms = "EditStall";
			Nametypes = "Modify Stall";
		}else{
			switchingForms = "AddStall";
			Nametypes = "Add Stall";
		}
		
		String blockingcontent = "disabled";
		if(request.getParameter("getImgName") != null){
			blockingcontent = "";
		}
		%>
	
		<div class="container">
			<h1 class="modifyname pt-3 pb-3 text-center"><%=Nametypes %></h1>
		<%
		if(switchingForms.equals("EditStall")){		
			try{
					//Load the JDBC driver
					Class.forName("com.mysql.jdbc.Driver");
					
					//	Make a connection to the database
			        String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			        Connection conn = DriverManager.getConnection(connURL);
			        
			        String userQuery = "SELECT * FROM stall as s,category as c  where s.CuisineCatID = c.CusineCatID and StoreID = '"+getStoreID+"'";
			        PreparedStatement psSelect = conn.prepareStatement(userQuery);
			        
			        ResultSet rs = psSelect.executeQuery();
			        
			        while(rs.next()) {
			        	String stall_name = rs.getString("StallName");
			        	String stall_location = rs.getString("StallLocation");
			        	String stall_img = rs.getString("ImageLocation");
			            String stall_catname = rs.getString("CategoryName");
			            int stall_catid = rs.getInt("CuisineCatID");
			            String stall_description = rs.getString("Description");	
		 %>
			        
			        
					<div class="row w-100 justify-content-center pt-1 pb-1">
						<div class="col-md-4 pt-4">
							<form action="<%=switchingForms %>" method="post">
								<input type="hidden" name="Storeid" value="<%=getStoreID%>">
								<input type="hidden" name="getImgName" value="<%=gettingImgName%>">
							
								<div class="col">
									<div class="pt-2 pb-2">
										<label class="SizingLabel">Stall Name:</label>
										<input  type="text" name="Stall_Name" size="30" value="<%=stall_name %>">
									</div>
									<div class="pt-2 pb-2">
										<label class="SizingLabel">Location:</label>
									 	<input type="text" name="Stall_Location" size="30" value="<%=stall_location %>">
									</div>
									<div class="pt-2 pb-2">
										<label class="SizingLabel">Category:</label><br>
										<select class="input-styling" name="Stall_Cat">
											<% 
												//	Category should be a selection input field
												String selectCategory = "SELECT * FROM Category";
												PreparedStatement psSelectCat = conn.prepareStatement(selectCategory);
												
												ResultSet rsCat = psSelectCat.executeQuery();
												while (rsCat.next()) {
													int id = rsCat.getInt("CusineCatID");
													String category = rsCat.getString("CategoryName");
													
													if (id == stall_catid) { %>
														<option value=<%=id%> selected><%=category%></option>
											<% 		} else { %>
														<option value=<%=id%>><%=category%></option>
											<% 		}
												}
											%>
										</select>
									</div>
									<div class="formfield pt-2 pb-2">
										<label for="textarea">Description:</label>
										<textarea id="textarea" cols="30" rows="5" name="Stall_Description"><%=stall_description %></textarea>
									</div>
									<button class="input-styling" type="submit">Modify</button>
								</div>
							</form>
						</div>
						
						
						<div class="col-md-5">
						<!-- ./images/Food/uploadingfile.jsp -->
							<form class="pt-3 pb-3" action="FileUpload" method="post" enctype="multipart/form-data">
								<p class="pt-3 pb-3">*In order to modify,<br>
								 you have to upload<br>
								 an image.* </p>
								<% 
								String checkingOldImg = (String)session.getAttribute("trueorfalse");
								
								if(checkingOldImg == null){
									if(stall_img != null){
										out.print("<img alt='testing1' src='./images/Food/"+stall_img+"' width='193' height='227'>" + "<br>"+ "Image Name : " + stall_img);
									}
								}
								
														
								if(checkingOldImg != null){	
									
									if(request.getParameter("getImgName") != null){									
										out.print("<img alt='testing1' src='./images/Food/"+request.getParameter("getImgName")+"' width='193' height='227'>" + "<br>"+ "Image Name : " + request.getParameter("getImgName"));
									}
									session.removeAttribute("trueorfalse");
								}
								
								%>
								
								<div class="row pt-3 pb-3">
									<input class="float-right" type="file" name="file"/> 
									<% session.setAttribute("getStoreID", getStoreID); %>
									<input class="float-right" type="submit" value="Upload File"  />
									
								</div>
								
							</form>
						</div>
						
						
						
					</div>
					
					<%  
			        }
		
		
		
					}catch(Exception e){
		        	out.print(e);
		        }
			
		}
		
		%>
		
		<% if(switchingForms.equals("AddStall")){ %>
			
			<div class="row w-100 justify-content-center pt-1 pb-1">
			<div class="col-md-4 pt-4">
				<form action="<%=switchingForms %>" method="post">
					<input type="hidden" name="Storeid" value="<%=getStoreID%>">
					<input type="hidden" name="getImgName" value="<%=gettingImgName%>">
				
					<div class="col">
						<div class="pt-2 pb-2">
							<label class="SizingLabel">Stall Name:</label>
							<input  type="text" name="Stall_Name" size="30" <%=blockingcontent %>>
						</div>
						<div class="pt-2 pb-2">
							<label class="SizingLabel">Location:</label>
						 	<input type="text" name="Stall_Location" size="30" <%=blockingcontent %>>
						</div>
						<div class="pt-2 pb-2">
							<label class="SizingLabel">Category:</label><br>
							<select class="input-styling" name="Stall_Cat" <%=blockingcontent%>>
								<% 
									//	Category should be a selection input field
									//Load the JDBC driver
									Class.forName("com.mysql.jdbc.Driver");
									
									//	Make a connection to the database
							        String connURL ="jdbc:mysql://localhost/"+DbConfigs.db_name+"?user="+DbConfigs.db_user+"&password="+DbConfigs.db_password+"&serverTimezone=UTC";
			      				  	Connection conn = DriverManager.getConnection(connURL);
			      				  	
									String selectCategory = "SELECT * FROM Category";
									PreparedStatement psSelectCat = conn.prepareStatement(selectCategory);
									
									ResultSet rsCat = psSelectCat.executeQuery();
									while (rsCat.next()) {
										int id = rsCat.getInt("CusineCatID");
										String category = rsCat.getString("CategoryName"); %>
											<option value=<%=id%>><%=category%></option>
								<% 		
									}
								%>
							</select>
						</div>
						<div class="formfield pt-2 pb-2">
							<label for="textarea">Description:</label>
							<textarea id="textarea" cols="30" rows="5" name="Stall_Description" <%=blockingcontent %>></textarea>
						</div>
						<button class="input-styling" type="submit" <%=blockingcontent %>>Add Stall</button>
					</div>
				</form>
			</div>
			
			
			<div class="col-md-5">
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
			
		<%}%>
	
	
		</div>
	
	
		<%@include file="footer.html"%>
	</body>
	<script type="text/javascript">
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
	
				reader.onload = function(e) {
					$('#getImg').attr('src', e.target.result).width(193)
							.height(227);
				};
	
				reader.readAsDataURL(input.files[0]);
			}
	
		}
		
	</script>
</html>