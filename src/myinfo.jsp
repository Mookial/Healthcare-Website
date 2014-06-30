<html>

<%@ include file="head.jsp"%>

<%
	ArrayList<String> offerings = new ArrayList<String>();
	boolean wasCompany = false;
	
	String userType = (String) session.getAttribute("loginType");
	
	if(login != null && userType.equals("Company")){
		String _myid = "";
		
		String selectStatement = "select company_id from company where company.login = ?";
		PreparedStatement ps   = con.prepareStatement(selectStatement);
		ps.setString(1, login);
		ResultSet selectResult = ps.executeQuery();
		while(selectResult.next()) {
			_myid = selectResult.getString(1);
		}
			
		selectStatement = "select plan.name, coverage.cond, offering.price, offering.deductible, discount.discount, discount.months from plan left join coverage using(plan_id) left join offering using(plan_id) left join company using(company_id) left join discount on offering.offering_id = discount.offering_id where company.company_id = ?";
		ps              = con.prepareStatement(selectStatement);
		ps.setString(1, _myid);
		selectResult    = ps.executeQuery();
		
		while(selectResult.next()) {
			offerings.add(selectResult.getString(1)); //getString(1) returns string 1 
			offerings.add(selectResult.getString(2)); //in the current column
			offerings.add(selectResult.getString(3)); 
			offerings.add(selectResult.getString(4)); 
			offerings.add(selectResult.getString(5)); 
			offerings.add(selectResult.getString(6)); 
		}
		wasCompany = true;
	}
	else if (login != null && userType.equals("Subscriber")) {
		String subInfo = "select plan.name, coverage.cond, offering.price, offering.deductible, discount.discount, discount.months, subscription.paid, " +
						   "subscription.months from plan left join coverage using(plan_id) left join offering using(plan_id) left join discount " +
						   "using(offering_id) left join subscription using(offering_id) left join subscriber on subscription.subscriber_id = " +
						   "subscriber.subscriber_id where subscriber.login = ?";
		PreparedStatement subInfoPs = con.prepareStatement(subInfo);
		subInfoPs.setString(1, login);
		ResultSet subInfoResult = subInfoPs.executeQuery();
		
		while(subInfoResult.next()) {
			offerings.add(subInfoResult.getString(1));
			offerings.add(subInfoResult.getString(2));
			offerings.add(subInfoResult.getString(3));
			offerings.add(subInfoResult.getString(4));
			offerings.add(subInfoResult.getString(5));
			offerings.add(subInfoResult.getString(6));
			offerings.add(subInfoResult.getString(7));
			offerings.add(subInfoResult.getString(8));
		}
	}
	else {
		response.sendRedirect("error.jsp");
	}
%>

	<head>
		<title>Healthcare.gov</title>
 
		<link rel="stylesheet" type="text/css" href="style/style.css"/>
	</head>

	<body>
		<div id="main">	

			<h1><%= login %>'s Info</h1>
			<ul class="navbar2"><li><a href="index.jsp">Home</a></li></ul>
			<h3><p>Logged in as: <%= login %>
			<!-- create table with plan info -->
			
		<%if(wasCompany) { %>
		<table> 
		<tr><td>Plan Name</td>
		    <td>Condition</td>
			<td>Price</td>
			<td>Deductible</td>
			<td>Discount</td>
			<td>Months</td>
		</tr>
		<% for(int i = 0; i < offerings.size(); i+=6) { %>
		<tr><td><%= offerings.get(i) %></td>
		    <td><%= offerings.get(i+1) %></td>
		    <td><%= offerings.get(i+2) %></td>
		    <td><%= offerings.get(i+3) %></td>
		    <td><%= offerings.get(i+4) %></td>
		    <td><%= offerings.get(i+5) %></td></tr>
		<% } %>
		</table>
		<%}%>
		
		<%if(!wasCompany) { %>
			<table> 
			<tr><td>Plan Name</td>
				<td>Condition</td>
				<td>Price</td>
				<td>Deductible</td>
				<td>Discount</td>
				<td>Discount Months</td>
				<td>Paid</td>
				<td>Subscription Months</td>
			</tr>
			<% for(int i = 0; i < offerings.size(); i+=8) { %>
			<tr><td><%= offerings.get(i) %></td>
				<td><%= offerings.get(i+1) %></td>
				<td><%= offerings.get(i+2) %></td>
				<td><%= offerings.get(i+3) %></td>
				<td><%= offerings.get(i+4) %></td>
				<td><%= offerings.get(i+5) %></td>
				<td><%= offerings.get(i+6) %></td>
				<td><%= offerings.get(i+7) %></td></tr>
			<% } %>
			</table>
			<%}%>
		</div>
		<%= offerings.size()%>
	</body>
</html>