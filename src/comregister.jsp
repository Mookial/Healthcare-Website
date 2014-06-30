<html>

<%@ include file="head.jsp"%>

<%
	// Gets parameters to register via form
		comName = request.getParameter("comName");
		comAddr = request.getParameter("comAddr");
		comCity = request.getParameter("comCity");
		comState = request.getParameter("comState");
		comZip = request.getParameter("comZip");
		comLogin = request.getParameter("comLogin");
		comPass = request.getParameter("comPass");
	
	// Prepares statement to add new subscriber
		String comReg = "INSERT INTO company(name, street_address, city, state, zip, login, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement comRegPS = con.prepareStatement(comReg);
		comRegPS.setString(1, comName);
		comRegPS.setString(2, comAddr);
		comRegPS.setString(3, comCity);
		comRegPS.setString(4, comState);
		comRegPS.setString(5, comZip);
		comRegPS.setString(6, comLogin);
		comRegPS.setString(7, comPass);
	
	// Checks entered login against database
		String checkComLogin = "SELECT login from company WHERE login = ?";
		PreparedStatement checkComLoginPS = con.prepareStatement(checkComLogin);
		checkComLoginPS.setString(1, comLogin);
		ResultSet checkComLoginResult = checkComLoginPS.executeQuery();
	
	// Start of registration process
	if( comLogin != null ) {
		// Check if any boxes in the form are left blank
			if ( comName == null || comName.length() == 0 || comAddr == null || comAddr.length() == 0 || comCity == null || comCity.length() == 0 || 
			comState == null || comState.length() == 0 || comZip == null || comZip.length() == 0 || comLogin == null || comLogin.length() == 0 ||
			comPass == null || comPass.length() == 0 ) {
				%><%="<h1><p>Error: Please make sure to fill in all fields!</h1>"%><%
			}
			else if (!checkComLoginResult.next()) { // If login is not found in database, register the user
				%><%="<h1><p>Thank you for registering, " + comLogin + "! Please return home and login!</h1>"%><%
				comRegPS.executeUpdate();
				//session.setAttribute("login", comLogin);	
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

			<h1>Health Exchange Registration (Company)</h1>
			<ul class="navbar2"><li><a href="index.jsp">Home</a></li></ul>
			<h3><p>Logged in as: <%= login %></h3>
			
			<div id="signin">
				<h2>Register</h2>

				<form action="comregister.jsp" method="POST">
					Name <br/> <input type="text" name="comName"><br/>
					Address <br/> <input type="text" name="comAddr"><br/>
					City <br/> <input type="text" name="comCity"><br/>
					State <br/> <input type="text" name="comState"><br/>
					Zip <br/> <input type="text" name="comZip"><br/>
					Login <br/> <input type="text" name="comLogin"><br/>
					Password <br/> <input type="password" name="comPass"><br/>
					<br/> <input type="submit" value='Submit'>
				</form>
				
				<br/>
			</div>

		</div>

		
	</body>
</html>