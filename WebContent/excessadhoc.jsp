<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.ExcessAdhocDao" %>
    <%@ page import="classpackage.ExcessAdhoc" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Excess drawals and Adhoc limits</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Excess drawals and Adhoc limits</center></h2>
<form action="excessadhoc_details.jsp" method="post">

<%
AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
ExcessAdhocDao dao2=new ExcessAdhocDao();
List<ExcessAdhoc> excessadhoclist=dao2.get_all_excessadhocs();
%>

<b> New entry : </b> <br><br>

Enter account : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>

Enter facility : <select name="type">
<option>Excess drawal</option>
<option>Adhoc limit</option>
<option>Others</option>
</select><br>

Enter date on which availed  : 

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

Enter limit amount : <input type="text" name="limit" value="0.00" /><br>
Enter number of days : <input type="text" name="number_of_days" value="15" /><br>

Enter due date : 

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

Enter number of times allowed since last renewal : <input type="text" name="limit" value="1" /><br>

Enter date on which actually adjusted : 

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

Enter additional rate over regular limit : <input type="text" name="pct_over_regular_roi" value="2.00" /><br>
Enter status of ROC : <select name="roc_status">
<option>Not applicable</option>
<option>Completed</option>
<option>Pending</option>
</select><br><br>

<input type="submit" name="btn_excessadhoc_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select ID of excess / adhoc to be edited : <select name="edit_excessadhoc">
<% for (int i=0;i<excessadhoclist.size();i++) { %>
<option> <%=excessadhoclist.get(i).getEid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_excessadhoc_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select ID of excess / adhoc to be deleted : <select name="delete_excessadhoc">
<%for (int i=0;i<excessadhoclist.size();i++) { %>
<option> <%=excessadhoclist.get(i).getEid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_excessadhoc_delete" value="Delete"><br><br>

<b> View all excess drawals and adhoc limits : </b> <br><br>
<input type="submit" name="btn_excessadhoc_view" value="View all"><br><br>

</form>



<body>

</body>
</html>