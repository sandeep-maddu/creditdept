<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.ReportsDao" %>
    <%@ page import="classpackage.Reports" %>
    <%@ page import="classpackage.AttendanceDao" %>
    <%@ page import="classpackage.Attendance" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attendance</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Attendance</center></h2>
<form action="attendance_details.jsp" method="post">

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
AccountDao dao2=new AccountDao();
List<Account> accountlist=dao2.get_all_accounts();
ReportsDao dao3=new ReportsDao();
List<Reports> reportslist=dao3.get_all_reports();
AttendanceDao dao4=new AttendanceDao();
List<Attendance> attendancelist=dao4.get_all_attendance();
%>

<b> New entry : </b> <br><br>

Enter name of account : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>

Enter name of report : <select name="report_name">
<%for (int i=0;i<reportslist.size();i++) { %>
<option> <%=reportslist.get(i).getReport_name()%></option>
<%} %>
</select><br>

Enter period  : 

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

Enter date of which received : 

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

Enter date on which reviewed  : 

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


Enter officer who is responsible for this report and account : <select name="responsible_officer">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>
</select><br><br>

<input type="submit" name="btn_attendance_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>

Select attendance to be edited : <select name="edit_attendance">
<%
for (int i=0;i<attendancelist.size();i++) { %>
<option> <%=attendancelist.get(i).getAttdid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_attendance_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select attendance to be deleted : <select name="delete_attendance">
<%for (int i=0;i<attendancelist.size();i++) { %>
<option> <%=attendancelist.get(i).getAttdid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_attendance_delete" value="Delete"><br><br>

<b> View all attendances : </b> <br><br>
<input type="submit" name="btn_attendance_view" value="View all"><br><br>

</form>



<body>

</body>
</html>