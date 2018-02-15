<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.OutstandingDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit outstanding</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="outstanding" class="classpackage.Outstanding" scope="request">

<jsp:setProperty property="oid" name="outstanding" value="${param.oid}" />
<jsp:setProperty property="lid" name="outstanding" value="${param.lid}" />
<jsp:setProperty property="os" name="outstanding" value="${param.os}" />
<fmt:parseDate var="parsedOsDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="os_date" name="outstanding" value="${parsedOsDate}"/>  
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% OutstandingDao dao=new OutstandingDao();
dao.edit_outstanding(outstanding); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/outstanding.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>