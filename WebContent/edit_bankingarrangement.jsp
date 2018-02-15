<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.BankingArrangementDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit bankingarrangement</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="bankingarrangement" class="classpackage.BankingArrangement" scope="request">

<jsp:setProperty property="bid" name="bankingarrangement" value="${param.bid}" />
<jsp:setProperty property="aid" name="bankingarrangement" value="${param.aid}" />
<jsp:setProperty property="facility_name" name="bankingarrangement" value="${param.facility_name}" />
<jsp:setProperty property="type" name="bankingarrangement" value="${param.type}" />
<jsp:setProperty property="number_banks" name="bankingarrangement" value="${param.number_banks}" />
<jsp:setProperty property="leader_bank" name="bankingarrangement" value="${param.leader_bank}" />
<fmt:parseDate var="parsedConsortiumDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="latest_consortium_meeting" name="bankingarrangement" value="${parsedConsortiumDate}"/>  
<jsp:setProperty property="diligence_report" name="bankingarrangement" value="${param.diligence_report}" />
<jsp:setProperty property="credit_information_exchange" name="bankingarrangement" value="${param.credit_information_exchange}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% BankingArrangementDao dao=new BankingArrangementDao();
dao.edit_bankingarrangement(bankingarrangement); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/bankingarrangement.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>