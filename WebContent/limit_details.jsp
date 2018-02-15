<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	<%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ page import="classpackage.LimitDao" %>
    <%@ page import="classpackage.Limit" %>    
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
<title>Limit details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="limit" class="classpackage.Limit" scope="request">

<jsp:setProperty property="lid" name="limit" value="${param.lid}" />
<jsp:setProperty property="aid" name="limit" value="${param.aid}" />
<jsp:setProperty property="facility_name" name="limit" value="${param.facility_name}" />
<jsp:setProperty property="sub_name" name="limit" value="${param.sub_name}" />
<jsp:setProperty property="limit" name="limit" value="${param.limit}" />
<jsp:setProperty property="cbs_no" name="limit" value="${param.cbs_no}" />
<jsp:setProperty property="sanction_ref" name="limit" value="${param.sanction_ref}" />
<fmt:parseDate var="parsedSanctionDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="sanction_date" name="limit" value="${parsedSanctionDate}"/>  
<fmt:parseDate var="parsedDueDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="due_date" name="limit" value="${parsedDueDate}"/>  
<jsp:setProperty property="sub_limit" name="limit" value="${param.sub_limit}" />
<jsp:setProperty property="branch" name="limit" value="${param.branch}" />
<jsp:setProperty property="dp" name="limit" value="${param.dp}" />
<jsp:setProperty property="roc_status" name="limit" value="${param.roc_status}" />
<jsp:setProperty property="fb_roi_pct" name="limit" value="${param.fb_roi_pct}" />
<jsp:setProperty property="basis" name="limit" value="${param.basis}" />
<jsp:setProperty property="spread_pct" name="limit" value="${param.spread_pct}" />
<jsp:setProperty property="term_premium" name="limit" value="${param.term_premium}" />
<jsp:setProperty property="finer" name="limit" value="${param.finer}" />
<jsp:setProperty property="nfb_fee_pct" name="limit" value="${param.nfb_fee_pct}" />
<jsp:setProperty property="sight_or_usance" name="limit" value="${param.sight_or_usance}" />
<jsp:setProperty property="nfb_period" name="limit" value="${param.nfb_period}" />

</jsp:useBean>

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
FacilityDao dao2=new FacilityDao();
List<Facility> facilitylist=dao2.get_all_facilities();
LimitDao dao3=new LimitDao();
List<Limit> limitlist=dao3.get_all_limits();
%>

<c:if test="${param.btn_limit_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao3.add_limit(limit); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/limit.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_limit_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String dellimit1 = (String) request.getParameter("delete_limit");
int dellimit2=Integer.parseInt(dellimit1);
%>

<%dao3.delete_limit(dellimit2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/limit.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_limit_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.LimitDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Limit ID</th>
    <th>Account</th> 
    <th>Facility</th>
    <th>Sub-name of facility</th>
    <th>Limit</th>
    <th>CBS no:</th>
    <th>Sanction reference</th>
    <th>Sanction date</th>
    <th>Due date</th>
    <th>Whether sub-limit</th>
    <th>Branch</th>
    <th>Drawing power</th>
    <th>ROC status</th>
    <th>Rate of interest (%)</th>
    <th>Basis</th>
    <th>Spread</th>
    <th>Term premium</th>
    <th>Whether finer rate</th>
    <th>Fee % for non-fund limit</th>
    <th>LC - sight or usance</th>
    <th>Period of LC/BG</th>
   
   </tr>
   
   <c:forEach items="${dao4._all_limits}" var="templimit">

   <tr>      
     
       <td><c:out value="${templimit.lid}"/> </td>
       
<sql:query var="result1" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${templimit.aid}" />
</sql:query>
<c:set var="aid" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${aid}"/> </td>
       
       <td><c:out value="${templimit.facility_name}"/> </td>
       <td><c:out value="${templimit.sub_name}"/> </td>
       <td><c:out value="${templimit.limit}"/> </td>
       <td><c:out value="${templimit.cbs_no}"/> </td>
       <td><c:out value="${templimit.sanction_ref}"/> </td>
      
       <fmt:formatDate var="formattedSanctionDate" value="${templimit.sanction_date}" dateStyle="medium"/>
       <td><c:out value="${formattedSanctionDate}"/> </td>
     
      <fmt:formatDate var="formattedDueDate" value="${templimit.due_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDueDate}"/> </td>
       
       <td><c:out value="${templimit.sub_limit}"/> </td>
       <td><c:out value="${templimit.branch}"/> </td>
       <td><c:out value="${templimit.dp}"/> </td>
       <td><c:out value="${templimit.roc_status}"/> </td>
       <td><c:out value="${templimit.fb_roi_pct}"/> </td>
       <td><c:out value="${templimit.basis}"/> </td>
       <td><c:out value="${templimit.spread_pct}"/> </td>
       <td><c:out value="${templimit.term_premium}"/> </td>
       <td><c:out value="${templimit.finer}"/> </td>
       <td><c:out value="${templimit.nfb_fee_pct}"/> </td>
       <td><c:out value="${templimit.sight_or_usance}"/> </td>
       <td><c:out value="${templimit.nfb_period}"/> </td>
    
           </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/limit.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_limit_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result2" dataSource="${dataSource}">
select * from limits where lid=?
<sql:param value="${param.edit_limit}" />
</sql:query>
<c:set var="returned_row" value="${result2.rowsByIndex[0]}" />



<form action="edit_limit.jsp" method="post">

<b> Edit entry : </b> <br><br>


Limit ID : <input type="text" readonly name="lid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>

<jsp:useBean id="dao5" class="classpackage.AccountDao" scope="request">
</jsp:useBean>
Enter account : <select name="aid">
<c:forEach items="${dao5._all_accounts}" var="temp1">

         <c:if test="${returned_row[1]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=$temp1.aid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>

<jsp:useBean id="dao6" class="classpackage.FacilityDao" scope="request">
</jsp:useBean>

Enter facility : <select name="facility_name">
<c:forEach items="${dao6._all_facilities}" var="temp2">

         <c:if test="${returned_row[2]==temp2.facility_name}">
          <option value="${temp2.facility_name}" selected="selected"> ${temp2.facility_name} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=$temp2.facility_name}">
          <option value="${temp2.facility_name}"> ${temp2.facility_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter sub-name of facility, if any : <input type="text" name="sub_name" value="<c:out value="${returned_row[3]}"/>" /><br>
Enter limit amount : <input type="text" name="limit" value="<c:out value="${returned_row[4]}"/>" /><br>
Enter CBS no: if available : <input type="text" name="cbs_no" value="<c:out value="${returned_row[5]}"/>" /><br>
Enter sanction reference : <input type="text" name="sanction_reference" value="<c:out value="${returned_row[6]}"/>" /><br>

Enter sanction date :
<c:set var="datecheck1" value="${returned_row[7]}" />

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


Enter due date :
<c:set var="datecheck1" value="${returned_row[8]}" />

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



Enter whether sub-limit : <select name="sub_limit">

<c:set var="sub_limit">Yes,No</c:set>
<c:forTokens items="${sub_limit}" delims="," var="temp3">
         <c:if test="${returned_row[9]==temp3}">
          <option value="${temp3}" selected="selected"> ${temp3} </option>
          </c:if>
          
          <c:if test="${returned_row[9]!=temp3}">
          <option value="${temp3}"> ${temp3} </option>
          </c:if>
</c:forTokens>

</select><br>

Enter branch : <input type="text" name="branch" value="<c:out value="${returned_row[10]}"/>" /><br>
Enter DP (drawing power) if applicable  : <input type="text" name="branch" value="<c:out value="${returned_row[11]}"/>" /><br>

Enter status of ROC : <select name="roc_status">

<c:set var="roc_status">Not applicable,Completed,Pending</c:set>
<c:forTokens items="${roc_status}" delims="," var="temp4">
         <c:if test="${returned_row[12]==temp4}">
          <option value="${temp4}" selected="selected"> ${temp4} </option>
          </c:if>
          
          <c:if test="${returned_row[12]!=temp4}">
          <option value="${temp4}"> ${temp4} </option>
          </c:if>
</c:forTokens>

</select><br>



Enter rate of interest (%) if it is fund based facility : <input type="text" name="fb_roi_pct" value="<c:out value="${returned_row[13]}"/>" /><br>

Enter basis : <select name="basis">

<c:set var="basis">Base rate,BMPLR,Others</c:set>
<c:forTokens items="${basis}" delims="," var="temp5">
         <c:if test="${returned_row[14]==temp5}">
          <option value="${temp5}" selected="selected"> ${temp5} </option>
          </c:if>
          
          <c:if test="${returned_row[14]!=temp5}">
          <option value="${temp5}"> ${temp5} </option>
          </c:if>
</c:forTokens>

</select><br>

Enter spread (%) over Base rate or BMPLR if it is fund based facility : <input type="text" name="spread_pct" value="<c:out value="${returned_row[15]}"/>" /><br>
Enter term premium (%) if applicable : <input type="text" name="term_premium" value="<c:out value="${returned_row[16]}"/>" /><br>
Enter whether finer rate of interest : <select name="finer">

<c:set var="finer">Yes,No</c:set>
<c:forTokens items="${finer}" delims="," var="temp6">
         <c:if test="${returned_row[17]==temp6}">
          <option value="${temp6}" selected="selected"> ${temp6} </option>
          </c:if>
          
          <c:if test="${returned_row[17]!=temp6}">
          <option value="${temp6}"> ${temp6} </option>
          </c:if>
</c:forTokens>

</select><br>

Enter fee (%) if it is non-fund based facility : <input type="text" name="nfb_fee_pct" value="<c:out value="${returned_row[18]}"/>" /><br>
Enter whether sight or usance, if it is LC facility : <select name="sight_or_usance">
<c:set var="sight_or_usance">Not applicable,Sight,Usance</c:set>
<c:forTokens items="${sight_or_usance}" delims="," var="temp7">
         <c:if test="${returned_row[19]==temp7}">
          <option value="${temp7}" selected="selected"> ${temp7} </option>
          </c:if>
          
          <c:if test="${returned_row[19]!=temp7}">
          <option value="${temp7}"> ${temp7} </option>
          </c:if>
</c:forTokens>

</select><br>

Enter period/ number of days if it is non-fund based facility : <input type="text" name="nfb_fee_pct" value="<c:out value="${returned_row[20]}"/>" /> days<br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>