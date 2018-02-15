<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.SpecialconditionsDao" %>
    <%@ page import="classpackage.Specialconditions" %>
    <%@ page import="classpackage.SanctionDao" %>
    <%@ page import="classpackage.Sanction" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Special conditions issues</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="specialconditions" class="classpackage.Specialconditions" scope="request">
<jsp:setProperty property="*" name="specialconditions" />
</jsp:useBean>

<%SanctionDao dao1=new SanctionDao();
List<Sanction> accountlist=dao1.get_all_sanctions();
SpecialconditionsDao dao2=new SpecialconditionsDao();
List<Specialconditions> specialconditionslist=dao2.get_all_specialconditions();
%>



<c:if test="${param.btn_specialconditions_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%
String sid1=(String) request.getParameter("sid");
int sid2=Integer.parseInt(sid1);
String condition=(String) request.getParameter("condition");
dao2.add_specialconditions(sid2,condition); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/specialconditions.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_specialconditions_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<form action="edit_specialconditions.jsp" method="post">

<%
String editspecialconditions1 = (String) request.getParameter("edit_specialconditions");
int editspecialconditions2=Integer.parseInt(editspecialconditions1);
%>

<sql:query var="result1" dataSource="${dataSource}">
select * from special_conditions where cid=?
<sql:param value="<%=editspecialconditions2 %>" />
</sql:query>

<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

<input type="hidden" name="cid" value="<%=editspecialconditions2%>"><br><br>

Edit special condition :<br><br>

Condition ID : <input type="text" readonly name="cid" value="${returned_row[0]}"/> (system generated and cannot be edited)<br><br>
<textarea name="condition" rows="4" cols="25"><c:out value="${returned_row[1]}" /></textarea><br><br> 

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>
</c:if>
</c:if>


<c:if test="${param.btn_specialconditions_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delspecialconditions1 = (String) request.getParameter("delete_specialconditions");
int delspecialconditions2=Integer.parseInt(delspecialconditions1);
dao2.delete_specialconditions(delspecialconditions2);
%>
<h3>Deletion of record successful</h3>
<form action="/creditdept/specialconditions.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>



<c:if test="${param.btn_specialconditions_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.SpecialconditionsDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    
    <th>Sanction ID</th>
    <th>Special condition ID</th>
    <th>Special condition</th> 
    
   </tr>
   
   <c:forEach items="${dao3._all_specialconditions}" var="tempspecialconditions">

   <tr>      
       <td><c:out value="${tempspecialconditions.sid}"/> </td>
       <td><c:out value="${tempspecialconditions.cid}"/> </td>
       
       <td><c:out value="${tempspecialconditions.condition}"/> </td>
</tr>
</c:forEach>
</table><br><br>
<form action="/creditdept/specialconditions.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


</body>
</html>