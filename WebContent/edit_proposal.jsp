<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit proposal</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="proposal" class="classpackage.Proposal" scope="request">

<jsp:setProperty property="pid" name="proposal" value="${param.pid}" />
<jsp:setProperty property="internal_number" name="proposal" value="${param.internal_number}" />
<fmt:parseDate var="parsedReceiptDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="receipt_date" name="proposal" value="${parsedReceiptDate}"/>
<jsp:setProperty property="aid" name="proposal" value="${param.aid}" />
<jsp:setProperty property="handling_officer" name="proposal" value="${param.handling_officer}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% ProposalDao dao=new ProposalDao();
dao.edit_proposal(proposal); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/proposal.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>