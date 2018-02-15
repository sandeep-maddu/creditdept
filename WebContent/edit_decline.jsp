<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.DeclineDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit decline</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="decline" class="classpackage.Decline" scope="request">

<jsp:setProperty property="did" name="decline" value="${param.did}" />
<fmt:parseDate var="parsedDeclineDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="decline_date" name="decline" value="${parsedDeclineDate}"/>  
<jsp:setProperty property="decline_authority" name="decline" value="${param.decline_authority}" />
<jsp:setProperty property="decline_letter_ref" name="decline" value="${param.decline_letter_ref}" />
<jsp:setProperty property="reasons" name="decline" value="${param.reasons}" />
<jsp:setProperty property="report_higher" name="decline" value="${param.report_higher}" />
<jsp:setProperty property="pid" name="decline" value="${param.pid}" />
</jsp:useBean>



<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% DeclineDao dao=new DeclineDao();
dao.edit_decline(decline); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/decline.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>