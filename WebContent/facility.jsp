<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Facilities</title>
</head>
<body> 
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Accounts</center></h2>
<form action="facility_details.jsp" method="post">

<%FacilityDao dao1=new FacilityDao();
List<Facility> facilitylist=dao1.get_all_facilities();%>

<b> New entry : </b> <br><br>
Enter facility name : <input type="text" name="facility_name" /><br>
Fund based or Non-fund based : <select name="fb_or_nfb">
<option>Fund based</option>
<option>Non-fund based</option>
</select><br>

Working capital or Term loan :<select name="wc_or_tl">
<option>Working capital</option>
<option>Term loan</option>
</select><br><br>

<input type="submit" name="btn_facility_add" value="Add" /><br><br>


<b> Edit entry : </b> <br><br>
Select facility to be edited : <select name="edit_facility">
<%
for (int i=0;i<facilitylist.size();i++) { %>
<option> <%=facilitylist.get(i).getFacility_name()%> </option> 
<%} %>
</select>
<br><br>

<input type="submit" name="btn_facility_edit" value="Edit"><br><br>



<b> Delete entry : </b> <br><br>
Select facilityto be deleted : <select name="delete_facility">
<%
for (int i=0;i<facilitylist.size();i++) { %>
<option> <%=facilitylist.get(i).getFacility_name()%> </option> 
<%} %>
</select>
<br><br>
<input type="submit" name="btn_facility_delete" value="Delete" /><br><br>

<b> View all facilities : </b> <br><br>
<input type="submit" name="btn_facility_view" value="View all" /><br><br>

</form>


</body>
</html>