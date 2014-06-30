<html>

<%@ include file="head.jsp"%>

	<head>
		<title>Healthcare.gov</title>
 
		<link rel="stylesheet" type="text/css" href="style/style.css"/>
	</head>

	<body>
		<div id="main">	

			<h1>Health Exchange (Add Plan)</h1>
			<ul class="navbar2"><li><a href="index.jsp">Home</a></li></ul>
			<h3><p>Logged in as: <%= login %>
			<div id="signin">
				<h2>Add Plan</h2>

				<form action="addplanhead.jsp" method="POST">
					Plan Name <br/> <input type="text" name="planname"><br/>
					Condition <br/> <input type="text" name="condition"><br/>
					Price <br/> <input type="text" name="price"><br/>
					Deductible <br/> <input type="text" name="deductible"><br/>
					Discount <br/> <input type="text" name="discount"><br/>
					Months <br/> <input type="text" name="months"><br/>
					<br/> <input type="submit" value='Submit'>
				</form>
				
				<br/>
			</div>

		</div>
	</body>
</html>