<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AddressesDao" %>
    <%@ page import="classpackage.Addresses" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit address</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<% 
String sub_name = (String) request.getParameter("sub_name");
String address = (String) request.getParameter("address");
String addid1=(String) request.getParameter("addid");
int addid2 = Integer.parseInt(addid1);
AddressesDao dao=new AddressesDao();
dao.edit_address(addid2, sub_name,address);
%>

<h3>Updation of record successful</h3>
<form action="/creditdept/addresses.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>

</body>
</html>