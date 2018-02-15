<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.EmployeesDao" %>
    <%@ page import="classpackage.Employees" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
    <%@ page import="java.util.Map" %>
    <%@ page import="java.util.Date" %>
    
    <%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="classpackage.SubDepartmentDao" %>
    <%@ page import="classpackage.SubDepartment" %>
    <%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Details of employees</title>


</head>
<link href="style.css" rel="stylesheet" type="text/css">




<jsp:useBean id="employee" class="classpackage.Employees" scope="request">

<jsp:setProperty property="eid" name="employee" value="${param.eid}" />
<jsp:setProperty property="scale" name="employee" value="${param.scale}" />
<jsp:setProperty property="designation" name="employee" value="${param.designation}" />
<fmt:parseDate var="parsedHireDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="hire_date" name="employee" value="${parsedHireDate}"/>  
<jsp:setProperty property="reports_to" name="employee" value="${param.reports_to}" />
<jsp:setProperty property="emp_name" name="employee" value="${param.emp_name}" />
<jsp:setProperty property="discretionary_powers" name="employee" value="${param.discretionary_powers}" />
<jsp:setProperty property="sub_dept" name="employee" value="${dept_id}" />
</jsp:useBean>

<c:if test="${param.add_button=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">

<% EmployeesDao dao=new EmployeesDao();
dao.add_employee(employee); %>

<h3>Insertion of new record successful</h3>
<form action="/creditdept/sub_dept.jsp">
<input type="submit" value="Back" />
</form>
</c:if>

</c:if>



<c:if test="${param.delete_button=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="delemp1" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${param.delete_employee}" />
<c:set var="delemp2" value="${delemp1.rowsByIndex[0][0]}" />
</sql:query>

<%
String delemp = (String) pageContext.getAttribute("delemp2");
%>

<% EmployeesDao dao=new EmployeesDao();
dao.delete_employee(delemp); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/employees.jsp">
<input type="submit" value="Back">
</form>
</c:if>

</c:if>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<c:if test="${param.edit_button=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result3" dataSource="${dataSource}">
select * from employees where eid=?
<sql:param value="${param.edit_employee}" />
</sql:query>
<c:set var="returned_row" value="${result3.rowsByIndex[0]}" />

<form action="edit_employee.jsp" method="post">

<b> Edit entry : </b> <br><br>




Enter ID of employee : <input type="text" name="eid" value="${returned_row[0]}"/> <br>
Enter scale of employee : <input type="text" name="scale" value="<c:out value="${returned_row[1]}"/>" /><br>
Enter designation of employee : <input type="text" name="designation" value="<c:out value="${returned_row[2]}"/>" /><br>
Enter joining date of employee  : 



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
</select>

<br>
Enter name of employee : <input type="text" name="emp_name" value="<c:out value="${returned_row[5]}"/>" /><br>
Enter discretionary powers of employee (Rs. in lakh) : <input type="text" name="discretionary_powers" value="<c:out value="${returned_row[6]}"/>" /><br>
Enter reporting authority of the employee :

<jsp:useBean id="dao3" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>

<select name="reports_to">
<c:forEach items="${dao3._all_employees}" var="temp">

         <c:if test="${returned_row[4]==temp.eid}">
          <option value="${temp.eid}" selected="selected"> ${temp.emp_name} </option>
          </c:if>
          
          <c:if test="${returned_row[4]!=$temp.eid}">
          <option value="${temp.eid}"> ${temp.emp_name} </option>
          </c:if>

            </c:forEach>

</select>
<br>

<jsp:useBean id="dao4" class="classpackage.SubDepartmentDao" scope="request">
</jsp:useBean>

Enter sub-department of employee : <select name="sub_dept">
<c:forEach items="${dao4._all_subdepts}" var="temp">

          <c:if test="${returned_row[7]==temp.dept_id}">
          <option value="${temp.dept_id}" selected="selected"> ${temp.dept_name} </option>
          </c:if>
          
          <c:if test="${returned_row[7]!=$temp.dept_id}">
          <option value="${temp.dept_id}"> ${temp.dept_name} </option>
          </c:if>
          

            </c:forEach>


</select>
<br><br>
<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>





<c:if test="${param.view_button=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao1" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>


<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />

<table id="t01">
   <tr>
    <th>Employee ID</th>
    <th>Scale</th> 
    <th>Designation</th>
    <th>Joining date</th>
    <th>Reporting authority</th>
    <th>Employee name</th>
    <th>Discretionary powers (Rs. in lakh)</th>
    <th>Sub-department</th>
    
   </tr>
   
   <c:forEach items="${dao1._all_employees}" var="tempemployee">

   <tr>      
       <td><c:out value="${tempemployee.eid}"/> </td>
       <td><c:out value="${tempemployee.scale}"/> </td>
       <td><c:out value="${tempemployee.designation}"/> </td>
       <fmt:formatDate var="formattedDate" value="${tempemployee.hire_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDate}"/> </td>
       



<sql:query var="result1" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempemployee.reports_to}" />
</sql:query>
<c:set var="reports_to" value="${result1.rowsByIndex[0][0]}" />

	   <td><c:out value="${reports_to}"/> </td>
       <td><c:out value="${tempemployee.emp_name}"/> </td>
       
        <fmt:formatNumber var="formattedPowers" value="${tempemployee.discretionary_powers}" minFractionDigits="2"/>
       <td><c:out value="${formattedPowers}"/> </td>

<sql:query var="result2" dataSource="${dataSource}">
select dept_name from sub_department where dept_id=?
<sql:param value="${tempemployee.sub_dept}" />
</sql:query>
<c:set var="sub_dept" value="${result2.rowsByIndex[0][0]}" />


       <td><c:out value="${sub_dept}"/> </td>
   </tr>

</c:forEach>
   
</table>

<form action="/creditdept/employees.jsp">
<input type="submit" value="Back" />
</form>


</c:if>
</c:if>



</body>
</html>