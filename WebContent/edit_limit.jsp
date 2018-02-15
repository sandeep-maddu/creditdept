<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.LimitDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit limit</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="limit" class="classpackage.Limit" scope="request">

<jsp:setProperty property="lid" name="limit" value="${param.lid}" />
<jsp:setProperty property="aid" name="limit" value="${param.aid}" />
<jsp:setProperty property="facility_name" name="limit" value="${param.facility_name}" />
<jsp:setProperty property="sub_name" name="limit" value="${param.sub_name}" />
<jsp:setProperty property="limit" name="limit" value="${param.limit}" />
<jsp:setProperty property="cbs_no" name="limit" value="${param.cbs_no}" />
<jsp:setProperty property="sanction_ref" name="limit" value="${param.sanction_ref}" />
<fmt:parseDate var="parsedSanctionDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="sanction_date" name="limit" value="${parsedSanctionDate}"/>  
<fmt:parseDate var="parsedDueDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="due_date" name="limit" value="${parsedDueDate}"/>  
<jsp:setProperty property="sub_limit" name="limit" value="${param.sub_limit}" />
<jsp:setProperty property="branch" name="limit" value="${param.branch}" />
<jsp:setProperty property="dp" name="limit" value="${param.dp}" />
<jsp:setProperty property="roc_status" name="limit" value="${param.roc_status}" />
<jsp:setProperty property="fb_roi_pct" name="limit" value="${param.fb_roi_pct}" />
<jsp:setProperty property="basis" name="limit" value="${param.basis}" />
<jsp:setProperty property="spread_pct" name="limit" value="${param.spread_pct}" />
<jsp:setProperty property="term_premium" name="limit" value="${param.term_premium}" />
<jsp:setProperty property="finer" name="limit" value="${param.finer}" />
<jsp:setProperty property="nfb_fee_pct" name="limit" value="${param.nfb_fee_pct}" />
<jsp:setProperty property="sight_or_usance" name="limit" value="${param.sight_or_usance}" />
<jsp:setProperty property="nfb_period" name="limit" value="${param.nfb_period}" />

</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% LimitDao dao=new LimitDao();
dao.edit_limit(limit); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/limit.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>