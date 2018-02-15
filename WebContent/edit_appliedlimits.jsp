<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AppliedlimitsDao" %>
    <%@ page import="classpackage.Appliedlimits" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit applied limit</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<jsp:useBean id="appliedlimits" class="classpackage.Appliedlimits" scope="request">
<jsp:setProperty property="alid" name="appliedlimits" value="${param.alid}" />
<jsp:setProperty property="facility_name" name="appliedlimits" value="${param.facility_name}" />
<jsp:setProperty property="existing_limit" name="appliedlimits" value="${param.existing_limit}" />
<jsp:setProperty property="proposed_limit" name="appliedlimits" value="${param.proposed_limit}" />
<jsp:setProperty property="sanctioned_limit" name="appliedlimits" value="${param.sanctioned_limit}" />
<jsp:setProperty property="pid" name="appliedlimits" value="${param.pid}" />

</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% AppliedlimitsDao dao=new AppliedlimitsDao();
dao.edit_appliedlimit(appliedlimits); 
%>


<h3>Updation of record successful</h3>
<form action="/creditdept/appliedlimits.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>

</body>
</html>