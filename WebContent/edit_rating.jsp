<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.RatingDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit rating</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="rating" class="classpackage.Rating" scope="request">

<jsp:setProperty property="rid" name="rating" value="${param.rid}" />
<jsp:setProperty property="agency" name="rating" value="${param.agency}" />
<jsp:setProperty property="facility_name" name="rating" value="${param.facility_name}" />
<jsp:setProperty property="rating" name="rating" value="${param.rating}" />
<jsp:setProperty property="rating_model" name="rating" value="${param.rating_model}" />
<jsp:setProperty property="description" name="rating" value="${param.description}" />
<fmt:parseDate var="parsedBasedOnFinancialsDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="basedon_financials" name="rating" value="${parsedBasedOnFinancialsDate}"/>
<jsp:setProperty property="basedon_audited" name="rating" value="${param.basedon_audited}" />
<fmt:parseDate var="parsedDueDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="due_date" name="rating" value="${parsedDueDate}"/>
<jsp:setProperty property="aid" name="rating" value="${param.aid}" />
</jsp:useBean>


<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% RatingDao dao=new RatingDao();
dao.edit_rating(rating); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/rating.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>