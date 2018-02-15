<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	 <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ page import="classpackage.Proposal" %>
    <%@ page import="classpackage.DeclineDao" %>
    <%@ page import="classpackage.Decline" %>    
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
<title>Decline details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="decline" class="classpackage.Decline" scope="request">

<jsp:setProperty property="did" name="decline" value="${param.did}" />
<fmt:parseDate var="parsedDeclineDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="decline_date" name="decline" value="${parsedDeclineDate}"/>  
<jsp:setProperty property="decline_authority" name="decline" value="${param.decline_authority}" />
<jsp:setProperty property="decline_letter_ref" name="decline" value="${param.decline_letter_ref}" />
<jsp:setProperty property="reasons" name="decline" value="${param.reasons}" />
<jsp:setProperty property="report_higher" name="decline" value="${param.report_higher}" />
<jsp:setProperty property="pid" name="decline" value="${param.pid}" />
</jsp:useBean>

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
ProposalDao dao2=new ProposalDao();
List<Proposal> proposallist=dao2.get_all_proposals();
DeclineDao dao3=new DeclineDao();
List<Decline> declinelist=dao3.get_all_declines();
%>


<c:if test="${param.btn_decline_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao3.add_decline(decline); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/decline.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_decline_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String deldecl1 = (String) request.getParameter("delete_decline");
int deldecl2=Integer.parseInt(deldecl1);
%>

<%dao3.delete_decline(deldecl2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/decline.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_decline_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.DeclineDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Decline ID</th>
    <th>Date of decline</th> 
    <th>Decline authority</th>
    <th>Decline letter reference</th>
    <th>Reasons</th>
    <th>Whether decline to be reported to higher autority</th>
    <th>Proposal ID</th>
    </tr>
   
   <c:forEach items="${dao4._all_declines}" var="tempdecline">

   <tr>      
       <td><c:out value="${tempdecline.did}"/> </td>
       
        <fmt:formatDate var="formattedDeclineDate" value="${tempdecline.decline_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDeclineDate}"/> </td>
       
       <sql:query var="result1" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempdecline.decline_authority}" />
</sql:query>
<c:set var="decline_authority" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${decline_authority}"/> </td>
       <td><c:out value="${tempdecline.decline_letter_ref}"/> </td>
       
       <td><c:out value="${tempdecline.reasons}"/> </td>
       <td><c:out value="${tempdecline.report_higher}"/> </td>
       <td><c:out value="${tempdecline.pid}"/> </td>
       
       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/decline.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_decline_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result3" dataSource="${dataSource}">
select * from declines where did=?
<sql:param value="${param.edit_decline}" />
</sql:query>
<c:set var="returned_row" value="${result3.rowsByIndex[0]}" />

<form action="edit_decline.jsp" method="post">

<b> Edit entry : </b> <br><br>


Decline ID : <input type="text" readonly name="did" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>

Enter date of decline :
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


<jsp:useBean id="dao5" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

Enter decline authority : <select name="decline_authority">
<c:forEach items="${dao5._all_employees}" var="temp1">

         <c:if test="${returned_row[2]==temp1.eid}">
          <option value="${temp1.eid}" selected="selected"> ${temp1.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=$temp1.eid}">
          <option value="${temp1.eid}"> ${temp1.emp_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Decline letter reference : <input type="text" name="decline_letter_ref" value="${returned_row[3]}"/> <br>

Enter reasons for decline :<textarea name="reasons" rows="4" cols="25">${returned_row[4]}</textarea><br> 

Enter whether decline is to be reported to higher authority : : <select name="report_higher">

<c:set var="report_higher">Not applicable,Required,Not required</c:set>
<c:forTokens items="${report_higher}" delims="," var="temp2">
         <c:if test="${returned_row[5]==temp2}">
          <option value="${temp2}" selected="selected"> ${temp2} </option>
          </c:if>
          
          <c:if test="${returned_row[5]!=temp2}">
          <option value="${temp2}"> ${temp2} </option>
          </c:if>
</c:forTokens>

</select><br>

Enter proposal ID : <input type="text" name="pid" value="${returned_row[6]}"/> <br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>