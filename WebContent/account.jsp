<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.SubDepartmentDao" %>
    <%@ page import="classpackage.SubDepartment" %>
    <%@ page import="classpackage.ActivityDao" %>
    <%@ page import="classpackage.Activity" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Accounts</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<h2><center>Accounts</center></h2>
<form action="account_details.jsp" method="post">

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
SubDepartmentDao dao2=new SubDepartmentDao();
List<SubDepartment> subdeptlist=dao2.get_all_subdepts();
ActivityDao dao3=new ActivityDao();
List<Activity> activitylist=dao3.get_all_activities();
AccountDao dao4=new AccountDao();
List<Account> accountlist=dao4.get_all_accounts();
%>

<b> New entry : </b> <br><br>
Enter name of account : <input type="text" name="account_name" /><br>
Enter CBS customer ID if applicable : <input type="text" name="cust_id" /><br>
Enter sub-department : <select name="subdept">
<%for (int i=0;i<subdeptlist.size();i++) { %>
<option value="<%=subdeptlist.get(i).getDept_id()%>"> <%=subdeptlist.get(i).getDept_name() %></option>
<%} %>
</select> <br>

Enter file number : <input type="text" name="file_no" /><br>
Enter powers under whom the account falls : <select name="powers">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>
</select><br>

Enter asset classification : <select name="asset_classf">
<option value="Standard">Standard</option>
<option value="Substandard">Substandard</option>
<option value="Doubtful">Doubtful</option>
<option value="Loss">Loss</option>
</select><br>

Enter date of incorporation  : 

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

Enter constitution : <select name="constitution">
<option value="Sole proprietorship">Sole proprietorship</option>
<option value="Partnership">Partnership</option>
<option value="Private limited company">Private limited company</option>
<option value="Public limited company">Public limited company</option>
</select><br>

Enter Chief Executive of the company : <input type="text" name="chief_exec" /><br>
Enter date since company is dealing with bank :

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

Enter officer who handles this account : <select name="concerned_officer">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>
</select><br>

Enter whether account is closed or existing : <select name="close_status">
<option value="Existing">Existing</option>
<option value="Closed">Closed</option>
</select><br>

Enter activity : <select name="activity_name">
<%for (int i=0;i<activitylist.size();i++) { %>
<option><%=activitylist.get(i).getActivity_name() %></option>
<%} %>
</select><br><br>

<input type="submit" name="btn_account_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select account to be edited : <select name="edit_account">
<%
for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_account_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select account to be deleted : <select name="delete_account">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_account_delete" value="Delete"><br><br>

<b> View all accounts : </b> <br><br>
<input type="submit" name="btn_account_view" value="View all"><br><br>

</form>



<body>

</body>
</html>