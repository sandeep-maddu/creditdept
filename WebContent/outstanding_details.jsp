<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.OutstandingDao" %>
    <%@ page import="classpackage.Outstanding" %>    
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
<title>Outstanding details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="outstanding" class="classpackage.Outstanding" scope="request">

<jsp:setProperty property="oid" name="outstanding" value="${param.oid}" />
<jsp:setProperty property="lid" name="outstanding" value="${param.lid}" />
<jsp:setProperty property="os" name="outstanding" value="${param.os}" />
<fmt:parseDate var="parsedOsDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="os_date" name="outstanding" value="${parsedOsDate}"/>  
</jsp:useBean>

<%
OutstandingDao dao1=new OutstandingDao();
List<Outstanding> outstandinglist=dao1.get_all_outstandings();
%>

<c:if test="${param.btn_outstanding_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao1.add_outstanding(outstanding); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/outstanding.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_outstanding_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delos1 = (String) request.getParameter("delete_outstanding");
int delos2=Integer.parseInt(delos1);
%>

<%dao1.delete_outstanding(delos2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/outstanding.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_outstanding_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao2" class="classpackage.OutstandingDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Outstanding ID</th>
    <th>Limit ID</th> 
    <th>Outstanding amount</th>
    <th>Date of outstanding</th>
   </tr>
   
   <c:forEach items="${dao2._all_outstandings}" var="tempoutstanding">

   <tr>      
       <td><c:out value="${tempoutstanding.oid}"/> </td>
       <td><c:out value="${tempoutstanding.lid}"/> </td>
       <td><c:out value="${tempoutstanding.os}"/> </td>
 
       <fmt:formatDate var="formattedOsDate" value="${tempoutstanding.os_date}" dateStyle="medium"/>
       <td><c:out value="${formattedOsDate}"/> </td>
       
       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/outstanding.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_outstanding_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result1" dataSource="${dataSource}">
select * from outstanding where oid=?
<sql:param value="${param.edit_outstanding}" />
</sql:query>
<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />



<form action="edit_outstanding.jsp" method="post">

<b> Edit entry : </b> <br><br>


Outstanding ID : <input type="text" readonly name="oid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>
Enter limit ID : 

<select name="lid">

<jsp:useBean id="dao3" class="classpackage.LimitDao" scope="request">
</jsp:useBean>

<c:forEach items="${dao3._all_limits}" var="temp1">

         <c:if test="${returned_row[1]==temp1.lid}">
          <option value="${temp1.lid}" selected="selected"> ${temp1.lid} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=$temp1.lid}">
          <option value="${temp1.lid}"> ${temp1.lid} </option>
          </c:if>

            </c:forEach>
</select><br>



Enter outstanding amount : <input type="text" name="os" value="<c:out value="${returned_row[2]}"/>" /><br>
Enter date of outstanding :
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