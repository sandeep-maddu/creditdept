<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ page import="classpackage.ActivityDao" %>
    <%@ page import="classpackage.Activity" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Details of activities</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">

<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />

<jsp:useBean id="activity" class="classpackage.Activity" scope="request">
<jsp:setProperty property="*" name="activity" />
</jsp:useBean>

<c:if test="${param.btn_activity_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">

<%ActivityDao dao1=new ActivityDao();
dao1.add_activity(activity); %>

<h3>Insertion of new record successful</h3>
<form action="/creditdept/activity.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_activity_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%String delactv=(String) request.getParameter("delete_activity");
ActivityDao dao2=new ActivityDao();
dao2.delete_activity(delactv); %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/activity.jsp">
<input type="submit" value="Back">

</form>
</c:if>
</c:if>




<c:if test="${param.btn_activity_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao2" class="classpackage.ActivityDao" scope="request">
<jsp:setProperty property="*" name="dao2" />
</jsp:useBean>

<table id="t01">
   <tr>
    <th>Activity</th>
    <th>Description</th> 
    <th>Industry</th>
   </tr>
   
   <c:forEach items="${dao2._all_activities}" var="tempactivity">

   <tr>      
       <td><c:out value="${tempactivity.activity_name}"/> </td>
       <td><c:out value="${tempactivity.description}"/> </td>
       <td><c:out value="${tempactivity.industry}"/> </td>
       
</c:forEach>
   
</table>
<br><br>
<form action="/creditdept/activity.jsp">
<input type="submit" value="Back" />
</form>


</c:if>
</c:if>




<c:if test="${param.btn_activity_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<sql:query var="result" dataSource="${dataSource}">
select * from activity where activity_name=?
<sql:param value="${param.edit_activity}" />
</sql:query>
<c:set var="returned_row" value="${result.rowsByIndex[0]}" />

<form action="edit_activity.jsp" method="post">

<b> Edit entry : </b> <br><br>

Enter name of activity : <input type="text" name="activity_name" value="${returned_row[0]}"/> <br>
Enter description of activity : <input type="text" name="description" value="<c:out value="${returned_row[1]}"/>" /><br>
Enter industry : <input type="text" name="industry" value="<c:out value="${returned_row[2]}"/>" /><br><br>

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>



</body>
</html>