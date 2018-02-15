<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.DirectorsDao" %>
    <%@ page import="classpackage.Directors" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Directors</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="directors" class="classpackage.Directors" scope="request">
<jsp:setProperty property="*" name="directors" />
</jsp:useBean>

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
DirectorsDao dao2=new DirectorsDao();
List<Directors> pendinglist=dao2.get_all_directors();
%>



<c:if test="${param.btn_directors_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%
String aid1=(String) request.getParameter("aid");
int aid2=Integer.parseInt(aid1);
String director_name=(String) request.getParameter("director_name");
String designation=(String) request.getParameter("designation");
dao2.add_director(aid2,director_name,designation); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/directors.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_directors_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<form action="edit_directors.jsp" method="post">

<%
String editdirectors1 = (String) request.getParameter("edit_directors");
int editdirectors2=Integer.parseInt(editdirectors1);
%>

<sql:query var="result1" dataSource="${dataSource}">
select * from account_directors where dirid=?
<sql:param value="<%=editdirectors2 %>" />
</sql:query>

<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

<input type="hidden" name="dirid" value="<%=editdirectors2%>"><br><br>

Edit name of director :<input type="text" name="director_name" value=<c:out value="${returned_row[1]}"/> /><br>
Edit designation :<input type="text" name="designation" value=<c:out value="${returned_row[2]}" /> /><br><br> 
 

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>
</c:if>
</c:if>


<c:if test="${param.btn_directors_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String deldirectors1 = (String) request.getParameter("delete_directors");
int deldirectors2=Integer.parseInt(deldirectors1);
dao2.delete_director(deldirectors2);
%>
<h3>Deletion of record successful</h3>
<form action="/creditdept/directors.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>



<c:if test="${param.btn_directors_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.DirectorsDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Director ID</th>
    <th>Name of director</th> 
    <th>Designation</th>
    <th>Account name</th>
   </tr>
   
   <c:forEach items="${dao3._all_directors}" var="tempdirector">

   <tr>      
       <td><c:out value="${tempdirector.dirid}"/> </td>
       
       
<sql:query var="result2" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempdirector.aid}" />
</sql:query>
<c:set var="aid" value="${result2.rowsByIndex[0][0]}" />

       <td><c:out value="${aid}"/> </td>
       <td><c:out value="${tempdirector.director_name}"/> </td>
       <td><c:out value="${tempdirector.designation}"/> </td>
</tr>
</c:forEach>
</table><br><br>
<form action="/creditdept/directors.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


</body>
</html>