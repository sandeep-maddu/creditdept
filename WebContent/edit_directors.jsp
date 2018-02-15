<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.DirectorsDao" %>
    <%@ page import="classpackage.Directors" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit director</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<% 
String director_name = (String) request.getParameter("director_name");
String designation = (String) request.getParameter("designation");
String dirid1=(String) request.getParameter("dirid");
int dirid2 = Integer.parseInt(dirid1);
DirectorsDao dao=new DirectorsDao();
dao.edit_director(dirid2, director_name,designation);
%>

<h3>Updation of record successful</h3>
<form action="/creditdept/directors.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>

</body>
</html>