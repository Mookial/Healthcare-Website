<html>

<!-- Includes clientProperties & parameter variables -->
<%@ include file="head.jsp"%>
<!----------------------------------------------------->

<%

	if (login == null || login.length() == 0 || loginType == null || loginType.length() == 0) {
		login = (String) session.getAttribute("login");
		password = (String) session.getAttribute("password");
		loginType = (String) session.getAttribute("loginType");
		if (login == null) login = null;
		if (loginType == null) loginType = null;
		if (password == null) password = null;
	}
	
	session.setAttribute("login", login);
	session.setAttribute("loginType", loginType);

%>

<head>
   <title>Healthcare.gov</title>
 
	<link rel="stylesheet" type="text/css" href="style/style.css"/> 
</head>

<body>

	<div id="main">

		<h1>Health Exchange</h1>
		<ul class="navbar"> 
		<li><a href="subregister.jsp">Subscriber Registration</a> | </li> 
		<li><a href="comregister.jsp">Company Registration</a> | </li> 
		<li><a href="offerings.jsp">Current Offerings / Subscribe</a> | </li> 
		<li><a href="addplan.jsp">Add Plan</a> | </li> 
		<li><a href="myinfo.jsp">My Info</a></li> 
		</ul>
		
		<div id="signin">
			<h2>Sign-in</h2>

			<form action="login.jsp" method="POST">
				<input type="radio" name="loginType" value="Company" checked='checked' Autocomplete="off">Company  
				<input type="radio" name="loginType" value="Subscriber" Autocomplete="off">Subscriber<br>
				Login: <br/> <input type="text" name="login"><br/>
				Password: <br/> <input type="password" name="password"><br/>
				<br/> <input type="submit" value='Sign-in'>
			</form>
			
			<br/>
		</div>
	
			<h3><p>Logged in as: <%= login %>
			<p>Login type: <%= loginType %> </li></h3>

	</div>

</body>
</html>
