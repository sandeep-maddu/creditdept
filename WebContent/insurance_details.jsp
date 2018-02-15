<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.InsuranceDao" %>
    <%@ page import="classpackage.Insurance" %>    
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
<title>Insurance details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="insurance" class="classpackage.Insurance" scope="request">

<jsp:setProperty property="policyid" name="insurance" value="${param.policyid}" />
<jsp:setProperty property="agency" name="insurance" value="${param.agency}" />
<jsp:setProperty property="sum_assured" name="insurance" value="${param.sum_assured}" />
<fmt:parseDate var="parsedPolicyDueDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="policy_duedate" name="insurance" value="${parsedPolicyDueDate}"/>  
<jsp:setProperty property="aid" name="insurance" value="${param.aid}" />
</jsp:useBean>

<%
AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
InsuranceDao dao2=new InsuranceDao();
List<Insurance> insurancelist=dao2.get_all_insurances();
%>

<c:if test="${param.btn_insurance_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao2.add_insurance(insurance); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/insurance.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_insurance_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delins= (String) request.getParameter("delete_insurance");
%>

<%dao2.delete_insurance(delins); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/insurance.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_insurance_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.InsuranceDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Account</th>
    <th>Policy ID</th> 
    <th>Agency</th>
    <th>Sum assured</th>
    <th>Due date of policy</th>
    </tr>
   
   <c:forEach items="${dao3._all_insurances}" var="tempinsurance">

   <tr>      

<sql:query var="result1" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempinsurance.aid}" />
</sql:query>
<c:set var="aid" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${aid}"/> </td>
       <td><c:out value="${tempinsurance.policyid}"/> </td>
       <td><c:out value="${tempinsurance.agency}"/> </td>
       <td><c:out value="${tempinsurance.sum_assured}"/> </td>
       
       <fmt:formatDate var="formattedPolicyDueDate" value="${tempinsurance.policy_duedate}" dateStyle="medium"/>
       <td><c:out value="${formattedPolicyDueDate}"/> </td>
      
              </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/insurance.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_insurance_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result2" dataSource="${dataSource}">
select * from insurance where policyid=?
<sql:param value="${param.edit_insurance}" />
</sql:query>
<c:set var="returned_row" value="${result2.rowsByIndex[0]}" />

<form action="edit_insurance.jsp" method="post">

<b> Edit entry : </b> <br><br>

<jsp:useBean id="dao4" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

Enter account : <select name="aid">
<c:forEach items="${dao4._all_accounts}" var="temp1">

         <c:if test="${returned_row[4]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[4]!=$temp1.aid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Policy ID : <input type="text" name="policyid" value="${returned_row[0]}"/> <br>
Insurance agency : <input type="text" name="agency" value="${returned_row[1]}"/> <br>
Sum assured : <input type="text" name="sum_assured" value="${returned_row[2]}"/> <br>

Enter due date of policy :

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