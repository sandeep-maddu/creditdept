<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.ProjectDao" %>
    <%@ page import="classpackage.Project" %>    
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
<title>Project details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="project" class="classpackage.Project" scope="request">

<jsp:setProperty property="project_id" name="project" value="${param.project_id}" />
<jsp:setProperty property="aid" name="project" value="${param.aid}" />
<jsp:setProperty property="description" name="project" value="${param.description}" />
<jsp:setProperty property="project_cost" name="project" value="${param.project_cost}" />
<fmt:parseDate var="parsedEnvisagedCod" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="envisaged_cod" name="project" value="${parsedEnvisagedCod}"/>  
<fmt:parseDate var="parsedNpaTriggerDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="npa_trigger_date" name="project" value="${parsedNpaTriggerDate}"/>  
<jsp:setProperty property="status" name="project" value="${param.status}" />
<jsp:setProperty property="remarks" name="project" value="${param.remarks}" />
</jsp:useBean>

<% AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
ProjectDao dao2=new ProjectDao();
List<Project> projectlist=dao2.get_all_projects();
%>

<c:if test="${param.btn_project_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao2.add_project(project); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/project.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_project_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delproj1 = (String) request.getParameter("delete_project");
int delproj2=Integer.parseInt(delproj1);
%>

<%dao2.delete_project(delproj2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/project.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_project_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.ProjectDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Project ID</th>
    <th>Account</th> 
    <th>Description</th>
    <th>Project cost</th>
    <th>Envisaged DCCO</th>
    <th>NPA trigger date</th>
    <th>Project status</th>
    <th>Remarks</th>
    </tr>
   
   <c:forEach items="${dao3._all_projects}" var="tempproject">

   <tr>      
       <td><c:out value="${tempproject.project_id}"/> </td>
       
<sql:query var="result1" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempproject.aid}" />
</sql:query>
<c:set var="aid" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${aid}"/> </td>

       
       <td><c:out value="${tempproject.description}"/> </td>
       <td><c:out value="${tempproject.project_cost}"/> </td>
       
       <fmt:formatDate var="formattedEnvisagedCod" value="${tempproject.envisaged_cod}" dateStyle="medium"/>
       <td><c:out value="${formattedEnvisagedCod}"/> </td>
       
       <fmt:formatDate var="formattedNpaTriggerDate" value="${tempproject.npa_trigger_date}" dateStyle="medium"/>
       <td><c:out value="${formattedNpaTriggerDate}"/> </td>
       
       <td><c:out value="${tempproject.status}"/> </td>
       <td><c:out value="${tempproject.remarks}"/> </td>
       
       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/project.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_project_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result2" dataSource="${dataSource}">
select * from projects where project_id=?
<sql:param value="${param.edit_project}" />
</sql:query>
<c:set var="returned_row" value="${result2.rowsByIndex[0]}" />



<form action="edit_project.jsp" method="post">

<b> Edit entry : </b> <br><br>


Project ID : <input type="text" readonly name="project_id" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>

<jsp:useBean id="dao4" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

Enter account : <select name="aid">
<c:forEach items="${dao4._all_accounts}" var="temp1">

         <c:if test="${returned_row[1]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=$temp1.aid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>


Enter description of project : <textarea name="description" rows="4" cols="25"><c:out value="${returned_row[2]}"/></textarea><br>
Enter project cost : <input type="text" name="project_cost" value="<c:out value="${returned_row[3]}"/>" /><br>

Enter date of envisaged DCCO :
<c:set var="datecheck1" value="${returned_row[4]}" />

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



Enter date on which account becomes NPA if project is not completed :
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


Enter status of project implementation : <select name="status">

<c:set var="status">Under implementation,Completed</c:set>
<c:forTokens items="${status}" delims="," var="temp2">
         <c:if test="${returned_row[6]==temp2}">
          <option value="${temp2}" selected="selected"> ${temp2} </option>
          </c:if>
          
          <c:if test="${returned_row[6]!=temp2}">
          <option value="${temp2}"> ${temp2} </option>
          </c:if>
</c:forTokens>

</select><br><br>

Enter remarks : <input type="text" name="remarks" value="<c:out value="${returned_row[7]}"/>" /><br><br>


<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>



</c:if>
</c:if>





</body>
</html>