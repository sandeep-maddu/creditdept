<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.SubDepartmentDao" %>
    <%@ page import="classpackage.SubDepartment" %>
    <%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sub-department</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Sub-departments</center></h2>
<form action="subdept_details.jsp" method="post">

<b> New entry : </b> <br><br>

Enter name of sub-department : <input type="text" name="add_dept_name" /><br><br>

Employee in-charge for the sub-department
<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
%>

<select name="add_hod">
<%for (int i=0;i<emplist.size();i++) { %>
<option value="<%=emplist.get(i).getEid() %>"> <%=emplist.get(i).getEmp_name() + " (employee code : "+emplist.get(i).getEid()+")"%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_subdept_add" value="Add"><br><br>

<b> Edit entry : </b><br><br>
Select sub-department to be edited : <select name="edit_subdept">
<%SubDepartmentDao dao2=new SubDepartmentDao();
List<SubDepartment> subdeptlist=dao2.get_all_subdepts();
for (int i=0;i<subdeptlist.size();i++) { %>
<option value="<%=subdeptlist.get(i).getDept_id() %>"> <%=subdeptlist.get(i).getDept_name()%> </option> 
<%} %>
</select>
<br><br>
<input type="submit" name="btn_subdept_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select sub-department to be deleted : <select name="delete_subdept">
<%for (int i=0;i<subdeptlist.size();i++) { %>
<option value="<%=subdeptlist.get(i).getDept_id() %>"> <%=subdeptlist.get(i).getDept_name()%> </option> 
<%} %>
</select>
<br><br>

<input type="submit" name="btn_subdept_delete" value="Delete"><br><br>

<b> View all entries : </b> <br><br>
<input type="submit" name="btn_subdept_view" value="View all"><br><br>

</form>

</body>
</html>