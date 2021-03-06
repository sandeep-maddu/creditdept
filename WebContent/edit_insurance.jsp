<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.InsuranceDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit insurance</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="insurance" class="classpackage.Insurance" scope="request">

<jsp:setProperty property="policyid" name="insurance" value="${param.policyid}" />
<jsp:setProperty property="agency" name="insurance" value="${param.agency}" />
<jsp:setProperty property="sum_assured" name="insurance" value="${param.sum_assured}" />
<fmt:parseDate var="parsedPolicyDueDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="policy_duedate" name="insurance" value="${parsedPolicyDueDate}"/>  
<jsp:setProperty property="aid" name="insurance" value="${param.aid}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% InsuranceDao dao=new InsuranceDao();
dao.edit_insurance(insurance); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/insurance.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>