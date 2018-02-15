<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ page import="classpackage.Proposal" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Proposals</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Proposals</center></h2>
<form action="proposal_details.jsp" method="post">

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
AccountDao dao2=new AccountDao();
List<Account> accountlist=dao2.get_all_accounts();
ProposalDao dao3=new ProposalDao();
List<Proposal> proposallist=dao3.get_all_proposals();
%>

<b> New entry : </b> <br><br>
Enter internal number of proposal : <input type="text" name="internal_number" /><br>

Enter receipt date of proposal  : 

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

Enter name of account : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>

Enter officer who handles this proposal : <select name="handling_officer">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>
</select><br><br>

<input type="submit" name="btn_proposal_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select proposal to be edited : <select name="edit_proposal">
<%
for (int i=0;i<proposallist.size();i++) { %>
<option> <%=proposallist.get(i).getPid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_proposal_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select proposal to be deleted : <select name="delete_proposal">
<%for (int i=0;i<proposallist.size();i++) { %>
<option> <%=proposallist.get(i).getPid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_proposal_delete" value="Delete"><br><br>

<b> View all proposals : </b> <br><br>
<input type="submit" name="btn_proposal_view" value="View all"><br><br>

</form>



<body>

</body>
</html>