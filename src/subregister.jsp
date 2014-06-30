<html>

<%@ include file="head.jsp"%>

<%
	// Gets parameters to register via form
		subName = request.getParameter("subName");
		subAddr = request.getParameter("subAddr");
		subCity = request.getParameter("subCity");
		subState = request.getParameter("subState");
		subZip = request.getParameter("subZip");
		subMail = request.getParameter("subMail");
		subLogin = request.getParameter("subLogin");
		subPass = request.getParameter("subPass");
	
	// Prepares statement to add new subscriber
		String subReg = "INSERT INTO subscriber(name, street_address, city, _state, zip, email, login, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement subRegPS = con.prepareStatement(subReg);
		subRegPS.setString(1, subName);
		subRegPS.setString(2, subAddr);
		subRegPS.setString(3, subCity);
		subRegPS.setString(4, subState);
		subRegPS.setString(5, subZip);
		subRegPS.setString(6, subMail);
		subRegPS.setString(7, subLogin);
		subRegPS.setString(8, subPass);
	
	// Checks entered login against database
		String checkLogin = "SELECT login from subscriber WHERE login = ?";
		PreparedStatement checkLoginPS = con.prepareStatement(checkLogin);
		checkLoginPS.setString(1, subLogin);
		ResultSet checkLoginResult = checkLoginPS.executeQuery();
	
	if( subLogin != null ) {
		// Check if any boxes in the form are left blank
			if (subName == null || subName.length() == 0 || subAddr == null || subAddr.length() == 0 || subCity == null || subCity.length() == 0 || 
			subState == null || subState.length() == 0 || subZip == null || subZip.length() == 0 || subMail == null || subMail.length() == 0 || 
			subLogin == null || subLogin.length() == 0 || subPass == null || subPass.length() == 0 ) {
				%><%="<h1><p>Error: Please make sure to fill in all fields!</h1>"%><%
			}
			else if (!checkLoginResult.next()) { // If login is not found in database, register the user
				%><%="<h1><p>Thank you for registering, " + subLogin + "! Please return home and login!</h1>"%><%
				subRegPS.executeUpdate();
				//session.setAttribute("login", subLogin);	
			}
			else { // Print out that the login is not available
				%><%="<h1><p>Login not available, please try again!</h1>"%><%
			}
		}	
	
%>

	<head>
		<title>Healthcare.gov</title>
 
		<link rel="stylesheet" type="text/css" href="style/style.css"/>
	</head>

	<body>
		<div id="main">	

			<h1>Health Exchange Registration (Subscriber)</h1>
			<ul class="navbar2"><li><a href="index.jsp">Home</a></li></ul>
			<h3><p>Logged in as: <%= login %></h3>	
			<div id="signin">
				<h2>Register</h2>

				<form action="subregister.jsp" method="POST">
					Name <br/> <input type="text" name="subName"><br/>
					Address <br/> <input type="text" name="subAddr"><br/>
					City <br/> <input type="text" name="subCity"><br/>
					State <br/> <input type="text" name="subState"><br/>
					Zip <br/> <input type="text" name="subZip"><br/>
					Email <br/> <input type="text" name="subMail"><br/>
					Login <br/> <input type="text" name="subLogin"><br/>
					Password <br/> <input type="password" name="subPass"><br/>
					<br/> <input type="submit" value='Submit'>
				</form>
				
				<br/>
			</div>

		</div>	
	
	</body>
</html>