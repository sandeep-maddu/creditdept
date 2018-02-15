<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	<%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ page import="classpackage.Proposal" %>    
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
<title>Proposal details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="proposal" class="classpackage.Proposal" scope="request">

<jsp:setProperty property="pid" name="proposal" value="${param.pid}" />
<jsp:setProperty property="internal_number" name="proposal" value="${param.internal_number}" />
<fmt:parseDate var="parsedReceiptDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="receipt_date" name="proposal" value="${parsedReceiptDate}"/>
<jsp:setProperty property="aid" name="proposal" value="${param.aid}" />
<jsp:setProperty property="handling_officer" name="proposal" value="${param.handling_officer}" />
</jsp:useBean>

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
AccountDao dao2=new AccountDao();
List<Account> accountlist=dao2.get_all_accounts();
ProposalDao dao3=new ProposalDao();
List<Proposal> proposallist=dao3.get_all_proposals();
%>

<c:if test="${param.btn_proposal_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao3.add_proposal(proposal); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/proposal.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_proposal_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delprop1 = (String) request.getParameter("delete_proposal");
int delprop2=Integer.parseInt(delprop1);
dao3.delete_proposal(delprop2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/proposal.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_proposal_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.ProposalDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Proposal ID</th>
    <th>Internal number</th> 
    <th>Date of reciept</th>
    <th>Account</th>
    <th>Handling officer</th>
   </tr>
   
   <c:forEach items="${dao4._all_proposals}" var="tempproposal">

   <tr>      
       <td><c:out value="${tempproposal.pid}"/> </td>
       <td><c:out value="${tempproposal.internal_number}"/> </td>
       
         <fmt:formatDate var="formattedReceiptDate" value="${tempproposal.receipt_date}" dateStyle="medium"/>
       <td><c:out value="${formattedReceiptDate}"/> </td>
       
       <sql:query var="result1" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempproposal.aid}" />
</sql:query>
<c:set var="aid" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${aid}"/> </td>
       
<sql:query var="result2" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempproposal.handling_officer}" />
</sql:query>
<c:set var="handling_officer" value="${result2.rowsByIndex[0][0]}" />
             
       <td><c:out value="${handling_officer}"/> </td>
       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/proposal.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>







<c:if test="${param.btn_proposal_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result3" dataSource="${dataSource}">
select * from proposal where pid=?
<sql:param value="${param.edit_proposal}" />
</sql:query>
<c:set var="returned_row" value="${result3.rowsByIndex[0]}" />

<form action="edit_proposal.jsp" method="post">

<b> Edit entry : </b> <br><br>

Proposal ID : <input type="text" readonly name="pid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>
Enter internal number of the proposal : <input type="text" name="internal_number" value="<c:out value="${returned_row[1]}"/>" /><br>

Enter receipt date of proposal :
<c:set var="datecheck1" value="${returned_row[2]}" />

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
</select><br>

<jsp:useBean id="dao7" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

Enter name of account : <select name="aid">
<c:forEach items="${dao7._all_accounts}" var="temp1">

         <c:if test="${returned_row[3]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[3]!=$temp1.eid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>

<jsp:useBean id="dao8" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

Enter officer who handles this proposal : <select name="handling_officer">
<c:forEach items="${dao8._all_employees}" var="temp2">

         <c:if test="${returned_row[4]==temp2.eid}">
          <option value="${temp2.eid}" selected="selected"> ${temp2.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[4]!=$temp2.eid}">
          <option value="${temp2.eid}"> ${temp2.emp_name} </option>
          </c:if>

            </c:forEach>
</select><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>