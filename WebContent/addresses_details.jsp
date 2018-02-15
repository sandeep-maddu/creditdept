<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.AddressesDao" %>
    <%@ page import="classpackage.Addresses" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Addresses</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="addresses" class="classpackage.Addresses" scope="request">
<jsp:setProperty property="*" name="addresses" />
</jsp:useBean>

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
AddressesDao dao2=new AddressesDao();
List<Addresses> addresslist=dao2.get_all_addresses();
%>



<c:if test="${param.btn_addresses_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%
String aid1=(String) request.getParameter("aid");
int aid2=Integer.parseInt(aid1);
String sub_name=(String) request.getParameter("sub_name");
String address=(String) request.getParameter("address");
dao2.add_address(aid2,sub_name,address); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/addresses.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_addresses_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<form action="edit_addresses.jsp" method="post">

<%
String editaddresses1 = (String) request.getParameter("edit_addresses");
int editaddresses2=Integer.parseInt(editaddresses1);
%>

<sql:query var="result1" dataSource="${dataSource}">
select * from account_addresses where addid=?
<sql:param value="<%=editaddresses2 %>" />
</sql:query>

<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

<input type="hidden" name="addid" value="<%=editaddresses2%>"><br><br>

Edit name of address :<input type="text" name="sub_name" value=<c:out value="${returned_row[1]}"/> /><br>
Edit address :<input type="text" name="address" value=<c:out value="${returned_row[2]}" /> /><br><br> 
 

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>
</c:if>
</c:if>


<c:if test="${param.btn_addresses_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String deladdresses1 = (String) request.getParameter("delete_addresses");
int deladdresses2=Integer.parseInt(deladdresses1);
dao2.delete_address(deladdresses2);
%>
<h3>Deletion of record successful</h3>
<form action="/creditdept/addresses.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>



<c:if test="${param.btn_addresses_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.AddressesDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Address ID</th>
    <th>Category of address</th> 
    <th>Address</th>
    <th>Account name</th>
   </tr>
   
   <c:forEach items="${dao3._all_addresses}" var="tempaddress">

   <tr>      
       <td><c:out value="${tempaddress.addid}"/> </td>
       <td><c:out value="${tempaddress.sub_name}"/> </td>
       <td><c:out value="${tempaddress.address}"/> </td>
       
<sql:query var="result2" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempaddress.aid}" />
</sql:query>
<c:set var="aid" value="${result2.rowsByIndex[0][0]}" />

       <td><c:out value="${aid}"/> </td>
       
</tr>
</c:forEach>
</table><br><br>
<form action="/creditdept/addresses.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


</body>
</html>