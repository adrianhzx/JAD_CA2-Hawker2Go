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
		
		<!-- bootstrap 4.5 -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
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
					<td class="pb-3">
						<form action="ProductSearching" method="post">
						<h2 class="category-title">Malay<br>Cuisine</h2>
							<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="1">	
								<input type="image" src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/>
							</button>	
						</form>
						<!-- <h2 class="category-title">Malay<br>Cuisine</h2>
						<a href="productlist-processing.jsp?category=1">
							<img src="images/category/catMalay.png" alt="Malay cuisine" class="category-image"/>
						</a> -->
					</td>
					<td class="pb-3">
						<form action="ProductSearching" method="post">
						<h2 class="category-title">Chinese<br>Cuisine</h2>
							<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="2">	
								<input type="image" src="images/category/catChinese.png" alt="Chinese cuisine" class="category-image"/>
						</button>	
						</form>
						<!-- <h2 class="category-title">Chinese<br>Cuisine</h2>
						<a href="productlist-processing.jsp?category=2">
							<img src="images/category/catChinese.png" alt="Chinese cuisine" class="category-image"/>
						</a> -->
					</td>
					<td class="pb-3">
						<form action="ProductSearching" method="post">
						<h2 class="category-title">Indian<br>Cuisine</h2>
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="3">	
								<input type="image" src="images/category/catIndian.png" alt="Indian cuisine" class="category-image"/>
						</button>
						</form>
						<!-- <h2 class="category-title">Indian<br>Cuisine</h2>
						<a href="productlist-processing.jsp?category=3">
							<img src="images/category/catIndian.png" alt="Indian cuisine" class="category-image"/>
						</a> -->
					</td>
				</tr>
				<tr>
					<td class="pb-3">
						<form action="ProductSearching" method="post">
						<h2 class="category-title">Western<br>Cuisine</h2>
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="4">	
								<input type="image" src="images/category/catWestern.png" alt="Western cuisine" class="category-image"/>
						</button>	
						</form>
						<!-- <h2 class="category-title">Western<br>Cuisine</h2>
						<a href="productlist-processing.jsp?category=4">
							<img src="images/category/catWestern.png" alt="Western cuisine" class="category-image"/>
						</a> -->
					</td>
					<td class="pb-3">
						<form action="ProductSearching" method="post">
						<h2 class="category-title">Japanese<br>Cuisine</h2>
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="5">	
								<input type="image" src="images/category/catJapanese.png" alt="Japanese cuisine" class="category-image"/>
						</button>
						<form action="ProductSearching" method="post">
						<!-- <h2 class="category-title">Japanese<br>Cuisine</h2>
						<a href="productlist-processing.jsp?category=5">
							<img src="images/category/catJapanese.png" alt="Japanese cuisine" class="category-image"/>
						</a> -->
					</td>
					<td class="pb-3">
						<form action="ProductSearching" method="post">
						<h2 class="category-title">Quick<br>Bites</h2>
						<button type="submit" style="border: solid 0px #000000; background-color: white;" name="category" value="6">	
								<input type="image" src="images/category/catSnacks.png" alt="Quick Bites" class="category-image"/>
						</button>	
						</form>
						<!-- <h2 class="category-title">Quick<br>Bites</h2>
						<a href="productlist-processing.jsp?category=6">
							<img src="images/category/catSnacks.png" alt="Quick Snacks" class="category-image"/>
						</a> -->
					</td>
				</tr>
			</table>
			<small class="divider">OR</small>
			<p>Search for a specific stall</p>
			<form method="POST" action="ProductSearching">
				<div class="input-icons">
					<i class="fa fa-search icon"></i>
					<input class="input-styling" type="text" placeholder="E.g Beauty World Porridge" style="width: 300px;" name="name"/>
					<input class="input-styling" type="submit" name="search-stall" value="Search" />
				</div>
			</form>
		</div>
		
		<%@include file="footer.html" %>
	</body>
</html>