<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="config.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Hawker2Go</title>
		<link rel="stylesheet" href="headerfooter_style.css" />
		<link rel="stylesheet" href="main.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	</head>
	<body>
		<%@include file="header.jsp"%>
		<div id="bg-image-index"></div>
		
		<div class="centered width-50">
			<h1>Support Our Hawkers</h1>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
			   sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, 
			   quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		</div>
		
		<div class="centered width-75">
			<h2>What would you like to eat today?</h2>
			<p>Choose a category</p>
			<table id="category-table">
				<tr>
				<form action="ProductSearching" method="post">
					<td>
						<h2 class="category-title">Malay<br>Cuisine</h2>					
									
							<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="Malay Cuisine">	
								<input type="image" src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/>
								<!-- <img src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/> -->
							</button>				
					</td>
					<td>
						<h2 class="category-title">Chinese<br>Cuisine</h2>
						<!-- <a href="productlist-processing.jsp?category=Chinese Cuisine">
							<img src="images/category/catChinese.png" alt="Chinese cuisine" class="category-image"/>
						</a> -->
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="Chinese Cuisine">	
								<input type="image" src="images/category/catChinese.png" alt="Chinese cuisine" class="category-image"/>
								<!-- <img src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/> -->
						</button>		
					</td>
					<td>
						<h2 class="category-title">Indian<br>Cuisine</h2>
						<!-- <a href="productlist-processing.jsp?category=Indian Cuisine">
							<img src="images/category/catIndian.png" alt="Indian cuisine" class="category-image"/>
						</a> -->
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="Indian Cuisine">	
								<input type="image" src="images/category/catIndian.png" alt="Indian cuisine" class="category-image"/>
								<!-- <img src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/> -->
						</button>		
					</td>
				</tr>
				<tr>
					<td>
						<h2 class="category-title">Western<br>Cuisine</h2>
						<!-- <a href="productlist-processing.jsp?category=Western Cuisine">
							<img src="images/category/catWestern.png" alt="Western cuisine" class="category-image"/>
						</a> -->
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="Western Cuisine">	
								<input type="image" src="images/category/catWestern.png" alt="Western cuisine" class="category-image"/>
								<!-- <img src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/> -->
						</button>		
					</td>
					<td>
						<h2 class="category-title">Japanese<br>Cuisine</h2>
						<!-- <a href="productlist-processing.jsp?category=Japanese Cuisine">
							<img src="images/category/catJapanese.png" alt="Japanese cuisine" class="category-image"/>
						</a> -->
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="Japanese Cuisine">	
								<input type="image" src="images/category/catJapanese.png" alt="Japanese cuisine" class="category-image"/>
								<!-- <img src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/> -->
						</button>		
					</td>
					<td>
						<h2 class="category-title">Quick<br>Bites</h2>
						<!-- <a href="productlist-processing.jsp?category=Quick Bites">
							<img src="images/category/catSnacks.png" alt="Quick Snacks" class="category-image"/>
						</a> -->
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="Quick Bites">	
								<input type="image" src="images/category/catSnacks.png" alt="Quick Bites" class="category-image"/>
								<!-- <img src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/> -->
						</button>		
					</td>
					</form>	
				</tr>
			</table>
			<small class="divider">OR</small>
			<p>Search for a specific stall</p>
			<form method="POST" action="ProductSearching">
				<div class="input-icons">
					<i class="fa fa-search icon"></i>
					<input class="input-styling" type="text" placeholder="E.g Beauty World Porridge" style="width: 300px;" name="stall-name"/>
					<input class="input-styling" type="submit" name="search-stall" value="Search" />
				</div>
			</form>
		</div>
		
		<%@include file="footer.html" %>
	</body>
</html>