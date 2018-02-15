<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	<%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ page import="classpackage.BankingArrangementDao" %>
    <%@ page import="classpackage.BankingArrangement" %>    
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
<title>Banking Arrangement details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="bankingarrangement" class="classpackage.BankingArrangement" scope="request">

<jsp:setProperty property="bid" name="bankingarrangement" value="${param.bid}" />
<jsp:setProperty property="aid" name="bankingarrangement" value="${param.aid}" />
<jsp:setProperty property="facility_name" name="bankingarrangement" value="${param.facility_name}" />
<jsp:setProperty property="type" name="bankingarrangement" value="${param.type}" />
<jsp:setProperty property="number_banks" name="bankingarrangement" value="${param.number_banks}" />
<jsp:setProperty property="leader_bank" name="bankingarrangement" value="${param.leader_bank}" />
<fmt:parseDate var="parsedConsortiumDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>
<jsp:setProperty property="latest_consortium_meeting" name="bankingarrangement" value="${parsedConsortiumDate}"/>  
<jsp:setProperty property="diligence_report" name="bankingarrangement" value="${param.diligence_report}" />
<jsp:setProperty property="credit_information_exchange" name="bankingarrangement" value="${param.asset_credit_information_exchange}" />
</jsp:useBean>

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
FacilityDao dao2=new FacilityDao();
List<Facility> facilitylist=dao2.get_all_facilities();
BankingArrangementDao dao3=new BankingArrangementDao();
List<BankingArrangement> bankingarrangementlist=dao3.get_all_bankingarrangement();
%>

<c:if test="${param.btn_bankingarrangement_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao3.add_bankingarrangement(bankingarrangement); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/bankingarrangement.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_bankingarrangement_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delba1 = (String) request.getParameter("delete_bankingarrangement");
int delba2=Integer.parseInt(delba1);
%>

<%dao3.delete_bankingarrangement(delba2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/bankingarrangement.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_bankingarrangement_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.BankingArrangementDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Banking Arrangement ID</th>
    <th>Account</th> 
    <th>Facility</th>
    <th>Banking arrangement</th>
    <th>Number of banks</th>
    <th>Leader bank</th>
    <th>Latest consortium meeting held on</th>
    <th>Status of diligence report</th>
    <th>Status of credit information exchange</th>
   </tr>
   
   <c:forEach items="${dao4._all_bankingarrangement}" var="tempbankingarrangement">

   <tr>      
       <td><c:out value="${tempbankingarrangement.bid}"/> </td>
       
<sql:query var="result1" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempbankingarrangement.aid}" />
</sql:query>
<c:set var="aid" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${aid}"/> </td>
              
       <td><c:out value="${tempbankingarrangement.facility_name}"/> </td>
       <td><c:out value="${tempbankingarrangement.type}"/> </td>
       <td><c:out value="${tempbankingarrangement.number_banks}"/> </td>
       <td><c:out value="${tempbankingarrangement.leader_bank}"/> </td>
       
       <fmt:formatDate var="formattedConsortiumDate" value="${tempbankingarrangement.latest_consortium_meeting}" dateStyle="medium"/>
       <td><c:out value="${formattedConsortiumDate}"/> </td>
       
       <td><c:out value="${tempbankingarrangement.diligence_report}"/> </td>
       <td><c:out value="${tempbankingarrangement.credit_information_exchange}"/> </td>

       </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/bankingarrangement.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>


<c:if test="${param.btn_bankingarrangement_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result2" dataSource="${dataSource}">
select * from banking_arrangement where bid=?
<sql:param value="${param.edit_bankingarrangement}" />
</sql:query>
<c:set var="returned_row" value="${result2.rowsByIndex[0]}" />

<form action="edit_bankingarrangement.jsp" method="post">

<b> Edit entry : </b> <br><br>

Banking Arrangement ID : <input type="text" readonly name="bid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>


Enter account : <select name="aid">

<jsp:useBean id="dao5" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

<c:forEach items="${dao5._all_accounts}" var="temp1">

         <c:if test="${returned_row[1]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=$temp1.aid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>


Enter facility : <select name="facility_name">

<jsp:useBean id="dao6" class="classpackage.FacilityDao" scope="request">
</jsp:useBean>

<c:forEach items="${dao6._all_facilities}" var="temp2">

         <c:if test="${returned_row[2]==temp2.facility_name}">
          <option value="${temp2.facility_name}" selected="selected"> ${temp2.facility_name} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=temp2.facility_name}">
          <option value="${temp2.facility_name}"> ${temp2.facility_name} </option>
          </c:if>

            </c:forEach>
</select><br>



Enter banking arrangement: <select name="type">
<c:set var="type">Sole banking,Consortium,Multiple Banking Arrangement</c:set>
<c:forTokens items="${type}" delims="," var="temp3">
    
     <c:if test="${returned_row[3]==temp3}">
          <option value="${temp3}" selected="selected"> ${temp3} </option>
          </c:if>
          
          <c:if test="${returned_row[3]!=temp3}">
          <option value="${temp3}"> ${temp3} </option>
          </c:if>
    
</c:forTokens>

</select><br>

Enter number of banks in the arrangement : <input type="text" name="number_banks" value="<c:out value="${returned_row[4]}"/>" /><br>
Enter leader bank : <input type="text" name="leader_name" value="<c:out value="${returned_row[5]}"/>" /><br>

Enter date of latest consortium meeting :
<c:set var="datecheck1" value="${returned_row[6]}" />

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


Enter status of diligence report : <select name="diligence_report">
<c:set var="diligence_report">Not applicable,Obtained,Pending</c:set>
<c:forTokens items="${diligence_report}" delims="," var="temp4">
    
     <c:if test="${returned_row[7]==temp4}">
          <option value="${temp4}" selected="selected"> ${temp4} </option>
          </c:if>
          
          <c:if test="${returned_row[7]!=temp4}">
          <option value="${temp4}"> ${temp4} </option>
          </c:if>
    
</c:forTokens>

</select><br>


Enter status of credit information exchange : <select name="credit_information_exchange">
<c:set var="credit_information_exchange">Not applicable,Obtained,Pending</c:set>
<c:forTokens items="${credit_information_exchange}" delims="," var="temp5">
    
     <c:if test="${returned_row[8]==temp5}">
          <option value="${temp5}" selected="selected"> ${temp5} </option>
          </c:if>
          
          <c:if test="${returned_row[8]!=temp5}">
          <option value="${temp5}"> ${temp5} </option>
          </c:if>
    
</c:forTokens>

</select><br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>