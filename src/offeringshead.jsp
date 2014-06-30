<!-- Includes clientProperties & parameter variables -->
<%@ include file="head.jsp"%>
<!----------------------------------------------------->

<%
	String userType = (String) session.getAttribute("loginType");
	
	planName = request.getParameter("planName");
	paid = request.getParameter("paid");
	_months = request.getParameter("_months");
	if(login != null && userType.equals("Subscriber")) {
		
		if(planName == null || planName.length() == 0 || paid == null || paid.length() == 0 || _months == null || _months.length() == 0) {
			%><%="<h1><p>Make sure all fields are filled and try again!</h1>"%><%
			
			planName	=	null;
			paid		=	null;
			_months  	=	null;
		}
		else {
			String _offid = "";
			String _subid = "";
			
			//GET OFFERING_ID
			String statement     = "select offering_id from offering left join plan using(plan_id) where plan.name = ?";
			PreparedStatement ps = con.prepareStatement(statement);
			ps.setString(1, planName);
			ResultSet selectResult = ps.executeQuery();
			
			if(selectResult.next()) {
			
				//selectResult.next();
				_offid = selectResult.getString(1);
				
				
				//GET SUBSCRIBER_ID
				statement = "select subscriber_id from subscriber where subscriber.login = ?";
				ps        = con.prepareStatement(statement);
				ps.setString(1, login);
				selectResult = ps.executeQuery();
			   
				while(selectResult.next()) {
				 _subid = selectResult.getString(1);
				}
			   
				//INSERT DATA INTO SUBSCRIPTION TABLE
				statement = "insert into subscription(subscriber_id, offering_id, paid, months) values(?, ?, ?, ?)";
				ps        = con.prepareStatement(statement);
				ps.setString(1, _subid);
				ps.setString(2, _offid);
				ps.setString(3, paid);
				ps.setString(4, _months);
				ps.executeUpdate();
				
				response.sendRedirect("offerings.jsp");
			}
			else {
				%><%="<h1><p>Not a valid plan name! Press back and try again!</h1>"%><%
			}
		}
	}
	else if (login != null && userType.equals("Company")) {
		%><%="<h1><p>You're not allowed to do that! Please login as a Subscriber! Press back!</h1>"%><%
	}
	else {
		%><%="<h1><p>You're not allowed to do that! Please login as a Subscriber! Press back !</h1>"%><%
	}
%>	

<html>
	<head>
		<title>Healthcare.gov</title>
 
		<link rel="stylesheet" type="text/css" href="style/style.css"/>
	</head>

	<body>
		<div id="loginmain">	
			<ul class="navbar2"><li><a href="offerings.jsp">Back</a></li></ul>
		</div>
	</body>
</html>