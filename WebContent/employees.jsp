<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.SubDepartmentDao" %>
    <%@ page import="classpackage.SubDepartment" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employees</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Employees</center></h2>
<form action="employees_details.jsp" method="post">



<b> New entry : </b> <br><br>
Enter ID of employee : <input type="text" name="eid" /><br>
Enter scale of employee : <input type="text" name="scale" /><br>
Enter designation of employee : <input type="text" name="designation" /><br>
Enter joining date of employee  : 

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
</select>

<br>
Enter name of employee : <input type="text" name="emp_name" /><br>
Enter discretionary powers of employee (Rs. in lakh) : <input type="text" name="discretionary_powers" value="0.00" /><br>
Enter reporting authority of the employee :

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
SubDepartmentDao dao2=new SubDepartmentDao();
List<SubDepartment> subdeptlist=dao2.get_all_subdepts();
%>

<select name="reports_to">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>

</select>
<br>

Enter sub-department of employee : <select name="sub_dept">
<%for (int i=0;i<subdeptlist.size();i++) { %>
<option value="<%=subdeptlist.get(i).getDept_id()%>"> <%=subdeptlist.get(i).getDept_name() %></option>
<%} %>

</select>
<br><br>
<input type="submit" name="add_button" value="Add"><br><br>

<b> Edit entry : </b> <br><br>
Select employee to be edited : <select name="edit_employee">
<%
for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%> </option> 

<%} %>

</select>
<br><br>

<input type="submit" name="edit_button" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select employee to be deleted : <select name="delete_employee">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%> </option> 

<%} %>

</select>
<br><br>

<input type="submit" name="delete_button" value="Delete"><br><br>

<b> View all employees : </b> <br><br>
<input type="submit" name="view_button" value="View all"><br><br>



</form>




</body>
</html>