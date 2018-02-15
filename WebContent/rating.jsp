<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.RatingDao" %>
    <%@ page import="classpackage.Rating" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ratings</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Ratings</center></h2>
<form action="rating_details.jsp" method="post">

<%FacilityDao dao1=new FacilityDao();
List<Facility> facilitylist=dao1.get_all_facilities();
AccountDao dao2=new AccountDao();
List<Account> accountlist=dao2.get_all_accounts();
RatingDao dao3=new RatingDao();
List<Rating> ratinglist=dao3.get_all_ratings();
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


Enter rating agency : <input type="text" name="agency" /><br>
Enter rating : <input type="text" name="rating" /><br>
Enter rating model: <input type="text" name="rating_model" /><br>
Enter description : <input type="text" name="description" /><br>

Enter balance sheet date on which rating is based  : 

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


Enter whether the above balance sheet is audited or provisional : <select name="basedon_audited" >
<option>Audited</option>
<option>Provisional</option>
</select><br>

Enter date till which rating is valid : 

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
</select><br><br>


<input type="submit" name="btn_rating_add" value="Add"><br><br>



<b> Edit entry : </b> <br><br>
Select ID of rating to be edited : <select name="edit_rating">
<%
for (int i=0;i<ratinglist.size();i++) { %>
<option> <%=ratinglist.get(i).getRid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_rating_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select ID of rating to be deleted : <select name="delete_rating">
<%for (int i=0;i<ratinglist.size();i++) { %>
<option> <%=ratinglist.get(i).getRid()%> </option>
<%} %>
</select><br><br>

<input type="submit" name="btn_rating_delete" value="Delete"><br><br>

<b> View all ratings : </b> <br><br>
<input type="submit" name="btn_rating_view" value="View all"><br><br>

</form>



<body>

</body>
</html>