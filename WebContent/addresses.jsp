<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.List" %>
     <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.AddressesDao" %>
    <%@ page import="classpackage.Addresses" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Addresses</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Addresses</center></h2>
<form action="addresses_details.jsp" method="post">

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
AddressesDao dao2=new AddressesDao();
List<Addresses> addresseslist=dao2.get_all_addresses();
%>

<b> New entry : </b> <br><br>

Enter account name : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>
Enter category of address : <input type="text" name="sub_name" /><br>
Enter address : <input type="text" name="address" /><br><br>

<input type="submit" name="btn_addresses_add" value="Add" /><br><br>

<b> Edit entry : </b> <br><br>
Select ID of address to be edited : 

<select name="edit_addresses">
<%
for (int i=0;i<addresseslist.size();i++) { %>
<option value=<%=addresseslist.get(i).getAddid()%>> <%=addresseslist.get(i).getAddid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_addresses_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select ID of address to be deleted : <select name="delete_addresses">
<%
for (int i=0;i<addresseslist.size();i++) { %>
<option value=<%=addresseslist.get(i).getAddid()%>> <%=addresseslist.get(i).getAddid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_addresses_delete" value="Delete"><br><br>


<b> View all addresses : </b> <br><br>
<input type="submit" name="btn_addresses_view" value="View all" /><br><br>

</form>



</body>
</html>