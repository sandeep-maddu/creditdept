<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.List" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.InsuranceDao" %>
    <%@ page import="classpackage.Insurance" %>
    <%@ page import="java.io.*,java.util.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insurance</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>Insurance</center></h2>
<form action="insurance_details.jsp" method="post">

<%
AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
InsuranceDao dao2=new InsuranceDao();
List<Insurance> insurancelist=dao2.get_all_insurances();
%>

<b> New entry : </b> <br><br>

Enter account : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>

Enter policy ID : <input type="text" name="policyid" /><br>
Enter insurance agency : <input type="text" name="agency" /><br>
Enter sum assured : <input type="text" name="sum_assured" value="0.00" /><br>
Enter due date of policy  : 

<select name="month">
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

<select name="day">

<c:forEach begin="1" end="31" var="day">
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year">
<c:forEach begin="1970" end="2025" var="year">
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br><br>

<input type="submit" name="btn_insurance_add" value="Add"><br><br>


<b> Edit entry : </b> <br><br>
Select insurance to be edited : <select name="edit_insurance">
<%
for (int i=0;i<insurancelist.size();i++) { %>
<option> <%=insurancelist.get(i).getPolicyid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_insurance_edit" value="Edit"><br><br>


<b> Delete entry : </b> <br><br>
Select insurance to be deleted : <select name="delete_insurance">
<%for (int i=0;i<insurancelist.size();i++) { %>
<option> <%=insurancelist.get(i).getPolicyid()%> </option> 
<%} %>
</select><br><br>

<input type="submit" name="btn_insurance_delete" value="Delete"><br><br>

<b> View all insurances : </b> <br><br>
<input type="submit" name="btn_insurance_view" value="View all"><br><br>

</form>



<body>

</body>
</html>