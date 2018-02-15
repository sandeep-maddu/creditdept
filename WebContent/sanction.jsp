<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ page import="classpackage.Proposal" %>
    <%@ page import="classpackage.SanctionDao" %>
    <%@ page import="classpackage.Sanction" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sanctions</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Sanctions</center></h2>
<form action="sanction_details.jsp" method="post">

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
ProposalDao dao2=new ProposalDao();
List<Proposal> proposallist=dao2.get_all_proposals();
SanctionDao dao3=new SanctionDao();
List<Sanction> sanctionlist=dao3.get_all_sanctions();
%>

<b> New entry : </b> <br><br>

Enter proposal ID : <select name="pid">
<%for (int i=0;i<proposallist.size();i++) { %>
<option> <%=proposallist.get(i).getPid()%></option>
<%} %>
</select><br>

Enter date of sanction  : 

<select name="month1">
<option value="Jan">January</option>
<option value="Feb">February</option>
<option value="Mar">March</option>
<option value="Apr">April</option>
<option value="May">May</option>
<option value="Jun">June</option>
<option value="Jul">July</option>
<option value="Aug">August</option>
<option value="Sep">September</option>
<option value="Oct">October</option>
<option value="Nov">November</option>
<option value="Dec">December</option>
</select>

<select name="day1">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year1">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>

Enter sanctioning authority : <select name="sanction_authority">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>
</select><br>

Enter sanction letter reference : <input type="text" name="sanction_letter_ref" /><br>

Enter reviewing authority : <select name="reviewing_authority">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>
</select><br>

Enter date on which control form was sent  : 

<select name="month2">
<option value="Jan">January</option>
<option value="Feb">February</option>
<option value="Mar">March</option>
<option value="Apr">April</option>
<option value="May">May</option>
<option value="Jun">June</option>
<option value="Jul">July</option>
<option value="Aug">August</option>
<option value="Sep">September</option>
<option value="Oct">October</option>
<option value="Nov">November</option>
<option value="Dec">December</option>
</select>

<select name="day2">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year2">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>


Enter date on which CMRD queries were received  : 

<select name="month3">
<option value="Jan">January</option>
<option value="Feb">February</option>
<option value="Mar">March</option>
<option value="Apr">April</option>
<option value="May">May</option>
<option value="Jun">June</option>
<option value="Jul">July</option>
<option value="Aug">August</option>
<option value="Sep">September</option>
<option value="Oct">October</option>
<option value="Nov">November</option>
<option value="Dec">December</option>
</select>

<select name="day3">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year3">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>

Enter date on which reply to CMRD queries was sent : 

<select name="month4">
<option value="Jan">January</option>
<option value="Feb">February</option>
<option value="Mar">March</option>
<option value="Apr">April</option>
<option value="May">May</option>
<option value="Jun">June</option>
<option value="Jul">July</option>
<option value="Aug">August</option>
<option value="Sep">September</option>
<option value="Oct">October</option>
<option value="Nov">November</option>
<option value="Dec">December</option>
</select>

<select name="day4">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year4">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>

Enter administrative clearance : <select name="admin_clearance">
<option value="Not applicable">Not applicable</option>
<option value="Taken">Taken</option>
<option value="Not taken">Not taken</option>
</select><br>

Enter confirmation details (if powers of sanction are not vested with authority who sanctioned the limit) : <select name="confirmation">
<option value="Not applicable">Not applicable</option>
<option value="Taken">Taken</option>
<option value="Not taken">Not taken</option>
</select><br><br>

<input type="submit" name="btn_sanction_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select sanction to be edited : <select name="edit_sanction">
<%
for (int i=0;i<sanctionlist.size();i++) { %>
<option> <%=sanctionlist.get(i).getSid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_sanction_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select sanction to be deleted : <select name="delete_sanction">
<%for (int i=0;i<sanctionlist.size();i++) { %>
<option> <%=sanctionlist.get(i).getSid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_sanction_delete" value="Delete"><br><br>

<b> View all sanctions : </b> <br><br>
<input type="submit" name="btn_sanction_view" value="View all"><br><br>

</form>



<body>

</body>
</html>