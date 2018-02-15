<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AppliedlimitsDao" %>
    <%@ page import="classpackage.Appliedlimits" %>
    <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ page import="classpackage.ProposalDao" %>
    <%@ page import="classpackage.Proposal" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Applied limits</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="appliedlimits" class="classpackage.Appliedlimits" scope="request">
<jsp:setProperty property="facility_name" name="appliedlimits" value="${param.cust_id}" />
<jsp:setProperty property="existing_limit" name="appliedlimits" value="${param.cust_id}" />
<jsp:setProperty property="proposed_limit" name="appliedlimits" value="${param.cust_id}" />
<jsp:setProperty property="sanctioned_limit" name="appliedlimits" value="${param.cust_id}" />
<jsp:setProperty property="pid" name="appliedlimits" value="${param.cust_id}" />

</jsp:useBean>

<%FacilityDao dao1=new FacilityDao();
List<Facility> facilitylist=dao1.get_all_facilities();
ProposalDao dao2=new ProposalDao();
List<Proposal> proposalslist=dao2.get_all_proposals();
AppliedlimitsDao dao3=new AppliedlimitsDao();
List<Appliedlimits> appliedlimitslist=dao3.get_all_appliedlimits();
%>

<c:if test="${param.btn_appliedlimits_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%
String facility_name=(String) request.getParameter("facility_name");
String existing_limit1=(String) request.getParameter("existing_limit");
float existing_limit2=Float.parseFloat(existing_limit1);
String proposed_limit1=(String) request.getParameter("proposed_limit");
float proposed_limit2=Float.parseFloat(proposed_limit1);
String sanctioned_limit1=(String) request.getParameter("sanctioned_limit");
float sanctioned_limit2=Float.parseFloat(sanctioned_limit1);
String pid1=(String) request.getParameter("pid");
int pid2=Integer.parseInt(pid1);

dao3.add_appliedlimit(facility_name,existing_limit2,proposed_limit2,sanctioned_limit2,pid2); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/appliedlimits.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_appliedlimits_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<form action="edit_appliedlimits.jsp" method="post">

<%
String editappliedlimits1 = (String) request.getParameter("edit_appliedlimits");
int editappliedlimits2=Integer.parseInt(editappliedlimits1);
%>

<sql:query var="result1" dataSource="${dataSource}">
select * from applied_limits where alid=?
<sql:param value="<%=editappliedlimits2 %>" />
</sql:query>

<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

<input type="hidden" name="alid" value="${returned_row[0]}"><br><br>

<jsp:useBean id="dao5" class="classpackage.FacilityDao" scope="request">
</jsp:useBean>

Edit facility: <select name="facility_name">

<c:forEach items="${dao5._all_facilities}" var="temp1">

		  <c:if test="${returned_row[1]==temp1.facility_name}">
          <option value="${temp1.facility_name}" selected="selected"> ${temp1.facility_name} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=$temp1.facility_name}">
          <option value="${temp1.facility_name}"> ${temp1.facility_name} </option>
          </c:if>
          
            </c:forEach>
</select><br>

Edit existing limit amount :<input type="text" name="existing_limit" value=<c:out value="${returned_row[2]}" /> /><br>
Edit proposed limit amount :<input type="text" name="proposed_limit" value=<c:out value="${returned_row[3]}" /> /><br>
Edit sanctioned limit amount :<input type="text" name="sanctioned_limit" value=<c:out value="${returned_row[4]}" /> /><br>
Edit proposal ID :<input type="text" readonly name="pid" value=<c:out value="${returned_row[5]}" /> /> (system generated, cannot be changed) <br><br> 

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>
</c:if>
</c:if>


<c:if test="${param.btn_appliedlimits_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delappliedlimits1 = (String) request.getParameter("delete_appliedlimits");
int delappliedlimits2=Integer.parseInt(delappliedlimits1);
dao3.delete_appliedlimit(delappliedlimits2);
%>
<h3>Deletion of record successful</h3>
<form action="/creditdept/appliedlimits.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>



<c:if test="${param.btn_appliedlimits_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.AppliedlimitsDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Applied limit ID</th>
    <th>Facility</th> 
    <th>Existing limit</th>
    <th>Proposed limit</th>
    <th>Sanctioned limit</th>
    <th>Proposal ID</th>
   </tr>
   
   <c:forEach items="${dao4._all_appliedlimits}" var="tempappliedlimit">

   <tr>      
       <td><c:out value="${tempappliedlimit.alid}"/> </td>
       <td><c:out value="${tempappliedlimit.facility_name}"/> </td>
       <td><c:out value="${tempappliedlimit.existing_limit}"/> </td>
       <td><c:out value="${tempappliedlimit.proposed_limit}"/> </td>
       <td><c:out value="${tempappliedlimit.sanctioned_limit}"/> </td>
       <td><c:out value="${tempappliedlimit.pid}"/> </td>
       </tr>
       
</c:forEach>
</table><br><br>
<form action="/creditdept/appliedlimits.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


</body>
</html>