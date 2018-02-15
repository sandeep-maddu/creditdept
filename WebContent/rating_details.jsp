<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 	
    <%@ page import="classpackage.RatingDao" %>
    <%@ page import="classpackage.Rating" %>  
    <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>  
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
<title>Rating details</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="rating" class="classpackage.Rating" scope="request">

<jsp:setProperty property="rid" name="rating" value="${param.rid}" />
<jsp:setProperty property="agency" name="rating" value="${param.agency}" />
<jsp:setProperty property="facility_name" name="rating" value="${param.facility_name}" />
<jsp:setProperty property="rating" name="rating" value="${param.rating}" />
<jsp:setProperty property="rating_model" name="rating" value="${param.rating_model}" />
<jsp:setProperty property="description" name="rating" value="${param.description}" />
<fmt:parseDate var="parsedBasedOnFinancialsDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<jsp:setProperty property="basedon_financials" name="rating" value="${parsedBasedOnFinancialsDate}"/>
<jsp:setProperty property="basedon_audited" name="rating" value="${param.basedon_audited}" />
<fmt:parseDate var="parsedDueDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>
<jsp:setProperty property="due_date" name="rating" value="${parsedDueDate}"/>
<jsp:setProperty property="aid" name="rating" value="${param.aid}" />
</jsp:useBean>

<%FacilityDao dao1=new FacilityDao();
List<Facility> facilitylist=dao1.get_all_facilities();
AccountDao dao2=new AccountDao();
List<Account> accountlist=dao2.get_all_accounts();
RatingDao dao3=new RatingDao();
List<Rating> ratinglist=dao3.get_all_ratings();
%>

<c:if test="${param.btn_rating_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%dao3.add_rating(rating); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/rating.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_rating_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delrating1 = (String) request.getParameter("delete_rating");
int delrating2=Integer.parseInt(delrating1);
%>

<%dao3.delete_rating(delrating2); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/rating.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>


<c:if test="${param.btn_rating_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.RatingDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Rating ID</th>
    <th>Account</th> 
    <th>Facility</th>
    <th>Agency</th>
    <th>Rating</th>
    <th>Rating model</th>
    <th>Description</th>
    <th>Balance sheet date on which rating is based</th>
    <th>Whether balance sheet is audited or provisional</th>
    <th>Date till which rating is valid</th>
    </tr>
   
   <c:forEach items="${dao4._all_ratings}" var="temprating">

   <tr>      
       <td><c:out value="${temprating.rid}"/> </td>
       
<sql:query var="result1" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${temprating.aid}" />
</sql:query>
<c:set var="aid" value="${result1.rowsByIndex[0][0]}" />
             
       <td><c:out value="${aid}"/> </td>
       
       
<td><c:out value="${temprating.facility_name}"/> </td>
<td><c:out value="${temprating.agency}"/> </td>
<td><c:out value="${temprating.rating}"/> </td>
<td><c:out value="${temprating.rating_model}"/> </td>
<td><c:out value="${temprating.description}"/> </td>
       
       <fmt:formatDate var="formattedBasedOnFinancialsDate" value="${temprating.basedon_financials}" dateStyle="medium"/>
       <td><c:out value="${formattedBasedOnFinancialsDate}"/> </td>
       
       <td><c:out value="${temprating.basedon_audited}"/> </td>
       
               <fmt:formatDate var="formattedDueDate" value="${temprating.due_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDueDate}"/> </td>
       
              </tr>

</c:forEach>
   
</table><br><br>

<form action="/creditdept/rating.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>



<c:if test="${param.btn_rating_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result2" dataSource="${dataSource}">
select * from rating where rid=?
<sql:param value="${param.edit_rating}" />
</sql:query>
<c:set var="returned_row" value="${result2.rowsByIndex[0]}" />



<form action="edit_rating.jsp" method="post">

<b> Edit entry : </b> <br><br>


Rating ID : <input type="text" readonly name="rid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>

<jsp:useBean id="dao6" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

Enter account : <select name="aid">
<c:forEach items="${dao6._all_accounts}" var="temp3">

         <c:if test="${returned_row[9]==temp3.aid}">
          <option value="${temp3.aid}" selected="selected"> ${temp3.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[9]!=$temp3.aid}">
          <option value="${temp3.aid}"> ${temp3.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter rating agency : <input type="text" name="agency" value="<c:out value="${returned_row[1]}"/>" /><br>

<jsp:useBean id="dao5" class="classpackage.FacilityDao" scope="request">
</jsp:useBean>

Enter facility : <select name="facility_name">
<c:forEach items="${dao5._all_facilities}" var="temp1">

         <c:if test="${returned_row[2]==temp1.facility_name}">
          <option value="${temp1.facility_name}" selected="selected"> ${temp1.facility_name} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=$temp1.facility_name}">
          <option value="${temp1.facility_name}"> ${temp1.facility_name} </option>
          </c:if>

            </c:forEach>
</select><br>

Enter rating : <input type="text" name="rating" value="<c:out value="${returned_row[3]}"/>" /><br>
Enter rating model : <input type="text" name="rating_model" value="<c:out value="${returned_row[4]}"/>" /><br>
Enter description : <input type="text" name="description" value="<c:out value="${returned_row[5]}"/>" /><br>


Enter balance sheet date on which rating is based  : 

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

Enter whether the above balance sheet is audited or provisional : <select name="basedon_audited">
<c:set var="basedon_audited">Audited,Provisional</c:set>
<c:forTokens items="${basedon_audited}" delims="," var="temp2">
    
     <c:if test="${returned_row[7]==temp2}">
          <option value="${temp2}" selected="selected"> ${temp2} </option>
          </c:if>
          
          <c:if test="${returned_row[7]!=temp2}">
          <option value="${temp2}"> ${temp2} </option>
          </c:if>
    
</c:forTokens>

</select><br>


Enter date till which rating is valid : 

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
</select><br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>

</body>
</html>