<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.ActivityDao" %>
    <%@ page import="classpackage.Activity" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit activity</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<jsp:useBean id="activity" class="classpackage.Activity" scope="request">
<jsp:setProperty property="*" name="activity" />
</jsp:useBean>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<% ActivityDao dao=new ActivityDao();
dao.edit_activity(activity); %>

<h3>Updation of record successful</h3>
<form action="/creditdept/activity.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>

</body>
</html>