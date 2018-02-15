<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<div class="dropdown">
  
  <button class="dropbtn" onclick="location.href='/creditdept/home.jsp'">Account</button>
    <button class="dropbtn" onclick="location.href='/creditdept/reportselect.jsp'">Reports</button>
</div>

<div class="dropdown">
  <button class="dropbtn">Data</button>
  <div class="dropdown-content">
    	 <a href="/creditdept/sub_dept.jsp">Sub-department</a>
		<a href="/creditdept/employees.jsp">Employees</a>
		<a href="/creditdept/activity.jsp">Activity</a>
		<a href="/creditdept/account.jsp">Accounts</a>
		<a href="/creditdept/group.jsp">Groups</a>
		<a href="/creditdept/facility.jsp">Facilities</a>
		<a href="/creditdept/pending.jsp">Pending issues</a>
		<a href="/creditdept/directors.jsp">Directors</a>
		<a href="/creditdept/phones.jsp">Phones</a>
		<a href="/creditdept/addresses.jsp">Addresses</a>
		<a href="/creditdept/proposal.jsp">Proposals</a>
		<a href="/creditdept/reports.jsp">Reports</a>
		<a href="/creditdept/attendance.jsp">Attendance</a>
		<a href="/creditdept/appliedlimits.jsp">Applied limits</a>
		<a href="/creditdept/sanction.jsp">Sanctions</a>
		<a href="/creditdept/decline.jsp">Declines</a>
		<a href="/creditdept/specialconditions.jsp">Special conditions</a>
		<a href="/creditdept/decision.jsp">Decisions</a>
		<a href="/creditdept/rating.jsp">Ratings</a>
		<a href="/creditdept/mis.jsp">MIS</a>
		<a href="/creditdept/security.jsp">Security</a>
		<a href="/creditdept/guarantor.jsp">Guarantors</a>
		<a href="/creditdept/bankingarrangement.jsp">Banking arrangement</a>
		<a href="/creditdept/sharingpattern.jsp">Sharing Pattern</a>
		<a href="/creditdept/insurance.jsp">Insurance</a>
		<a href="/creditdept/project.jsp">Projects under implementation</a>
		<a href="/creditdept/excessadhoc.jsp">Excess drawals and Adhoc limits</a>
		<a href="/creditdept/limit.jsp">Limits</a>
		<a href="/creditdept/outstanding.jsp">Outstanding</a>
  </div>
</div>

<div class="dropdown">
  <button class="dropbtn" onclick="location.href='/creditdept/help.jsp'">Help</button>
</div>


</body>
</html>