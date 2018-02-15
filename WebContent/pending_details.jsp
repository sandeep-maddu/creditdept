<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.PendingDao" %>
    <%@ page import="classpackage.Pending" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pending issues</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="pending" class="classpackage.Pending" scope="request">
<jsp:setProperty property="*" name="pending" />
</jsp:useBean>

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
PendingDao dao2=new PendingDao();
List<Pending> pendinglist=dao2.get_all_pending();
%>



<c:if test="${param.btn_pending_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%
String aid1=(String) request.getParameter("aid");
int aid2=Integer.parseInt(aid1);
String pending_issue=(String) request.getParameter("pending_issue");
dao2.add_pending(aid2,pending_issue); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/pending.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_pending_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<form action="edit_pending.jsp" method="post">

<%
String editpending1 = (String) request.getParameter("edit_pending");
int editpending2=Integer.parseInt(editpending1);
%>

<sql:query var="result1" dataSource="${dataSource}">
select * from pending_issues where pi_id=?
<sql:param value="<%=editpending2 %>" />
</sql:query>

<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

<input type="hidden" name="pi_id" value="<%=editpending2%>"><br><br>

Edit pending issue :<textarea name="pending_issue" rows="4" cols="25"><c:out value="${returned_row[1]}" /></textarea><br><br> 
 

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>
</c:if>
</c:if>


<c:if test="${param.btn_pending_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delpending1 = (String) request.getParameter("delete_pending");
int delpending2=Integer.parseInt(delpending1);
dao2.delete_pending(delpending2);
%>
<h3>Deletion of record successful</h3>
<form action="/creditdept/pending.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>



<c:if test="${param.btn_pending_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.PendingDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Pending issue ID</th>
    <th>Account name</th> 
    <th>Pending issue</th>
   </tr>
   
   <c:forEach items="${dao3._all_pending}" var="temppending">

   <tr>      
       <td><c:out value="${temppending.pi_id}"/> </td>
       
<sql:query var="result2" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${temppending.aid}" />
</sql:query>
<c:set var="aid" value="${result2.rowsByIndex[0][0]}" />

       <td><c:out value="${aid}"/> </td>
       <td><c:out value="${temppending.pending_issue}"/> </td>
</tr>
</c:forEach>
</table><br><br>
<form action="/creditdept/pending.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


</body>
</html>