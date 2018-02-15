<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	<%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="classpackage.SubDepartmentDao" %>
    <%@ page import="classpackage.SubDepartment" %>
    <%@ page import="classpackage.ActivityDao" %>
    <%@ page import="classpackage.Activity" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>    
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
<title>Account details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="account" class="classpackage.Account" scope="request">

<jsp:setProperty property="aid" name="account" value="${param.aid}" />
<jsp:setProperty property="cust_id" name="account" value="${param.cust_id}" />
<jsp:setProperty property="account_name" name="account" value="${param.account_name}" />
<jsp:setProperty property="subdept" name="account" value="${param.subdept}" />
<jsp:setProperty property="file_no" name="account" value="${param.file_no}" />
<jsp:setProperty property="powers" name="account" value="${param.powers}" />
<jsp:setProperty property="asset_classf" name="account" value="${param.asset_classf}" />
<fmt:parseDate var="parsedIncorpDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="incorp_date" name="account" value="${parsedIncorpDate}"/>  
<jsp:setProperty property="constitution" name="account" value="${param.constitution}" />
<jsp:setProperty property="chief_exec" name="account" value="${param.chief_exec}" />
<fmt:parseDate var="parsedDealingSince" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="dealing_since" name="account" value="${parsedDealingSince}"/> 
<jsp:setProperty property="concerned_officer" name="account" value="${param.concerned_officer}" />
<jsp:setProperty property="close_status" name="account" value="${param.close_status}" />
<jsp:setProperty property="activity_name" name="account" value="${param.activity_name}" />
</jsp:useBean>

<%EmployeesDao dao1=new EmployeesDao();
List<Employees> emplist=dao1.get_all_employees();
SubDepartmentDao dao2=new SubDepartmentDao();
List<SubDepartment> subdeptlist=dao2.get_all_subdepts();
ActivityDao dao3=new ActivityDao();
List<Activity> activitylist=dao3.get_all_activities();
AccountDao dao4=new AccountDao();
List<Account> accountlist=dao4.get_all_accounts();
%>

<c:if test="${param.btn_account_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao4.add_account(account); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/account.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_account_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delacc1 = (String) request.getParameter("delete_account");
int delacc2=Integer.parseInt(delacc1);
%>

<%dao4.delete_account(delacc2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/account.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_account_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao5" class="classpackage.AccountDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Account ID</th>
    <th>CBS Customer ID</th> 
    <th>Account name</th>
    <th>Sub department</th>
    <th>File number</th>
    <th>Powers</th>
    <th>Asset classification</th>
    <th>Date of incorporation</th>
    <th>Constitution</th>
    <th>Chief Executive</th>
    <th>Dealing since</th>
    <th>Concerned officer</th>
    <th>Existing or closed</th>
    <th>Activity</th>
   </tr>
   
   <c:forEach items="${dao5._all_accounts}" var="tempaccount">

   <tr>      
       <td><c:out value="${tempaccount.aid}"/> </td>
       <td><c:out value="${tempaccount.cust_id}"/> </td>
       <td><c:out value="${tempaccount.account_name}"/> </td>
       
<sql:query var="result1" dataSource="${dataSource}">
select dept_name from sub_department where dept_id=?
<sql:param value="${tempaccount.subdept}" />
</sql:query>
<c:set var="subdept" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${subdept}"/> </td>
       <td><c:out value="${tempaccount.file_no}"/> </td>
       
<sql:query var="result2" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempaccount.powers}" />
</sql:query>
<c:set var="powers" value="${result2.rowsByIndex[0][0]}" />
             
       <td><c:out value="${powers}"/> </td>
       <td><c:out value="${tempaccount.asset_classf}"/> </td>
      
       <fmt:formatDate var="formattedIncorpDate" value="${tempaccount.incorp_date}" dateStyle="medium"/>
       <td><c:out value="${formattedIncorpDate}"/> </td>
       
       <td><c:out value="${tempaccount.constitution}"/> </td>
       <td><c:out value="${tempaccount.chief_exec}"/> </td>
       
       <fmt:formatDate var="formattedDealingSince" value="${tempaccount.dealing_since}" dateStyle="medium"/>
       <td><c:out value="${formattedDealingSince}"/> </td>
       
<sql:query var="result3" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempaccount.concerned_officer}" />
</sql:query>
<c:set var="concerned_officer" value="${result3.rowsByIndex[0][0]}" />
             
       <td><c:out value="${concerned_officer}"/> </td>
       
       <td><c:out value="${tempaccount.close_status}"/> </td>
       <td><c:out value="${tempaccount.activity_name}"/> </td>

       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/account.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>







<c:if test="${param.btn_account_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result4" dataSource="${dataSource}">
select * from accounts where aid=?
<sql:param value="${param.edit_account}" />
</sql:query>
<c:set var="returned_row" value="${result4.rowsByIndex[0]}" />



<form action="edit_account.jsp" method="post">

<b> Edit entry : </b> <br><br>


Account ID : <input type="text" readonly name="aid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>
Enter CBS customer ID if applicable : <input type="text" name="cust_id" value="<c:out value="${returned_row[1]}"/>" /><br>
Enter name of the account : <input type="text" name="account_name" value="<c:out value="${returned_row[2]}"/>" /><br>
Enter sub-department  : <select name="subdept">

<jsp:useBean id="dao6" class="classpackage.SubDepartmentDao" scope="request">
</jsp:useBean>

<c:forEach items="${dao6._all_subdepts}" var="temp1">

         <c:if test="${returned_row[3]==temp1.dept_id}">
          <option value="${temp1.dept_id}" selected="selected"> ${temp1.dept_name} </option>
          </c:if>
          
          <c:if test="${returned_row[3]!=$temp1.dept_id}">
          <option value="${temp1.dept_id}"> ${temp1.dept_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter file number : <input type="text" name="file_no" value="<c:out value="${returned_row[4]}"/>" /><br>

<jsp:useBean id="dao7" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

Enter powers under whom the account falls : <select name="powers">
<c:forEach items="${dao7._all_employees}" var="temp2">

         <c:if test="${returned_row[5]==temp2.eid}">
          <option value="${temp2.eid}" selected="selected"> ${temp2.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[5]!=$temp2.eid}">
          <option value="${temp2.eid}"> ${temp2.emp_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter asset classification : <select name="asset_classf">
<c:set var="assetclass">Standard,Substandard,Doubtful,Loss</c:set>
<c:forTokens items="${assetclass}" delims="," var="temp3">
    
     <c:if test="${returned_row[6]==temp3}">
          <option value="${temp3}" selected="selected"> ${temp3} </option>
          </c:if>
          
          <c:if test="${returned_row[6]!=temp3}">
          <option value="${temp3}"> ${temp3} </option>
          </c:if>
    
</c:forTokens>

</select><br>


Enter constitution  : <select name="constitution">

<c:set var="constitution">Sole proprietorship,Partnership,Private limited company,Public limited company</c:set>
<c:forTokens items="${constitution}" delims="," var="temp4">
         <c:if test="${returned_row[7]==temp4}">
          <option value="${temp4}" selected="selected"> ${temp4} </option>
          </c:if>
          
          <c:if test="${returned_row[7]!=temp4}">
          <option value="${temp4}"> ${temp4} </option>
          </c:if>
</c:forTokens>

</select><br>

Enter Chief Executive of the company : <input type="text" name="chief_exec" value="<c:out value="${returned_row[8]}"/>" /><br>

<jsp:useBean id="dao8" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

Enter officer who handles this account : <select name="concerned_officer">
<c:forEach items="${dao8._all_employees}" var="temp5">

         <c:if test="${returned_row[9]==temp5.eid}">
          <option value="${temp5.eid}" selected="selected"> ${temp5.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[9]!=$temp5.eid}">
          <option value="${temp5.eid}"> ${temp5.emp_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter whether account is closed or existing :  <select name="close_status">
<c:set var="close_status">Existing,Closed</c:set>
<c:forTokens items="${close_status}" delims="," var="temp5">
         <c:if test="${returned_row[10]==temp5}">
          <option value="${temp5}" selected="selected"> ${temp5} </option>
          </c:if>
          
          <c:if test="${returned_row[10]!=temp5}">
          <option value="${temp5}"> ${temp5} </option>
          </c:if>
</c:forTokens>
</select><br>

<jsp:useBean id="dao9" class="classpackage.ActivityDao" scope="request">
</jsp:useBean>

Enter activity :  <select name="activity_name">
<c:forEach items="${dao9._all_activities}" var="temp6">

         <c:if test="${returned_row[11]==temp6.activity_name}">
          <option value="${temp6.activity_name}" selected="selected"> ${temp6.activity_name} </option>
          </c:if>
          
          <c:if test="${returned_row[11]!=$temp6.activity_name}">
          <option value="${temp6.activity_name}"> ${temp6.activity_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter date of incorporation :
<c:set var="datecheck1" value="${returned_row[12]}" />

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


Enter date since company is dealing with bank :

<c:set var="datecheck1" value="${returned_row[13]}" />
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
</select><br><br>



<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>



</c:if>
</c:if>





</body>
</html>