<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AccountDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit account</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="account" class="classpackage.Account" scope="request">

<jsp:setProperty property="aid" name="account" value="${param.aid}" />
<jsp:setProperty property="cust_id" name="account" value="${param.cust_id}" />
<jsp:setProperty property="account_name" name="account" value="${param.account_name}" />
<jsp:setProperty property="subdept" name="account" value="${param.subdept}" />
<jsp:setProperty property="file_no" name="account" value="${param.file_no}" />
<jsp:setProperty property="powers" name="account" value="${param.powers}" />
<jsp:setProperty property="asset_classf" name="account" value="${param.asset_classf}" />
<fmt:parseDate var="parsedIncorpDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="incorp_date" name="account" value="${parsedIncorpDate}"/>  
<jsp:setProperty property="constitution" name="account" value="${param.constitution}" />
<jsp:setProperty property="chief_exec" name="account" value="${param.chief_exec}" />
<fmt:parseDate var="parsedDealingSince" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="dealing_since" name="account" value="${parsedDealingSince}"/> 
<jsp:setProperty property="concerned_officer" name="account" value="${param.concerned_officer}" />
<jsp:setProperty property="close_status" name="account" value="${param.close_status}" />
<jsp:setProperty property="activity_name" name="account" value="${param.activity_name}" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% AccountDao dao=new AccountDao();
dao.edit_account(account); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/account.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>