<%@ include file="head.jsp"%>

<%
	login 		= 	request.getParameter("login");
	password 	= 	request.getParameter("password");
	loginType 	= 	request.getParameter("loginType");
	
	if( loginType != null && loginType.equals("Subscriber") ) {

		String getLogin	 = "SELECT login from subscriber WHERE login = ?";
		PreparedStatement getLoginPs = con.prepareStatement(getLogin);
		getLoginPs.setString(1, login);
	
		if(login != null && login.length() != 0) {
			ResultSet loginResultSet = getLoginPs.executeQuery();

			if(loginResultSet.next()) {

				String actualPass = "SELECT password from subscriber WHERE login = ?";
				PreparedStatement actualPassPs = con.prepareStatement(actualPass);
				actualPassPs.setString(1, login);
				ResultSet actualPassSet = actualPassPs.executeQuery();
				actualPassSet.next();

				if( actualPassSet.getString(1).equals(password) && password.length() != 0 && password != null ) {
					%><%="<h1><p>(Subscriber) Correct password! Welcome back, " + login + "! Please press Home to access the website.</h1>"%><%
					loginType = "Subscriber";
					session.setAttribute("login", login);
					session.setAttribute("loginType", loginType);
				}
				else {
					%><%="<h1>(Subscriber) Incorrect password, press home and try again!</h1>"%><%
					session.setAttribute("login", null);
					session.setAttribute("loginType", null);
					login = null;
					loginType = null;
				}
			}
			else {
				session.setAttribute("login", null);
				session.setAttribute("loginType", null);
				login = null;
				loginType = null;
				%><%="<h1><p>(Subscriber) Login not found, go home and register via the Registration link!</h1>"%><%
			}
		}
	}		
	else if ( loginType != null && loginType.equals("Company")) {
		String getLogin = "SELECT login from company WHERE login = ?";
		PreparedStatement getLoginPs = con.prepareStatement(getLogin);
		getLoginPs.setString(1, login);


		if(login != null && login.length() != 0) {
			ResultSet loginResultSet = getLoginPs.executeQuery();

			if(loginResultSet.next()) {

				String actualPass = "SELECT password from company WHERE login = ?";
				PreparedStatement actualPassPs = con.prepareStatement(actualPass);
				actualPassPs.setString(1, login);
				ResultSet actualPassSet = actualPassPs.executeQuery();
				actualPassSet.next();

				if( actualPassSet.getString(1).equals(password) && password.length() != 0 && password != null ) {
					%><%="<h1><p>(Company) Correct password! Welcome back, " + login + "! Please press Home to access the website.</h1>"%><%
					loginType = "Company";
					session.setAttribute("login", login);
					session.setAttribute("loginType", loginType);
				}
				else {
					%><%="<h1>(Company) Incorrect password, press home and try again!</h1>"%><%
					session.setAttribute("login", null);
					session.setAttribute("loginType", null);
					login = null;
					loginType = null;
				}
			}
			else {
					session.setAttribute("login", null);
					session.setAttribute("loginType", null);
					login = null;
					loginType = null;
					%><%="<h1><p>(Company) Login not found, go home and register via the Registration link!</h1>"%><%
			}
		}
	}
%>

<html>
	<head>
		<title>Healthcare.gov</title>
 
		<link rel="stylesheet" type="text/css" href="style/style.css"/>
	</head>

	<body>
		<div id="loginmain">	
			<ul class="navbar2"><li><a href="index.jsp">Home</a></li></ul>
		</div>
	</body>
</html>