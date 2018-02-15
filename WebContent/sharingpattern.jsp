<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.List" %>
     <%@ page import="classpackage.BankingArrangementDao" %>
    <%@ page import="classpackage.BankingArrangement" %>
    <%@ page import="classpackage.SharingPatternDao" %>
    <%@ page import="classpackage.SharingPattern" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SharingPattern</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Sharing Pattern</center></h2>
<form action="sharingpattern_details.jsp" method="post">

<%BankingArrangementDao dao1=new BankingArrangementDao();
List<BankingArrangement> bankingarrangementlist=dao1.get_all_bankingarrangement();
SharingPatternDao dao2=new SharingPatternDao();
List<SharingPattern> sharingpatternslist=dao2.get_all_sharingpattern();
%>

<b> New entry : </b> <br><br>

Enter Banking Arrangement ID : <select name="bid">
<%for (int i=0;i<bankingarrangementlist.size();i++) { %>
<option> <%=bankingarrangementlist.get(i).getBid()%></option>
<%} %>
</select><br>

Enter bank : <input type="text" name="bank" /><br>
Enter limit amount : <input type="text" name="limit" /><br>
Enter percentage share : <input type="text" name="share_pct" /><br><br>

<input type="submit" name="btn_sharingpatterns_add" value="Add" /><br><br>

<b> Edit entry : </b> <br><br>
Select ID of sharing pattern to be edited : 

<select name="edit_sharingpatterns">
<%
for (int i=0;i<sharingpatternslist.size();i++) { %>
<option> <%=sharingpatternslist.get(i).getSpid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_sharingpatterns_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select ID of sharing pattern to be deleted : <select name="delete_sharingpatterns">
<%
for (int i=0;i<sharingpatternslist.size();i++) { %>
<option> <%=sharingpatternslist.get(i).getSpid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_sharingpatterns_delete" value="Delete"><br><br>


<b> View all sharing patterns : </b> <br><br>
<input type="submit" name="btn_sharingpatterns_view" value="View all" /><br><br>

</form>



</body>
</html>