<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="classpackage.ReportsDao" %>
    <%@ page import="classpackage.Reports" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Reports</center></h2>
<form action="reports_details.jsp" method="post">



<b> New entry : </b> <br><br>
Enter report name : <input type="text" name="report_name" /><br>
Enter periodicity : <select name="periodicity">
<option>Daily</option>
<option>Weekly</option>
<option>Fortnightly</option>
<option>Monthly</option>
<option>Once in two months</option>
<option>Quarterly</option>
<option>Half yearly</option>
<option>Annually</option>
<option>Once in two years</option>
<option>Once in three years</option>
</select><br><br>

<input type="submit" name="btn_report_add" value="Add" /><br><br>


<b> Edit entry : </b> <br><br>
Select report to be edited : <select name="edit_report">
<%
ReportsDao dao1=new ReportsDao();
List<Reports> reportslist=dao1.get_all_reports();
for (int i=0;i<reportslist.size();i++) { %>
<option> <%=reportslist.get(i).getReport_name()%> </option> 
<%} %>
</select>
<br><br>

<input type="submit" name="btn_report_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select report to be deleted : <select name="delete_report">
<%
for (int i=0;i<reportslist.size();i++) { %>
<option> <%=reportslist.get(i).getReport_name()%> </option> 
<%} %>
</select>
<br><br>
<input type="submit" name="btn_report_delete" value="Delete" /><br><br>

<b> View all reports : </b> <br><br>
<input type="submit" name="btn_report_view" value="View all" /><br><br>

</form>

</body>
</html>