<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.ExcessAdhocDao" %>
    <%@ page import="classpackage.ExcessAdhoc" %>    
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
<title>Excess drawals and Adhoc limit details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="excessadhoc" class="classpackage.ExcessAdhoc" scope="request">

<jsp:setProperty property="eid" name="excessadhoc" value="${param.eid}" />
<jsp:setProperty property="aid" name="excessadhoc" value="${param.aid}" />
<jsp:setProperty property="type" name="excessadhoc" value="${param.type}" />
<fmt:parseDate var="parsedAvailedOn" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="availed_on" name="excessadhoc" value="${parsedAvailedOn}"/>  
<jsp:setProperty property="limit" name="excessadhoc" value="${param.limit}" />
<jsp:setProperty property="number_of_days" name="excessadhoc" value="${param.number_of_days}" />
<fmt:parseDate var="parsedDueDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="due_date" name="excessadhoc" value="${parsedDueDate}"/> 
<jsp:setProperty property="times_since_last_renewal" name="excessadhoc" value="${param.times_since_last_renewal}" />
<fmt:parseDate var="parsedWhenActuallyAdjusted" parseLocale="en_US"  value="${param.month3} ${param.day3}, ${param.year3}"/>
<jsp:setProperty property="when_actually_adjusted" name="excessadhoc" value="${parsedWhenActuallyAdjusted}"/> 
<jsp:setProperty property="pct_over_regular_roi" name="excessadhoc" value="${param.pct_over_regular_roi}" />
<jsp:setProperty property="roc_status" name="excessadhoc" value="${param.roc_status}" />
</jsp:useBean>

<% AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
ExcessAdhocDao dao2=new ExcessAdhocDao();
List<ExcessAdhoc> excessadhoclist=dao2.get_all_excessadhocs();
%>

<c:if test="${param.btn_excessadhoc_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao2.add_excessadhoc(excessadhoc); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/excessadhoc.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_excessadhoc_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delexad1 = (String) request.getParameter("delete_excessadhoc");
int delexad2=Integer.parseInt(delexad1);
%>

<%dao2.delete_excessadhoc(delexad2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/excessadhoc.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_excessadhoc_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.ExcessAdhocDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Excess Adhoc ID</th>
    <th>Account</th> 
    <th>Facility</th>
    <th>Date on which availed</th>
    <th>Limit</th>
    <th>Number of days</th>
    <th>Due date</th>
    <th>Number of times since last renewal</th>
    <th>Date on which actually adjusted</th>
    <th>Rate over regular interest</th>
    <th>Status of ROC</th>
    </tr>
   
   <c:forEach items="${dao3._all_excessadhocs}" var="tempexcessadhoc">

   <tr>      

<td><c:out value="${tempexcessadhoc.eid}"/> </td>

<sql:query var="result1" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempexcessadhoc.aid}" />
</sql:query>
<c:set var="aid" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${aid}"/> </td>

       <td><c:out value="${tempexcessadhoc.type}"/> </td>
       <fmt:formatDate var="formattedAvailedOnDate" value="${tempexcessadhoc.availed_on}" dateStyle="medium"/>
       <td><c:out value="${formattedAvailedOnDate}"/> </td>
       <td><c:out value="${tempexcessadhoc.limit}"/> </td>
       <td><c:out value="${tempexcessadhoc.number_of_days}"/> </td>
       
       <fmt:formatDate var="formattedDueDate" value="${tempexcessadhoc.due_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDueDate}"/> </td>
       
       <td><c:out value="${tempexcessadhoc.times_since_last_renewal}"/> </td>
      
      <fmt:formatDate var="formattedWhenActuallyAdjusted" value="${tempexcessadhoc.when_actually_adjusted}" dateStyle="medium"/>
       <td><c:out value="${formattedWhenActuallyAdjusted}"/> </td>
      
       <td><c:out value="${tempexcessadhoc.pct_over_regular_roi}"/> </td>
       <td><c:out value="${tempexcessadhoc.roc_status}"/> </td>
       
       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/excessadhoc.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_excessadhoc_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result2" dataSource="${dataSource}">
select * from excess_adhoc where eid=?
<sql:param value="${param.edit_excessadhoc}" />
</sql:query>
<c:set var="returned_row" value="${result2.rowsByIndex[0]}" />

<form action="edit_excessadhoc.jsp" method="post">

<b> Edit entry : </b> <br><br>

ExcessAdhoc ID : <input type="text" readonly name="eid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>

Enter account : <select name="aid">

<jsp:useBean id="dao4" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

<c:forEach items="${dao4._all_accounts}" var="temp1">

         <c:if test="${returned_row[1]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=$temp1.aid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter facility  : <select name="type">

<c:set var="type">Excess drawal,Adhoc limit,Others</c:set>
<c:forTokens items="${type}" delims="," var="temp2">
         <c:if test="${returned_row[2]==temp2}">
          <option value="${temp2}" selected="selected"> ${temp2} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=temp2}">
          <option value="${temp2}"> ${temp2} </option>
          </c:if>
</c:forTokens>

</select><br>



Enter date on which availed :
<c:set var="datecheck1" value="${returned_row[3]}" />
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


<select name="month1">

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

<select name="day1">

<c:forEach begin="1" end="31" var="day">
<c:if test="${datecheck3==day}">
<option selected="selected"> <c:out value="${day}"/> </option>
</c:if>
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year1">
<c:forEach begin="1970" end="2025" var="year">
<c:if test="${datecheck4==year}">
<option selected="selected"> <c:out value="${year}"/> </option>
</c:if>
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>



Enter limit amount : <input type="text" name="limit" value="<c:out value="${returned_row[4]}"/>" /><br>
Enter number of days : <input type="text" name="number_of_days" value="<c:out value="${returned_row[5]}"/>" /><br>

Enter due date :
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


<select name="month2">

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

<select name="day2">

<c:forEach begin="1" end="31" var="day">
<c:if test="${datecheck3==day}">
<option selected="selected"> <c:out value="${day}"/> </option>
</c:if>
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year2">
<c:forEach begin="1970" end="2025" var="year">
<c:if test="${datecheck4==year}">
<option selected="selected"> <c:out value="${year}"/> </option>
</c:if>
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>


Enter number of times since last renewal : <input type="text" name="times_since_last_renewal" value="<c:out value="${returned_row[7]}"/>" /><br>

Enter date on which actually adjusted :
<c:set var="datecheck1" value="${returned_row[8]}" />

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


<select name="month3">

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

<select name="day3">

<c:forEach begin="1" end="31" var="day">
<c:if test="${datecheck3==day}">
<option selected="selected"> <c:out value="${day}"/> </option>
</c:if>
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year3">
<c:forEach begin="1970" end="2025" var="year">
<c:if test="${datecheck4==year}">
<option selected="selected"> <c:out value="${year}"/> </option>
</c:if>
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>

Enter rate over regular limit : <input type="text" name="pct_over_regular_roi" value="<c:out value="${returned_row[9]}"/>" /><br>

Enter status of ROC : <select name="roc_status">
<c:set var="roc_status">Excess drawal,Adhoc limit,Others</c:set>
<c:forTokens items="${roc_status}" delims="," var="temp3">
         <c:if test="${returned_row[10]==temp3}">
          <option value="${temp3}" selected="selected"> ${temp3} </option>
          </c:if>
          
          <c:if test="${returned_row[10]!=temp3}">
          <option value="${temp3}"> ${temp3} </option>
          </c:if>
</c:forTokens>

</select><br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>