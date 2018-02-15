<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ page import="classpackage.FacilityDao" %>
    <%@ page import="classpackage.Facility" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Details of facilities</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />

<jsp:useBean id="facility" class="classpackage.Facility" scope="request">
<jsp:setProperty property="*" name="facility" />
</jsp:useBean>

<%FacilityDao dao1=new FacilityDao(); %>

<c:if test="${param.btn_facility_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">

<%dao1.add_facility(facility); %>

<h3>Insertion of new record successful</h3>
<form action="/creditdept/facility.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_facility_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%String delfacility=(String) request.getParameter("delete_facility");
dao1.delete_facility(delfacility); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/facility.jsp">
<input type="submit" value="Back">

</form>
</c:if>
</c:if>


<c:if test="${param.btn_facility_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao2" class="classpackage.FacilityDao" scope="request">
</jsp:useBean>

<table id="t01">
   <tr>
    <th>Facility</th>
    <th>Fund based/ Non-fund based</th> 
    <th>Working capital/ Term loan</th>
   </tr>
   
   <c:forEach items="${dao2._all_facilities}" var="tempfacility">

   <tr>      
       <td><c:out value="${tempfacility.facility_name}"/> </td>
       <td><c:out value="${tempfacility.fb_or_nfb}"/> </td>
       <td><c:out value="${tempfacility.wc_or_tl}"/> </td>
</tr>       
</c:forEach>
   
</table>
<br><br>
<form action="/creditdept/facility.jsp">
<input type="submit" value="Back" />
</form>

</c:if>
</c:if>




<c:if test="${param.btn_facility_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result" dataSource="${dataSource}">
select * from facility where facility_name=?
<sql:param value="${param.edit_facility}" />
</sql:query>
<c:set var="returned_row" value="${result.rowsByIndex[0]}" />

<form action="edit_facility.jsp" method="post">

<b> Edit entry : </b> <br><br>

Enter name of facility : <input type="text" name="facility_name" value="${returned_row[0]}"/> <br>
Fund based or Non-fund based :  <select name="fb_or_nfb">
<c:set var="fbtype">Fund based,Non-fund based</c:set>
<c:forTokens items="${fbtype}" delims="," var="temp1">
    
     <c:if test="${returned_row[1]==temp1}">
          <option value="${temp1}" selected="selected"> ${temp1} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=temp1}">
          <option value="${temp1}"> ${temp1} </option>
          </c:if>
    
</c:forTokens>

</select><br>

Working capital or Term loan : <select name="wc_or_tl">
<c:set var="wctype">Working capital,Term loan</c:set>
<c:forTokens items="${wctype}" delims="," var="temp2">
    
     <c:if test="${returned_row[2]==temp2}">
          <option value="${temp2}" selected="selected"> ${temp2} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=temp2}">
          <option value="${temp2}"> ${temp2} </option>
          </c:if>
    
</c:forTokens>

</select><br><br>


<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>



</body>
</html>