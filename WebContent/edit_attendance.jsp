<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AttendanceDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit attendance</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="attendance" class="classpackage.Attendance" scope="request">

<jsp:setProperty property="attdid" name="attendance" value="${param.attdid}" />
<fmt:parseDate var="parsedPeriod" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="period" name="attendance" value="${parsedPeriod}"/>
<jsp:setProperty property="report_name" name="attendance" value="${param.report_name}" />
<jsp:setProperty property="aid" name="attendance" value="${param.aid}" />
<fmt:parseDate var="parsedReceivedDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="received_date" name="attendance" value="${parsedReceivedDate}"/>
<fmt:parseDate var="parsedReviewedDate" parseLocale="en_US"  value="${param.month3} ${param.day3}, ${param.year3}"/>
<jsp:setProperty property="reviewed_date" name="attendance" value="${parsedReviewedDate}"/>
<jsp:setProperty property="responsible_officer" name="attendance" value="${param.responsible_officer}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% AttendanceDao dao=new AttendanceDao();
dao.edit_attendance(attendance); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/attendance.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>