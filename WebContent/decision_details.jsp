<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	 <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.DecisionDao" %>
    <%@ page import="classpackage.Decision" %>    
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
<title>Decision details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="decision" class="classpackage.Decision" scope="request">

<jsp:setProperty property="did" name="decision" value="${param.did}" />
<fmt:parseDate var="parsedDecisionDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="decision_date" name="decision" value="${parsedDecisionDate}"/>  
<jsp:setProperty property="approving_authority" name="decision" value="${param.approving_authority}" />
<jsp:setProperty property="aid" name="decision" value="${param.aid}" />
<jsp:setProperty property="letter_ref" name="decision" value="${param.letter_ref}" />
<fmt:parseDate var="parsedReceivedOn" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="received_on" name="decision" value="${parsedReceivedOn}"/>  
<jsp:setProperty property="review_authority" name="decision" value="${param.review_authority}" />
</jsp:useBean>

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
AccountDao dao2=new AccountDao();
List<Account> proposallist=dao2.get_all_accounts();
DecisionDao dao3=new DecisionDao();
List<Decision> decisionlist=dao3.get_all_decisions();
%>


<c:if test="${param.btn_decision_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao3.add_decision(decision); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/decision.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_decision_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String deldec1 = (String) request.getParameter("delete_decision");
int deldec2=Integer.parseInt(deldec1);
%>

<%dao3.delete_decision(deldec2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/decision.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_decision_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.DecisionDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Account</th>
    <th>Decision ID</th>
    <th>Date of decision</th> 
    <th>Approving authority</th>
    <th>Decision letter reference</th>
	<th>Date on which request received</th>
    <th>Reviewing authority</th>
    </tr>
   
   <c:forEach items="${dao4._all_decisions}" var="tempdecision">

   <tr>      
       <td><c:out value="${tempdecision.aid}"/> </td>
       <td><c:out value="${tempdecision.did}"/> </td>

        <fmt:formatDate var="formattedDecisionDate" value="${tempdecision.decision_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDecisionDate}"/> </td>
       
<sql:query var="result1" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempdecision.approving_authority}" />
</sql:query>
<c:set var="approving_authority" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${approving_authority}"/> </td>
       <td><c:out value="${tempdecision.letter_ref}"/> </td>

        <fmt:formatDate var="formattedReceivedOn" value="${tempdecision.received_on}" dateStyle="medium"/>
       <td><c:out value="${formattedReceivedOn}"/> </td>

       
<sql:query var="result2" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempdecision.review_authority}" />
</sql:query>
<c:set var="review_authority" value="${result2.rowsByIndex[0][0]}" />
             
       <td><c:out value="${review_authority}"/> </td>
       
       
       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/decision.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_decision_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result3" dataSource="${dataSource}">
select * from decisions where did=?
<sql:param value="${param.edit_decision}" />
</sql:query>
<c:set var="returned_row" value="${result3.rowsByIndex[0]}" />

<form action="edit_decision.jsp" method="post">

<b> Edit entry : </b> <br><br>


Decision ID : <input type="text" readonly name="did" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>

<jsp:useBean id="dao5" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

Enter account : <select name="aid">
<c:forEach items="${dao5._all_accounts}" var="temp1">

         <c:if test="${returned_row[3]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[3]!=$temp1.aid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter date of decision :
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


<jsp:useBean id="dao6" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

Enter approving authority : <select name="approving_authority">
<c:forEach items="${dao6._all_employees}" var="temp1">

         <c:if test="${returned_row[2]==temp1.eid}">
          <option value="${temp1.eid}" selected="selected"> ${temp1.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=$temp1.eid}">
          <option value="${temp1.eid}"> ${temp1.emp_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Decision letter reference : <input type="text" name="letter_ref" value="${returned_row[4]}"/> <br>

Enter date on which request was received :
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


<jsp:useBean id="dao7" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

Enter review authority : <select name="review_authority">
<c:forEach items="${dao7._all_employees}" var="temp2">

         <c:if test="${returned_row[6]==temp2.eid}">
          <option value="${temp2.eid}" selected="selected"> ${temp2.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[6]!=$temp2.eid}">
          <option value="${temp2.eid}"> ${temp2.emp_name} </option>
          </c:if>

            </c:forEach>
</select><br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>