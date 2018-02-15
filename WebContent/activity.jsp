<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="classpackage.ActivityDao" %>
    <%@ page import="classpackage.Activity" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Activity</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Activity</center></h2>
<form action="activity_details.jsp" method="post">



<b> New entry : </b> <br><br>
Enter activity name : <input type="text" name="activity_name" /><br>
Enter activity description : <input type="text" name="description" /><br>
Enter industry : <input type="text" name="industry" /><br><br>
<input type="submit" name="btn_activity_add" value="Add" /><br><br>


<b> Edit entry : </b> <br><br>
Select activity to be edited : <select name="edit_activity">
<%
ActivityDao dao1=new ActivityDao();
List<Activity> actvlist1=dao1.get_all_activities();
for (int i=0;i<actvlist1.size();i++) { %>
<option> <%=actvlist1.get(i).getActivity_name()%> </option> 
<%} %>
</select>
<br><br>

<input type="submit" name="btn_activity_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select activity to be deleted : <select name="delete_activity">
<%
ActivityDao dao2=new ActivityDao();
List<Activity> actvlist2=dao2.get_all_activities();
for (int i=0;i<actvlist2.size();i++) { %>
<option> <%=actvlist2.get(i).getActivity_name()%> </option> 
<%} %>
</select>
<br><br>
<input type="submit" name="btn_activity_delete" value="Delete" /><br><br>

<b> View all activities : </b> <br><br>
<input type="submit" name="btn_activity_view" value="View all" /><br><br>

</form>

</body>
</html>