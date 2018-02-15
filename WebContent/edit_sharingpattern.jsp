<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.SharingPatternDao" %>
    <%@ page import="classpackage.SharingPattern" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit sharing pattern</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<c:if test="${param.edit_submit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<% 
String spid1=(String) request.getParameter("spid");
int spid2=Integer.parseInt(spid1);
String bid1=(String) request.getParameter("bid");
int bid2=Integer.parseInt(bid1);
String bank=(String) request.getParameter("bank");
String limit1=(String) request.getParameter("limit");
float limit2=Float.parseFloat(limit1);
String share_pct1=(String) request.getParameter("share_pct");
float share_pct2=Float.parseFloat(share_pct1);

SharingPatternDao dao=new SharingPatternDao();
dao.edit_sharingpattern(spid2,bid2,bank,limit2,share_pct2);
%>

<h3>Updation of record successful</h3>
<form action="/creditdept/sharingpattern.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>

</body>
</html>