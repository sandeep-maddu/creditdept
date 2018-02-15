<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.SanctionDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit sanction</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="sanction" class="classpackage.Sanction" scope="request">

<jsp:setProperty property="sid" name="sanction" value="${param.sid}" />
<fmt:parseDate var="parsedSanctionDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="sanction_date" name="sanction" value="${parsedSanctionDate}"/>  
<jsp:setProperty property="sanction_authority" name="sanction" value="${param.sanction_authority}" />
<jsp:setProperty property="sanction_letter_ref" name="sanction" value="${param.sanction_letter_ref}" />
<jsp:setProperty property="reviewing_authority" name="sanction" value="${param.reviewing_authority}" />
<fmt:parseDate var="parsedControlFormSentOn" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="control_form_sent_on" name="sanction" value="${parsedControlFormSentOn}"/>  
<fmt:parseDate var="parsedCmrdQueriesReceivedOn" parseLocale="en_US"  value="${param.month3} ${param.day3}, ${param.year3}"/>
<jsp:setProperty property="cmrd_queries_received_on" name="sanction" value="${parsedCmrdQueriesReceivedOn}"/>  
<fmt:parseDate var="parsedCmrdReplySentOn" parseLocale="en_US"  value="${param.month4} ${param.day4}, ${param.year4}"/>
<jsp:setProperty property="cmrd_reply_sent_on" name="sanction" value="${parsedCmrdReplySentOn}"/>  
<jsp:setProperty property="admin_clearance" name="sanction" value="${param.admin_clearance}" />
<jsp:setProperty property="confirmation" name="sanction" value="${param.confirmation}" />
<jsp:setProperty property="pid" name="sanction" value="${param.pid}" />
</jsp:useBean>



<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% SanctionDao dao=new SanctionDao();
dao.edit_sanction(sanction); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/sanction.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>