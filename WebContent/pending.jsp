<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.List" %>
    <%@ page import="classpackage.PendingDao" %>
    <%@ page import="classpackage.Pending" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.PendingDao" %>
    <%@ page import="classpackage.Pending" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pending issues</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Pending issues</center></h2>
<form action="pending_details.jsp" method="post">

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
PendingDao dao2=new PendingDao();
List<Pending> pendinglist=dao2.get_all_pending();
%>

<b> New entry : </b> <br><br>

Enter account name : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>
Enter pending issue : <input type="text" name="pending_issue" /><br><br>
<input type="submit" name="btn_pending_add" value="Add" /><br><br>

<b> Edit entry : </b> <br><br>
Select ID of pending issue to be edited : <select name="edit_pending">
<%
for (int i=0;i<pendinglist.size();i++) { %>
<option value=<%=pendinglist.get(i).getPi_id()%>> <%=pendinglist.get(i).getPi_id()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_pending_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select ID of pending issue to be deleted : <select name="delete_pending">
<%
for (int i=0;i<pendinglist.size();i++) { %>
<option> <%=pendinglist.get(i).getPi_id()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_pending_delete" value="Delete"><br><br>


<b> View all pending issues : </b> <br><br>
<input type="submit" name="btn_pending_view" value="View all" /><br><br>

</form>



</body>
</html>