<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.List" %>
     <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.DirectorsDao" %>
    <%@ page import="classpackage.Directors" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Directors</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Directors</center></h2>
<form action="directors_details.jsp" method="post">

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
DirectorsDao dao2=new DirectorsDao();
List<Directors> directorslist=dao2.get_all_directors();
%>

<b> New entry : </b> <br><br>

Enter account name : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>
Enter name of director : <input type="text" name="director_name" /><br>
Enter designation of director : <input type="text" name="designation" /><br><br>

<input type="submit" name="btn_directors_add" value="Add" /><br><br>

<b> Edit entry : </b> <br><br>
Select ID of director to be edited : 

<select name="edit_directors">
<%
for (int i=0;i<directorslist.size();i++) { %>
<option value=<%=directorslist.get(i).getDirid()%>> <%=directorslist.get(i).getDirid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_directors_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select ID of director to be deleted : <select name="delete_directors">
<%
for (int i=0;i<directorslist.size();i++) { %>
<option value=<%=directorslist.get(i).getDirid()%>> <%=directorslist.get(i).getDirid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_directors_delete" value="Delete"><br><br>


<b> View all directors : </b> <br><br>
<input type="submit" name="btn_directors_view" value="View all" /><br><br>

</form>



</body>
</html>