<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit employee</title>
</head>

<link href="style.css" rel="stylesheet" type="text/css">

<body>

<jsp:useBean id="employee" class="classpackage.Employees" scope="request">

<jsp:setProperty property="eid" name="employee" value="${param.eid}" />
<jsp:setProperty property="scale" name="employee" value="${param.scale}" />
<jsp:setProperty property="designation" name="employee" value="${param.designation}" />
<fmt:parseDate var="parsedHireDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="hire_date" name="employee" value="${parsedHireDate}"/>  
<jsp:setProperty property="reports_to" name="employee" value="${param.reports_to}" />
<jsp:setProperty property="emp_name" name="employee" value="${param.emp_name}" />
<jsp:setProperty property="discretionary_powers" name="employee" value="${param.discretionary_powers}" />
<jsp:setProperty property="sub_dept" name="employee" value="${dept_id}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% EmployeesDao dao=new EmployeesDao();
dao.edit_employee(employee); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/employees.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>


</body>
</html>