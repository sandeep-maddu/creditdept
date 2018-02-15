<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.DecisionDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit decision</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="decision" class="classpackage.Decision" scope="request">

<jsp:setProperty property="did" name="decision" value="${param.did}" />
<fmt:parseDate var="parsedDecisionDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="decision_date" name="decision" value="${parsedDecisionDate}"/>  
<jsp:setProperty property="approving_authority" name="decision" value="${param.approving_authority}" />
<jsp:setProperty property="aid" name="decision" value="${param.aid}" />
<jsp:setProperty property="letter_ref" name="decision" value="${param.letter_ref}" />
<fmt:parseDate var="parsedReceivedOn" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="received_on" name="decision" value="${parsedReceivedOn}"/>  
<jsp:setProperty property="review_authority" name="decision" value="${param.review_authority}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% DecisionDao dao=new DecisionDao();
dao.edit_decision(decision); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/decision.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>