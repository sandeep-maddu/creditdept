<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.SubDepartmentDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<jsp:useBean id="subdept" class="classpackage.SubDepartment" scope="request">

<jsp:setProperty property="dept_id" name="subdept" value="${param.dept_id}" />
<jsp:setProperty property="dept_name" name="subdept" value="${param.dept_name}" />
<jsp:setProperty property="hod" name="subdept" value="${param.hod}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% SubDepartmentDao dao=new SubDepartmentDao();
dao.edit_subdept(subdept); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/sub_dept.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>

</body>
</html>