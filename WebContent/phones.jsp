<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.List" %>
     <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.PhonesDao" %>
    <%@ page import="classpackage.Phones" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Phones</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Phones</center></h2>
<form action="phones_details.jsp" method="post">

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
PhonesDao dao2=new PhonesDao();
List<Phones> phoneslist=dao2.get_all_phones();
%>

<b> New entry : </b> <br><br>

Enter account name : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>
Enter category of phone : <input type="text" name="sub_name" /><br>
Enter phone number : <input type="text" name="phone" /><br><br>

<input type="submit" name="btn_phones_add" value="Add" /><br><br>

<b> Edit entry : </b> <br><br>
Select ID of phone to be edited : 

<select name="edit_phones">
<%
for (int i=0;i<phoneslist.size();i++) { %>
<option value=<%=phoneslist.get(i).getPhid()%>> <%=phoneslist.get(i).getPhid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_phones_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select ID of phone to be deleted : <select name="delete_phones">
<%
for (int i=0;i<phoneslist.size();i++) { %>
<option value=<%=phoneslist.get(i).getPhid()%>> <%=phoneslist.get(i).getPhid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_phones_delete" value="Delete"><br><br>


<b> View all phones : </b> <br><br>
<input type="submit" name="btn_phones_view" value="View all" /><br><br>

</form>



</body>
</html>