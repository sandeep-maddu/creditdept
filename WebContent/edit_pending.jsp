<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.PendingDao" %>
    <%@ page import="classpackage.Pending" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit pending issue</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<% 
String pending_issue = (String) request.getParameter("pending_issue");
String pi_id1=(String) request.getParameter("pi_id");
int pi_id2 = Integer.parseInt(pi_id1);
PendingDao dao=new PendingDao();
dao.edit_pending(pi_id2, pending_issue);
%>

<h3>Updation of record successful</h3>
<form action="/creditdept/pending.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>

</body>
</html>