<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.ProjectDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit project</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="project" class="classpackage.Project" scope="request">

<jsp:setProperty property="project_id" name="project" value="${param.project_id}" />
<jsp:setProperty property="aid" name="project" value="${param.aid}" />
<jsp:setProperty property="description" name="project" value="${param.description}" />
<jsp:setProperty property="project_cost" name="project" value="${param.project_cost}" />
<fmt:parseDate var="parsedEnvisagedCod" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="envisaged_cod" name="project" value="${parsedEnvisagedCod}"/>  
<fmt:parseDate var="parsedNpaTriggerDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="npa_trigger_date" name="project" value="${parsedNpaTriggerDate}"/>  
<jsp:setProperty property="status" name="project" value="${param.status}" />
<jsp:setProperty property="remarks" name="project" value="${param.remarks}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% ProjectDao dao=new ProjectDao();
dao.edit_project(project); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/project.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>