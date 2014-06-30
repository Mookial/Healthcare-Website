<%@ include file="head.jsp"%>

<%
	String userType = (String) session.getAttribute("loginType");
	
	if(login != null && userType.equals("Company")) {
	
		String planname   = request.getParameter("planname");
		String condition  = request.getParameter("condition");
		String price      = request.getParameter("price");
		String deductible = request.getParameter("deductible");
		String discount   = request.getParameter("discount");
		String months     = request.getParameter("months");
		
		String message     = "";
		String _planid     = "";
		String _companyid  = "";
		String _offeringid = "";
		
		if(planname   == null || planname.length()   == 0 ||
		   condition  == null || condition.length()  == 0 ||
		   price      == null || price.length()      == 0 ||
		   deductible == null || deductible.length() == 0 ||
		   discount   == null || discount.length()   == 0 ||
		   months     == null || months.length()     == 0) {
			%><%="<p><h1>PLEASE FILL OUT ALL FIELDS!</h1>"%><%
			
			planname   = null;
			condition  = null;
			price      = null;
			deductible = null;
			discount   = null;
			months     = null;
		  }
		else {
			//INSERT INTO PLAN
			String statement     = "INSERT INTO plan (name) VALUES(?)";
			PreparedStatement ps = con.prepareStatement(statement);
			ps.setString(1, planname);
			ps.execute();
			
			//GET PLAN_ID AND SAVE TO A VARIABLE
			statement = "select LAST_INSERT_ID()";
			ps        = con.prepareStatement(statement);
			ResultSet selectResult = ps.executeQuery();
			while(selectResult.next()) {
				_planid = selectResult.getString(1);
			}
			
			//INSERT INTO COVERAGE
			statement = "INSERT INTO coverage (plan_id, cond) VALUES (?, ?)";
			ps        = con.prepareStatement(statement);
			ps.setString(1, _planid);
			ps.setString(2, condition);
			ps.execute();
			
			//GET CURRENTLY LOGGED IN COMPANY_ID AND SAVE TO A VARIABLE
			statement = "SELECT company_id FROM company where login = ?";
			ps        = con.prepareStatement(statement);
			ps.setString(1, login);
			selectResult = ps.executeQuery();
			while(selectResult.next()) {
				_companyid = selectResult.getString(1);
			}
			
			//INSERT INTO OFFERING
			statement = "INSERT INTO offering (plan_id, company_id, price, deductible) VALUES (?, ?, ?, ?)";
			ps        = con.prepareStatement(statement);
			ps.setString(1, _planid);
			ps.setString(2, _companyid);
			ps.setString(3, price);
			ps.setString(4, deductible);
			ps.execute();
			
			//GET OFFERING_ID AND SAVE TO A VARIABLE
			statement = "select LAST_INSERT_ID()";
			ps        = con.prepareStatement(statement);
			selectResult = ps.executeQuery();
			while(selectResult.next()) {
				_offeringid = selectResult.getString(1);
			}
			
			//INSERT INTO DISCOUNT
			statement = "INSERT INTO discount (offering_id, discount, months) VALUES (?, ?, ?)";
			ps        = con.prepareStatement(statement);
			ps.setString(1, _offeringid);
			ps.setString(2, discount);
			ps.setString(3, months);
			ps.execute();
			
			planname   = null;
			condition  = null;
			price      = null;
			deductible = null;
			discount   = null;
			months     = null;
			
			%><%="<h1><p>Plan successfully added! Click below to go back!</h1>"%><%
		}
	//	response.sendRedirect("addplan.jsp");
	}
	else if (login != null && userType.equals("Subscriber")) {
		%><%="<h1><p>You're not allowed to do that! Please login as a Company! Press back!</h1>"%><%
	}
	else {
		%><%="<h1><p>You're not allowed to do that! Please login as a Company! Press back!</h1>"%><%
	}
%>

<html>
	<head>
		<title>Healthcare.gov</title>
 
		<link rel="stylesheet" type="text/css" href="style/style.css"/>
	</head>

	<body>
		<div id="loginmain">	
			<ul class="navbar2"><li><a href="addplan.jsp">Back</a></li></ul>
		</div>
	</body>
</html>