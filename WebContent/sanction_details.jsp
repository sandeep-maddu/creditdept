<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	 <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ page import="classpackage.Proposal" %>
    <%@ page import="classpackage.SanctionDao" %>
    <%@ page import="classpackage.Sanction" %>    
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
<title>Sanction details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="sanction" class="classpackage.Sanction" scope="request">

<jsp:setProperty property="sid" name="sanction" value="${param.sid}" />
<fmt:parseDate var="parsedSanctionDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="sanction_date" name="sanction" value="${parsedSanctionDate}"/>  
<jsp:setProperty property="sanction_authority" name="sanction" value="${param.sanction_authority}" />
<jsp:setProperty property="sanction_letter_ref" name="sanction" value="${param.sanction_letter_ref}" />
<jsp:setProperty property="reviewing_authority" name="sanction" value="${param.reviewing_authority}" />
<fmt:parseDate var="parsedControlFormSentOn" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="control_form_sent_on" name="sanction" value="${parsedControlFormSentOn}"/>  
<fmt:parseDate var="parsedCmrdQueriesReceivedOn" parseLocale="en_US"  value="${param.month3} ${param.day3}, ${param.year3}"/>
<jsp:setProperty property="cmrd_queries_received_on" name="sanction" value="${parsedCmrdQueriesReceivedOn}"/>  
<fmt:parseDate var="parsedCmrdReplySentOn" parseLocale="en_US"  value="${param.month4} ${param.day4}, ${param.year4}"/>
<jsp:setProperty property="cmrd_reply_sent_on" name="sanction" value="${parsedCmrdReplySentOn}"/>  
<jsp:setProperty property="admin_clearance" name="sanction" value="${param.admin_clearance}" />
<jsp:setProperty property="confirmation" name="sanction" value="${param.confirmation}" />
<jsp:setProperty property="pid" name="sanction" value="${param.pid}" />
</jsp:useBean>

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
ProposalDao dao2=new ProposalDao();
List<Proposal> proposallist=dao2.get_all_proposals();
SanctionDao dao3=new SanctionDao();
List<Sanction> sanctionlist=dao3.get_all_sanctions();
%>


<c:if test="${param.btn_sanction_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao3.add_sanction(sanction); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/sanction.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_sanction_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delsanc1 = (String) request.getParameter("delete_sanction");
int delsanc2=Integer.parseInt(delsanc1);
%>

<%dao3.delete_sanction(delsanc2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/sanction.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_sanction_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.SanctionDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Sanction ID</th>
    <th>Date of sanction</th> 
    <th>Sanctioning authority</th>
    <th>Sanction letter reference</th>
    <th>Reviewing authority</th>
    <th>Date on which control form sent</th>
    <th>Date on which CMRD queries received</th>
    <th>Date on which reply to CMRD queries sent</th>
    <th>Administrative clearance</th>
    <th>Confirmation</th>
    <th>Proposal ID</th>
    </tr>
   
   <c:forEach items="${dao4._all_sanctions}" var="tempsanction">

   <tr>      
       <td><c:out value="${tempsanction.sid}"/> </td>
       
        <fmt:formatDate var="formattedSanctionDate" value="${tempsanction.sanction_date}" dateStyle="medium"/>
       <td><c:out value="${formattedSanctionDate}"/> </td>
       
       <sql:query var="result1" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempsanction.sanction_authority}" />
</sql:query>
<c:set var="sanction_authority" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${sanction_authority}"/> </td>
       <td><c:out value="${tempsanction.sanction_letter_ref}"/> </td>
       
        <sql:query var="result2" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempsanction.reviewing_authority}" />
</sql:query>
<c:set var="reviewing_authority" value="${result2.rowsByIndex[0][0]}" />
             
       <td><c:out value="${reviewing_authority}"/> </td>
       
         <fmt:formatDate var="formattedControlFormSentOn" value="${tempsanction.control_form_sent_on}" dateStyle="medium"/>
       <td><c:out value="${formattedControlFormSentOn}"/> </td>
       
       <fmt:formatDate var="formattedCmrdQueriesReceivedOn" value="${tempsanction.cmrd_queries_received_on}" dateStyle="medium"/>
       <td><c:out value="${formattedCmrdQueriesReceivedOn}"/> </td>
       
       <fmt:formatDate var="formattedCmrdReplySentOn" value="${tempsanction.cmrd_reply_sent_on}" dateStyle="medium"/>
       <td><c:out value="${formattedCmrdReplySentOn}"/> </td>
       
       <td><c:out value="${tempsanction.admin_clearance}"/> </td>
       <td><c:out value="${tempsanction.confirmation}"/> </td>
       <td><c:out value="${tempsanction.pid}"/> </td>
       
       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/sanction.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_sanction_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result3" dataSource="${dataSource}">
select * from sanctions where sid=?
<sql:param value="${param.edit_sanction}" />
</sql:query>
<c:set var="returned_row" value="${result3.rowsByIndex[0]}" />

<form action="edit_sanction.jsp" method="post">

<b> Edit entry : </b> <br><br>


Sanction ID : <input type="text" readonly name="sid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>

Enter date of sanction :
<c:set var="datecheck1" value="${returned_row[1]}" />

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


<jsp:useBean id="dao5" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

Enter sanctioning authority : <select name="sanction_authority">
<c:forEach items="${dao5._all_employees}" var="temp1">

         <c:if test="${returned_row[2]==temp1.eid}">
          <option value="${temp1.eid}" selected="selected"> ${temp1.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=$temp1.eid}">
          <option value="${temp1.eid}"> ${temp1.emp_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Sanction letter reference : <input type="text" name="sanction_letter_ref" value="${returned_row[3]}"/> <br>

<jsp:useBean id="dao6" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

Enter reviewing authority : <select name="reviewing_authority">
<c:forEach items="${dao6._all_employees}" var="temp2">

         <c:if test="${returned_row[4]==temp2.eid}">
          <option value="${temp2.eid}" selected="selected"> ${temp2.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[4]!=$temp2.eid}">
          <option value="${temp2.eid}"> ${temp2.emp_name} </option>
          </c:if>

            </c:forEach>
</select><br>


Enter date on which control form was sent on :
<c:set var="datecheck1" value="${returned_row[5]}" />

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


Enter date on which CMRD queries received :
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


Enter date on which reply to CMRD queries was sent :
<c:set var="datecheck1" value="${returned_row[7]}" />

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


<select name="month4">

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

<select name="day4">

<c:forEach begin="1" end="31" var="day">
<c:if test="${datecheck3==day}">
<option selected="selected"> <c:out value="${day}"/> </option>
</c:if>
<option><c:out value="${day}"/></option>
</c:forEach>
</select>

<select name="year4">
<c:forEach begin="1970" end="2025" var="year">
<c:if test="${datecheck4==year}">
<option selected="selected"> <c:out value="${year}"/> </option>
</c:if>
<option><c:out value="${year}"/></option>
</c:forEach>
</select><br>

Enter administrative clearance : <select name="admin_clearance">

<c:set var="admin_clearance">Not applicable,Taken,Not taken</c:set>
<c:forTokens items="${admin_clearance}" delims="," var="temp3">
         <c:if test="${returned_row[8]==temp3}">
          <option value="${temp3}" selected="selected"> ${temp3} </option>
          </c:if>
          
          <c:if test="${returned_row[8]!=temp3}">
          <option value="${temp3}"> ${temp3} </option>
          </c:if>
</c:forTokens>

</select><br>

Enter confirmation details (if powers of sanction are not vested with authority who sanctioned the limit) : <select name="confirmation">

<c:set var="confirmation">Not applicable,Taken,Not taken</c:set>
<c:forTokens items="${confirmation}" delims="," var="temp4">
         <c:if test="${returned_row[9]==temp4}">
          <option value="${temp4}" selected="selected"> ${temp4} </option>
          </c:if>
          
          <c:if test="${returned_row[9]!=temp4}">
          <option value="${temp4}"> ${temp4} </option>
          </c:if>
</c:forTokens>

</select><br>

Enter proposal ID : <input type="text" name="pid" value="${returned_row[10]}"/> <br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>