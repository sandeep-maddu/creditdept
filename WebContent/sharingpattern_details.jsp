<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.SharingPatternDao" %>
    <%@ page import="classpackage.SharingPattern" %>
    <%@ page import="classpackage.BankingArrangementDao" %>
    <%@ page import="classpackage.BankingArrangement" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sharing Pattern</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="sharingpatterns" class="classpackage.SharingPattern" scope="request">
<jsp:setProperty property="*" name="sharingpatterns" />
</jsp:useBean>

<%BankingArrangementDao dao1=new BankingArrangementDao();
List<BankingArrangement> accountlist=dao1.get_all_bankingarrangement();
SharingPatternDao dao2=new SharingPatternDao();
List<SharingPattern> sharingpatternlist=dao2.get_all_sharingpattern();
%>



<c:if test="${param.btn_sharingpatterns_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%
String bid1=(String) request.getParameter("bid");
int bid2=Integer.parseInt(bid1);
String bank=(String) request.getParameter("bank");
String limit1=(String) request.getParameter("limit");
float limit2=Float.parseFloat(limit1);
String share_pct1=(String) request.getParameter("share_pct");
float share_pct2=Float.parseFloat(share_pct1);
dao2.add_sharingpattern(bid2,bank,limit2,share_pct2); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/sharingpattern.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_sharingpatterns_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<form action="edit_sharingpattern.jsp" method="post">

<%
String editsharingpatterns1 = (String) request.getParameter("edit_sharingpatterns");
int editsharingpatterns2=Integer.parseInt(editsharingpatterns1);
%>

<sql:query var="result1" dataSource="${dataSource}">
select * from sharing_pattern where spid=?
<sql:param value="<%=editsharingpatterns2 %>" />
</sql:query>

<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

<input type="hidden" name="spid" value="<%=editsharingpatterns2%>"><br><br>

Edit ID of Banking Arrangement :<input type="text" name="bid" value=<c:out value="${returned_row[1]}"/> /><br>
Edit bank :<input type="text" name="bank" value=<c:out value="${returned_row[2]}" /> /><br>
Edit limit amount :<input type="text" name="limit" value=<c:out value="${returned_row[3]}" /> /><br>
Edit percent share :<input type="text" name="share_pct" value=<c:out value="${returned_row[4]}" /> /><br><br> 
 

<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>
</c:if>
</c:if>


<c:if test="${param.btn_sharingpatterns_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delsharingpatterns1 = (String) request.getParameter("delete_sharingpatterns");
int delsharingpatterns2=Integer.parseInt(delsharingpatterns1);
dao2.delete_sharingpattern(delsharingpatterns2);
%>
<h3>Deletion of record successful</h3>
<form action="/creditdept/sharingpattern.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>



<c:if test="${param.btn_sharingpatterns_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.SharingPatternDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Sharing Pattern ID</th>
    <th>Banking Arrangement ID</th>
    <th>Bank</th> 
    <th>Limit amount</th>
    <th>Percent share</th>
   </tr>
   
   <c:forEach items="${dao3._all_sharingpattern}" var="tempsharingpattern">

   <tr>      
       <td><c:out value="${tempsharingpattern.spid}"/> </td>
       <td><c:out value="${tempsharingpattern.bid}"/> </td>
       <td><c:out value="${tempsharingpattern.bank}"/> </td>
       <td><c:out value="${tempsharingpattern.limit}"/> </td>
       <td><c:out value="${tempsharingpattern.share_pct}"/> </td>
       
       </tr>
</c:forEach>
</table><br><br>
<form action="/creditdept/sharingpattern.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


</body>
</html>