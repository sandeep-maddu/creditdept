<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.SpecialconditionsDao" %>
    <%@ page import="classpackage.Specialconditions" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit special condition</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<% 
String condition = (String) request.getParameter("condition");
String cid1=(String) request.getParameter("cid");
int cid2 = Integer.parseInt(cid1);
SpecialconditionsDao dao=new SpecialconditionsDao();
dao.edit_specialconditions(cid2, condition);
%>

<h3>Updation of record successful</h3>
<form action="/creditdept/specialconditions.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>

</body>
</html>