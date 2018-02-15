<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ page import="classpackage.Proposal" %>
    <%@ page import="classpackage.DeclineDao" %>
    <%@ page import="classpackage.Decline" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Declines</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Declines</center></h2>
<form action="decline_details.jsp" method="post">

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
ProposalDao dao2=new ProposalDao();
List<Proposal> proposallist=dao2.get_all_proposals();
DeclineDao dao3=new DeclineDao();
List<Decline> declinelist=dao3.get_all_declines();
%>

<b> New entry : </b> <br><br>

Enter proposal ID : <select name="pid">
<%for (int i=0;i<proposallist.size();i++) { %>
<option> <%=proposallist.get(i).getPid()%></option>
<%} %>
</select><br>

Enter date of decline  : 

<select name="month">
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

<select name="day">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>

Enter declining authority : <select name="decline_authority">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>
</select><br>

Enter decline letter reference : <input type="text" name="decline_letter_ref" /><br>
Enter reasons for decline : <textarea name="reasons" rows="4" cols="25"></textarea> <br>

Enter whether decline is to be reported to higher authority : <select name="report_higher">
<option value="Not applicable">Not applicable</option>
<option value="Required">Required</option>
<option value="Not required">Not required</option>
</select><br><br>

<input type="submit" name="btn_decline_add" value="Add"><br><br>

<b> Edit entry : </b> <br><br>
Select decline to be edited : <select name="edit_decline">
<%
for (int i=0;i<declinelist.size();i++) { %>
<option> <%=declinelist.get(i).getDid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_decline_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select decline to be deleted : <select name="delete_decline">
<%for (int i=0;i<declinelist.size();i++) { %>
<option> <%=declinelist.get(i).getDid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_decline_delete" value="Delete"><br><br>

<b> View all declines : </b> <br><br>
<input type="submit" name="btn_decline_view" value="View all"><br><br>

</form>



<body>

</body>
</html>