<html>

<!-- Includes clientProperties & parameter variables -->
<%@ include file="head.jsp"%>
<!----------------------------------------------------->

<%
	ArrayList<String> offerings = new ArrayList<String>();

	String selectStatement = "select company.name, plan.name, coverage.cond, offering.price, offering.deductible, discount.discount, discount.months " +
							 "from plan left join coverage using(plan_id) left join offering using(plan_id) left join company using(company_id) left " + 
							 "join discount on offering.offering_id = discount.offering_id";
	
	PreparedStatement ps   = con.prepareStatement(selectStatement);
	ResultSet selectResult = ps.executeQuery();
	
	while(selectResult.next()) {
		offerings.add(selectResult.getString(1)); //getString(1) returns string 1 
		offerings.add(selectResult.getString(2)); //in the current column
		offerings.add(selectResult.getString(3)); 
		offerings.add(selectResult.getString(4)); 
		offerings.add(selectResult.getString(5)); 
		offerings.add(selectResult.getString(6));
		offerings.add(selectResult.getString(7));
	}
%>

<head>
   <title>Healthcare.gov</title>
 
  <link rel="stylesheet" type="text/css" href="style/style.css"/>
</head>

<body>

	<div id="main">	
	
		<h1>Current Offerings / Subscribe</h1>
		<ul class="navbar2"><li><a href="index.jsp">Home</a></li></ul>
		<h3><p>Logged in as: <%= login %></h3>
		<!-- create table with plan info -->
		<table border="2"> 
		<tr><td>Company Name</td>
			<td>Plan Name</td>
		    <td>Condition</td>
			<td>Price</td>
			<td>Deductible</td>
			<td>Discount</td>
			<td>Months</td>
		</tr>
		<% for(int i = 0; i < offerings.size(); i+=7) { %>
		<tr><td><%= offerings.get(i) %></td>
		    <td><%= offerings.get(i+1) %></td>
		    <td><%= offerings.get(i+2) %></td>
		    <td><%= offerings.get(i+3) %></td>
		    <td><%= offerings.get(i+4) %></td>
		    <td><%= offerings.get(i+5) %></td>
			<td><%= offerings.get(i+6) %></td></tr>
		<% } %>
		</table>
	
	<div id="signin2">
	<h2>Subscribe</h2> 
	<form action="offeringshead.jsp" method="POST">
		Plan Name <br/> <input type="text" name="planName"><br/>
		Paid <br/> <input type="text" name="paid"><br/>
		Months <br/> <input type="text" name="_months"><br/>
			<br/><input type="submit" value='Submit'>
		</form>
	</div>
	</div>

</body>
</html>