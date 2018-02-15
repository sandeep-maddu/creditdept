<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.ProjectDao" %>
    <%@ page import="classpackage.Project" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Projects</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Projects</center></h2>
<form action="project_details.jsp" method="post">

<% AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
ProjectDao dao2=new ProjectDao();
List<Project> projectlist=dao2.get_all_projects();
%>

<b> New entry : </b> <br><br>

Enter name of account : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>

Enter description of project : <textarea name="description" rows="4" cols="25"></textarea><br>
Enter project cost : <input type="text" name="project_cost" /><br>

Enter envisaged DCCO (date of commencement of commercial operations)  : 

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


Enter date on which account will become NPA if project is not completed  : 

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

Enter status of project : <select name="status">
<option value="Under implementation">Under implementation</option>
<option value="Completed">Completed</option>
</select><br>

Enter remarks : <input type="text" name="remarks" /><br><br>

<input type="submit" name="btn_project_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select ID of project to be edited : <select name="edit_project">
<%
for (int i=0;i<projectlist.size();i++) { %>
<option> <%=projectlist.get(i).getProject_id()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_project_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select ID of project to be deleted : <select name="delete_project">
<%for (int i=0;i<projectlist.size();i++) { %>
<option> <%=projectlist.get(i).getProject_id()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_project_delete" value="Delete"><br><br>

<b> View all projects : </b> <br><br>
<input type="submit" name="btn_project_view" value="View all"><br><br>

</form>



<body>

</body>
</html>