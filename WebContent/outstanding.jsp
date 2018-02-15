<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.LimitDao" %>
    <%@ page import="classpackage.Limit" %>
    <%@ page import="classpackage.OutstandingDao" %>
    <%@ page import="classpackage.Outstanding" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Outstanding</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Outstanding</center></h2>
<form action="outstanding_details.jsp" method="post">

<%
OutstandingDao dao1=new OutstandingDao();
List<Outstanding> outstandinglist=dao1.get_all_outstandings();
LimitDao dao2=new LimitDao();
List<Limit> limitslist=dao2.get_all_limits();
%>

<b> New entry : </b> <br><br>

Enter ID of limit :<select name="lid">
<%for (int i=0;i<limitslist.size();i++) { %>
<option> <%=limitslist.get(i).getLid() %></option>
<%} %>
</select> <br>

Enter outstanding amount :<input type="text" name="os" /><br> 
Enter date of outstanding  : 

<select name="month">
<option value="Jan">January</option>
<option value="Feb">February</option>
<option value="Mar">March</option>
<option value="Apr">April</option>
<option value="May">May</option>
<option value="Jun">June</option>
<option value="Jul">July</option>
<option value="Aug">August</option>
<option value="Sep">September</option>
<option value="Oct">October</option>
<option value="Nov">November</option>
<option value="Dec">December</option>
</select>

<select name="day">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br><br>

<input type="submit" name="btn_outstanding_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select outstanding ID to be edited : <select name="edit_outstanding">
<%
for (int i=0;i<outstandinglist.size();i++) { %>
<option> <%=outstandinglist.get(i).getOid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_outstanding_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select outstanding ID to be deleted : <select name="delete_outstanding">
<%for (int i=0;i<outstandinglist.size();i++) { %>
<option> <%=outstandinglist.get(i).getOid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_outstanding_delete" value="Delete"><br><br>

<b> View all outstandings : </b> <br><br>
<input type="submit" name="btn_outstanding_view" value="View all"><br><br>

</form>

<body>

</body>
</html>