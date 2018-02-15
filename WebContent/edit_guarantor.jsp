<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.GuarantorDao" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit guarantor</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">


<jsp:useBean id="guarantor" class="classpackage.Guarantor" scope="request">

<jsp:setProperty property="gid" name="guarantor" value="${param.gid}" />
<jsp:setProperty property="aid" name="guarantor" value="${param.aid}" />
<jsp:setProperty property="guarantor_name" name="guarantor" value="${param.guarantor_name}" />
<jsp:setProperty property="designation" name="guarantor" value="${param.designation}" />
<jsp:setProperty property="networth" name="guarantor" value="${param.networth}" />
<jsp:setProperty property="networth_basis" name="guarantor" value="${param.networth_basis}" />
<fmt:parseDate var="parsedNetworthDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="networth_date" name="guarantor" value="${parsedNetworthDate}"/>  
</jsp:useBean>


<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% GuarantorDao dao=new GuarantorDao();
dao.edit_guarantor(guarantor); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/guarantor.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>
<body>

</body>
</html>