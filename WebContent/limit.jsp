<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ page import="classpackage.LimitDao" %>
    <%@ page import="classpackage.Limit" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Limits</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Limits</center></h2>
<form action="limit_details.jsp" method="post">

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
FacilityDao dao2=new FacilityDao();
List<Facility> facilitylist=dao2.get_all_facilities();
LimitDao dao3=new LimitDao();
List<Limit> limitlist=dao3.get_all_limits();
%>

<b> New entry : </b> <br><br>

Enter account : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid()%>"> <%=accountlist.get(i).getAccount_name() %></option>
<%} %>
</select> <br>

Enter facility : <select name="facility_name">
<%for (int i=0;i<facilitylist.size();i++) { %>
<option> <%=facilitylist.get(i).getFacility_name() %></option>
<%} %>
</select> <br>

Enter sub-name of facility, if any : <input type="text" name="sub_name" value="Regular"/><br>
Enter limit amount : <input type="text" name="limit" /><br>
Enter CBS number of the facility if available : <input type="text" name="cbs_no" /><br>
Enter sanction reference : <input type="text" name="sanction_ref" /><br>

Enter sanction date  : 

<select name="month1">
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

<select name="day1">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year1">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>


Enter due date  : 

<select name="month2">
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

<select name="day2">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year2">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>

Enter whether sub-limit : <select name="sub_limit">
<option>Yes</option>
<option selected="selected">No</option>
</select> <br>

Enter branch : <input type="text" name="branch" /><br>
Enter DP (drawing power) if fund-based or OD (overdue) if term loan : <input type="text" name="dp" /><br>

Enter status of ROC : <select name="roc_status">
<option>Not applicable</option>
<option>Completed</option>
<option>Pending</option>
</select> <br>

Enter rate of interest (%) if it is fund based facility : <input type="text" name="fb_roi_pct" /><br>
Enter basis : <select name="basis">
<option>Base rate</option>
<option>BMPLR</option>
<option>Others</option>
</select> <br>

Enter spread (%) over Base rate or BMPLR if it is fund based facility : <input type="text" name="spread_pct" /><br>
Enter term premium (%) if applicable : <input type="text" name="spread_pct" /><br>

Enter whether finer rate of interest : <select name="finer">
<option>Yes</option>
<option selected="selected">No</option>
</select> <br>

Enter fee (%) if it is non-fund based facility : <input type="text" name="nfb_fee_pct" /><br>

Enter whether sight or usance, if it is LC facility : <select name="sight_or_usance">
<option>Not applicable</option>
<option>Sight</option>
<option>Usance</option>
</select> <br>

Enter number of days (period of LC/BG) if it is non-fund based facility : <input type="text" name="nfb_period" /> days<br><br>

<input type="submit" name="btn_limit_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select limit to be edited : <select name="edit_limit">
<%
for (int i=0;i<limitlist.size();i++) { %>
<option> <%=limitlist.get(i).getLid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_limit_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select limit to be deleted : <select name="delete_limit">
<%for (int i=0;i<limitlist.size();i++) { %>
<option> <%=limitlist.get(i).getLid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_limit_delete" value="Delete"><br><br>

<b> View all limits : </b> <br><br>
<input type="submit" name="btn_limit_view" value="View all"><br><br>

</form>



<body>

</body>
</html>