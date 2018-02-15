<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.GuarantorDao" %>
    <%@ page import="classpackage.Guarantor" %>    
    <%@ page import="java.util.List" %>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
    <%@ page import="java.util.Map" %>
    <%@ page import="java.util.Date" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Guarantor details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="guarantor" class="classpackage.Guarantor" scope="request">

<jsp:setProperty property="gid" name="guarantor" value="${param.gid}" />
<jsp:setProperty property="aid" name="guarantor" value="${param.aid}" />
<jsp:setProperty property="guarantor_name" name="guarantor" value="${param.guarantor_name}" />
<jsp:setProperty property="designation" name="guarantor" value="${param.designation}" />
<jsp:setProperty property="networth" name="guarantor" value="${param.networth}" />
<jsp:setProperty property="networth_basis" name="guarantor" value="${param.networth_basis}" />
<fmt:parseDate var="parsedNetworthDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="networth_date" name="guarantor" value="${parsedNetworthDate}"/>  
</jsp:useBean>

<%
AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
GuarantorDao dao2=new GuarantorDao();
List<Guarantor> guarantorlist=dao2.get_all_guarantors();
%>

<c:if test="${param.btn_guarantor_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao2.add_guarantor(guarantor); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/guarantor.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_guarantor_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delguarantor1 = (String) request.getParameter("delete_guarantor");
int delguarantor2=Integer.parseInt(delguarantor1);
%>

<%dao2.delete_guarantor(delguarantor2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/guarantor.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_guarantor_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.GuarantorDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Guarantor ID</th>
    <th>Account</th> 
    <th>Name of guarantor</th>
    <th>Designation</th>
    <th>Networth</th>
    <th>Basis document for networth</th>
    <th>Date of Networth</th>
   </tr>
   
   <c:forEach items="${dao3._all_guarantors}" var="tempguarantor">

   <tr>      

<td><c:out value="${tempguarantor.gid}"/> </td>

<sql:query var="result1" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempguarantor.aid}" />
</sql:query>
<c:set var="aid" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${aid}"/> </td>
       
       
       <td><c:out value="${tempguarantor.guarantor_name}"/> </td>
       <td><c:out value="${tempguarantor.designation}"/> </td>
       <td><c:out value="${tempguarantor.networth}"/> </td>
       <td><c:out value="${tempguarantor.networth_basis}"/> </td>
       
       <fmt:formatDate var="formattedNetworthDate" value="${tempguarantor.networth_date}" dateStyle="medium"/>
       <td><c:out value="${formattedNetworthDate}"/> </td>
       
       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/guarantor.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_guarantor_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result2" dataSource="${dataSource}">
select * from guarantors where gid=?
<sql:param value="${param.edit_guarantor}" />
</sql:query>
<c:set var="returned_row" value="${result2.rowsByIndex[0]}" />



<form action="edit_guarantor.jsp" method="post">

<b> Edit entry : </b> <br><br>


Guarantor ID : <input type="text" readonly name="gid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>

<jsp:useBean id="dao4" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

Enter account  : <select name="aid">

<c:forEach items="${dao4._all_accounts}" var="temp1">

         <c:if test="${returned_row[1]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=$temp1.aid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter name of guarantor : <input type="text" name="guarantor_name" value="<c:out value="${returned_row[2]}"/>" /><br>
Enter designation of guarantor : <input type="text" name="designation" value="<c:out value="${returned_row[3]}"/>" /><br>
Enter networth of guarantor : <input type="text" name="networth" value="<c:out value="${returned_row[4]}"/>" /><br>
Enter basis document for networth : <input type="text" name="networth_basis" value="<c:out value="${returned_row[5]}"/>" /><br>


Enter date of networth :

<c:set var="datecheck1" value="${returned_row[6]}" />

<fmt:formatDate var="datecheck2" value="${datecheck1}" dateStyle="medium" />

<c:if test="${fn:length(datecheck2)==12}">
<c:set var="datecheck3" value="${fn:substring(datecheck2,4,6)}" />
<c:set var="datecheck4" value="${fn:substring(datecheck2,8,12)}" />
<c:set var="datecheck5" value="${fn:substring(datecheck2,0,3)}" />
</c:if>

<c:if test="${fn:length(datecheck2)==11}">
<c:set var="datecheck3" value="${fn:substring(datecheck2,4,5)}" />
<c:set var="datecheck4" value="${fn:substring(datecheck2,7,11)}" />
<c:set var="datecheck5" value="${fn:substring(datecheck2,0,3)}" />
</c:if>


<select name="month">

<c:if test="${datecheck5=='Jan'}" >
<option selected="selected" value="${datecheck5}"><c:out value="January"/></option>
</c:if>

<c:if test="${datecheck5=='Feb'}" >
<option selected="selected" value="${datecheck5}"><c:out value="February"/></option>
</c:if>

<c:if test="${datecheck5=='Mar'}" >
<option selected="selected" value="${datecheck5}"><c:out value="March"/></option>
</c:if>

<c:if test="${datecheck5=='Apr'}" >
<option selected="selected" value="${datecheck5}"><c:out value="April"/></option>
</c:if>

<c:if test="${datecheck5=='May'}" >
<option selected="selected" value="${datecheck5}"><c:out value="May"/></option>
</c:if>

<c:if test="${datecheck5=='Jun'}" >
<option selected="selected" value="${datecheck5}"><c:out value="June"/></option>
</c:if>

<c:if test="${datecheck5=='Jul'}" >
<option selected="selected" value="${datecheck5}"><c:out value="July"/></option>
</c:if>

<c:if test="${datecheck5=='Aug'}" >
<option selected="selected" value="${datecheck5}"><c:out value="August"/></option>
</c:if>

<c:if test="${datecheck5=='Sep'}" >
<option selected="selected" value="${datecheck5}"><c:out value="September"/></option>
</c:if>

<c:if test="${datecheck5=='Oct'}" >
<option selected="selected" value="${datecheck5}"><c:out value="October"/></option>
</c:if>

<c:if test="${datecheck5=='Nov'}" >
<option selected="selected" value="${datecheck5}"><c:out value="November"/></option>
</c:if>

<c:if test="${datecheck5=='Dec'}" >
<option selected="selected" value="${datecheck5}"><c:out value="December"/></option>
</c:if>


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
<c:if test="${datecheck3==day}">
<option selected="selected"> <c:out value="${day}"/> </option>
</c:if>
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year">
<c:forEach begin="1970" end="2025" var="year">
<c:if test="${datecheck4==year}">
<option selected="selected"> <c:out value="${year}"/> </option>
</c:if>
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>