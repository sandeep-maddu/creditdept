<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.ExcessAdhocDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit excessadhoc</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">


<jsp:useBean id="excessadhoc" class="classpackage.ExcessAdhoc" scope="request">

<jsp:setProperty property="eid" name="excessadhoc" value="${param.eid}" />
<jsp:setProperty property="aid" name="excessadhoc" value="${param.aid}" />
<jsp:setProperty property="type" name="excessadhoc" value="${param.type}" />
<fmt:parseDate var="parsedAvailedOn" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="availed_on" name="excessadhoc" value="${parsedAvailedOn}"/>  
<jsp:setProperty property="limit" name="excessadhoc" value="${param.limit}" />
<jsp:setProperty property="number_of_days" name="excessadhoc" value="${param.number_of_days}" />
<fmt:parseDate var="parsedDueDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="due_date" name="excessadhoc" value="${parsedDueDate}"/> 
<jsp:setProperty property="times_since_last_renewal" name="excessadhoc" value="${param.times_since_last_renewal}" />
<fmt:parseDate var="parsedWhenActuallyAdjusted" parseLocale="en_US"  value="${param.month3} ${param.day3}, ${param.year3}"/>
<jsp:setProperty property="when_actually_adjusted" name="excessadhoc" value="${parsedWhenActuallyAdjusted}"/> 
<jsp:setProperty property="pct_over_regular_roi" name="excessadhoc" value="${param.pct_over_regular_roi}" />
<jsp:setProperty property="roc_status" name="excessadhoc" value="${param.roc_status}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% ExcessAdhocDao dao=new ExcessAdhocDao();
dao.edit_excessadhoc(excessadhoc); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/excessadhoc.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>