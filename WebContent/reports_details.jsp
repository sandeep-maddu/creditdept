<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	<%@ page import="classpackage.ReportsDao" %>
    <%@ page import="classpackage.Reports" %>    
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
<title>Reports details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="report" class="classpackage.Reports" scope="request">
<jsp:setProperty property="*" name="report" />
</jsp:useBean>

<%
ReportsDao dao1=new ReportsDao();
List<Reports> reportlist=dao1.get_all_reports();
%>

<c:if test="${param.btn_report_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao1.add_report(report); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/reports.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_report_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delreport = (String) request.getParameter("delete_report");
dao1.delete_report(delreport); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/reports.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_report_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao2" class="classpackage.ReportsDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Report name</th>
    <th>Periodicity</th> 
   </tr>
   
   <c:forEach items="${dao2._all_reports}" var="tempreport">

   <tr>      
       <td><c:out value="${tempreport.report_name}"/> </td>
       <td><c:out value="${tempreport.periodicity}"/> </td>
       
   </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/reports.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_report_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result1" dataSource="${dataSource}">
select * from reports where report_name=?
<sql:param value="${param.edit_report}" />
</sql:query>
<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

<form action="edit_report.jsp" method="post">

<b> Edit entry : </b> <br><br>

Report name : <input type="text" readonly name="report_name" value="${returned_row[0]}"/> <br>

Enter periodicity : <select name="periodicity">
<c:set var="periodicity">Daily,Weekly,Fortnightly,Monthly,Once in two months,Quarterly,Half yearly,Annually,Once in two years,Once in three years</c:set>
<c:forTokens items="${periodicity}" delims="," var="temp1">
    
     <c:if test="${returned_row[1]==temp1}">
          <option value="${temp1}" selected="selected"> ${temp3} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=temp1}">
          <option value="${temp1}"> ${temp1} </option>
          </c:if>
    
</c:forTokens>

</select><br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>