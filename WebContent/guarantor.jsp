<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.GuarantorDao" %>
    <%@ page import="classpackage.Guarantor" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Guarantors</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Guarantors</center></h2>
<form action="guarantor_details.jsp" method="post">

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
GuarantorDao dao2=new GuarantorDao();
List<Guarantor> guarantorlist=dao2.get_all_guarantors();
%>

<b> New entry : </b> <br><br>

Enter account : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid()%>"> <%=accountlist.get(i).getAccount_name() %></option>
<%} %>
</select> <br>


Enter name of guarantor : <input type="text" name="guarantor_name"/><br>
Enter deignation of guarantor : <input type="text" name="designation"/><br>
Enter networth of guarantor : <input type="text" name="networth"/><br>
Enter basis document of networth : <input type="text" name="networth_basis"/><br>

Enter date of networth : 

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

<input type="submit" name="btn_guarantor_add" value="Add"><br><br>

<b> Edit entry : </b> <br><br>
Select guarantor to be edited : <select name="edit_guarantor">
<%
for (int i=0;i<guarantorlist.size();i++) { %>
<option> <%=guarantorlist.get(i).getGid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_guarantor_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select guarantor to be deleted : <select name="delete_guarantor">
<%for (int i=0;i<guarantorlist.size();i++) { %>
<option> <%=guarantorlist.get(i).getGid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_guarantor_delete" value="Delete"><br><br>

<b> View all securities : </b> <br><br>
<input type="submit" name="btn_guarantor_view" value="View all"><br><br>

</form>



<body>

</body>
</html>