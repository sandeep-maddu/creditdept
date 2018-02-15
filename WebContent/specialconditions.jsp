<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.List" %>
    <%@ page import="classpackage.SanctionDao" %>
    <%@ page import="classpackage.Sanction" %>
    <%@ page import="classpackage.SpecialconditionsDao" %>
    <%@ page import="classpackage.Specialconditions" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Special conditions</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Special conditions</center></h2>
<form action="specialconditions_details.jsp" method="post">

<%SanctionDao dao1=new SanctionDao();
List<Sanction> sanctionlist=dao1.get_all_sanctions();
SpecialconditionsDao dao2=new SpecialconditionsDao();
List<Specialconditions> specialconditionslist=dao2.get_all_specialconditions();
%>

<b> New entry : </b> <br><br>

Enter sanction ID : <select name="sid">
<%for (int i=0;i<sanctionlist.size();i++) { %>
<option><%=sanctionlist.get(i).getSid()%></option>
<%} %>
</select><br>
Enter special condition : <textarea name="condition" rows="4" cols="25"></textarea><br><br>
<input type="submit" name="btn_specialconditions_add" value="Add" /><br><br>

<b> Edit entry : </b> <br><br>
Select ID of special condition to be edited : <select name="edit_specialconditions">
<%
for (int i=0;i<specialconditionslist.size();i++) { %>
<option> <%=specialconditionslist.get(i).getCid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_specialconditions_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select ID of special condition to be deleted : <select name="delete_specialconditions">
<%
for (int i=0;i<specialconditionslist.size();i++) { %>
<option> <%=specialconditionslist.get(i).getCid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_specialconditions_delete" value="Delete"><br><br>


<b> View all special conditions : </b> <br><br>
<input type="submit" name="btn_specialconditions_view" value="View all" /><br><br>

</form>



</body>
</html>