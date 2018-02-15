<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.PhonesDao" %>
    <%@ page import="classpackage.Phones" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Phones</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="phones" class="classpackage.Phones" scope="request">
<jsp:setProperty property="*" name="phones" />
</jsp:useBean>

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
PhonesDao dao2=new PhonesDao();
List<Phones> phonelist=dao2.get_all_phones();
%>



<c:if test="${param.btn_phones_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%
String aid1=(String) request.getParameter("aid");
int aid2=Integer.parseInt(aid1);
String sub_name=(String) request.getParameter("sub_name");
String phone=(String) request.getParameter("phone");
dao2.add_phone(aid2,sub_name,phone); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/phones.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_phones_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<form action="edit_phones.jsp" method="post">

<%
String editphones1 = (String) request.getParameter("edit_phones");
int editphones2=Integer.parseInt(editphones1);
%>

<sql:query var="result1" dataSource="${dataSource}">
select * from account_phones where phid=?
<sql:param value="<%=editphones2 %>" />
</sql:query>

<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

<input type="hidden" name="phid" value="<%=editphones2%>"><br><br>

Edit name of phone :<input type="text" name="sub_name" value=<c:out value="${returned_row[1]}"/> /><br>
Edit phone :<input type="text" name="phone" value=<c:out value="${returned_row[2]}" /> /><br><br> 
 

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>
</c:if>
</c:if>


<c:if test="${param.btn_phones_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delphones1 = (String) request.getParameter("delete_phones");
int delphones2=Integer.parseInt(delphones1);
dao2.delete_phone(delphones2);
%>
<h3>Deletion of record successful</h3>
<form action="/creditdept/phones.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>



<c:if test="${param.btn_phones_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.PhonesDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Phone ID</th>
    <th>Category of phone</th> 
    <th>Phone number</th>
    <th>Account name</th>
   </tr>
   
   <c:forEach items="${dao3._all_phones}" var="tempphone">

   <tr>      
       <td><c:out value="${tempphone.phid}"/> </td>
       
       
<sql:query var="result2" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempphone.aid}" />
</sql:query>
<c:set var="aid" value="${result2.rowsByIndex[0][0]}" />

       <td><c:out value="${aid}"/> </td>
       <td><c:out value="${tempphone.sub_name}"/> </td>
       <td><c:out value="${tempphone.phone}"/> </td>
</tr>
</c:forEach>
</table><br><br>
<form action="/creditdept/phones.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


</body>
</html>