<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.List" %>
     <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ page import="classpackage.Proposal" %>
    <%@ page import="classpackage.AppliedlimitsDao" %>
    <%@ page import="classpackage.Appliedlimits" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Applied limits</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Applied limits</center></h2>
<form action="appliedlimits_details.jsp" method="post">

<%FacilityDao dao1=new FacilityDao();
List<Facility> facilitylist=dao1.get_all_facilities();
ProposalDao dao2=new ProposalDao();
List<Proposal> proposalslist=dao2.get_all_proposals();
AppliedlimitsDao dao3=new AppliedlimitsDao();
List<Appliedlimits> appliedlimitslist=dao3.get_all_appliedlimits();
%>

<b> New entry : </b> <br><br>

Enter proposal ID : <select name="pid">
<%for (int i=0;i<proposalslist.size();i++) { %>
<option> <%=proposalslist.get(i).getPid()%></option>
<%} %>
</select><br>

Enter facility :<select name="facility_name">
<%for (int i=0;i<facilitylist.size();i++) { %>
<option> <%=facilitylist.get(i).getFacility_name()%></option>
<%} %>
</select><br> 

Enter existing limit amount : <input type="text" name="existing_limit" value="0.00"/><br>
Enter proposed limit amount : <input type="text" name="proposed_limit" value="0.00"/><br>
Enter sanctioned limit amount (to be entered after sanction is approved): <input type="text" name="sanctioned_limit" value="0.00"/><br><br>


<input type="submit" name="btn_appliedlimits_add" value="Add" /><br><br>

<b> Edit entry : </b> <br><br>

Select ID of applied limit to be edited : 

<select name="edit_appliedlimits">
<%
for (int i=0;i<appliedlimitslist.size();i++) { %>
<option> <%=appliedlimitslist.get(i).getAlid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_appliedlimits_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select ID of applied limit to be deleted : <select name="delete_appliedlimits">
<%
for (int i=0;i<appliedlimitslist.size();i++) { %>
<option> <%=appliedlimitslist.get(i).getAlid()%></option>
<%} %>
</select>
<br><br>

<input type="submit" name="btn_appliedlimits_delete" value="Delete"><br><br>


<b> View all applied limits : </b> <br><br>
<input type="submit" name="btn_appliedlimits_view" value="View all" /><br><br>

</form>



</body>
</html>