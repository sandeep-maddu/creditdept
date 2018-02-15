<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ page import="classpackage.BankingArrangementDao" %>
    <%@ page import="classpackage.BankingArrangement" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BankingArrangements</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Banking Arrangements</center></h2>
<form action="bankingarrangement_details.jsp" method="post">

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
FacilityDao dao2=new FacilityDao();
List<Facility> facilitylist=dao2.get_all_facilities();
BankingArrangementDao dao3=new BankingArrangementDao();
List<BankingArrangement> bankingarrangementlist=dao3.get_all_bankingarrangement();
%>

<b> New entry : </b> <br><br>

Enter name of account : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid()%>"> <%=accountlist.get(i).getAccount_name() %></option>
<%} %>
</select> <br>

Enter facility : <select name="facility_name">
<%for (int i=0;i<facilitylist.size();i++) { %>
<option> <%=facilitylist.get(i).getFacility_name() %></option>
<%} %>
</select> <br>

Enter banking arrangement : <select name="type">
<option value="Sole banking">Sole banking</option>
<option value="Consortium">Consortium</option>
<option value="Multiple Banking Arrangement">Multiple Banking Arrangement</option>
</select><br>

Enter number of banks in the arrangement : <input type="text" name="number_banks" /><br>
Enter leader bank : <input type="text" name="leader_bank" /><br>

Enter date of latest consortium meting  : 

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


Enter status of diligence report required as per RBI : <select name="diligence_report">
<option value="Not applicable">Not applicable</option>
<option value="Obtained">Obtained</option>
<option value="Pending">Pending</option>
</select><br>

Enter status of credit information exchange required as per RBI : <select name="credit_information_exchange">
<option value="Not applicable">Not applicable</option>
<option value="Obtained">Obtained</option>
<option value="Pending">Pending</option>
</select><br><br>

<input type="submit" name="btn_bankingarrangement_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select ID of banking arrangement to be edited : <select name="edit_bankingarrangement">
<%
for (int i=0;i<bankingarrangementlist.size();i++) { %>
<option> <%=bankingarrangementlist.get(i).getBid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_bankingarrangement_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select ID of banking arrangement to be deleted : <select name="delete_bankingarrangement">
<%for (int i=0;i<bankingarrangementlist.size();i++) { %>
<option> <%=bankingarrangementlist.get(i).getBid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_bankingarrangement_delete" value="Delete"><br><br>

<b> View all banking arrangements : </b> <br><br>
<input type="submit" name="btn_bankingarrangement_view" value="View all"><br><br>

</form>



<body>

</body>
</html>