<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.SecurityDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit security</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">


<jsp:useBean id="security" class="classpackage.Security" scope="request">

<jsp:setProperty property="scid" name="security" value="${param.scid}" />
<jsp:setProperty property="aid" name="security" value="${param.aid}" />
<jsp:setProperty property="type" name="security" value="${param.type}" />
<jsp:setProperty property="location" name="security" value="${param.location}" />
<jsp:setProperty property="description" name="security" value="${param.description}" />
<jsp:setProperty property="owner" name="security" value="${param.owner}" />
<jsp:setProperty property="value" name="security" value="${param.value}" />
<fmt:parseDate var="parsedValuationDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="valuation_date" name="security" value="${parsedValuationDate}"/>  
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% SecurityDao dao=new SecurityDao();
dao.edit_security(security); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/security.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>