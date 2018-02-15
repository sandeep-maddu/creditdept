<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="classpackage.MisDao" %>
    <%@ page import="classpackage.Mis" %>
    <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MIS</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="mis" class="classpackage.Mis" scope="request">
<jsp:setProperty property="*" name="mis" />
</jsp:useBean>

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
MisDao dao2=new MisDao();
List<Mis> mislist=dao2.get_all_mis();
%>

<c:if test="${param.btn_mis_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">
<%
String aid1=(String) request.getParameter("aid");
int aid2=Integer.parseInt(aid1);
dao2.add_mis(mis); %>
<h3>Insertion of new record successful</h3>
<form action="/creditdept/mis.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_mis_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">


<form action="edit_mis.jsp" method="post">

<%
String editmis1 = (String) request.getParameter("edit_mis");
int editmis2=Integer.parseInt(editmis1);
%>

<sql:query var="result1" dataSource="${dataSource}">
select * from mis where aid=?
<sql:param value="<%=editmis2 %>" />
</sql:query>

<c:set var="returned_row" value="${result1.rowsByIndex[0]}" />

Edit name of account :

<jsp:useBean id="dao3" class="classpackage.AccountDao" scope="request">
</jsp:useBean>

<select name="aid">
<c:forEach items="${dao3._all_accounts}" var="temp1">

         <c:if test="${returned_row[0]==temp1.aid}">
          <option value="${temp1.aid}" selected="selected"> ${temp1.account_name} </option>
          </c:if>
          
          <c:if test="${returned_row[0]!=temp1.aid}">
          <option value="${temp1.aid}"> ${temp1.account_name} </option>
          </c:if>

            </c:forEach>
</select><br>


Takeover :  <select name="takeover">
<c:set var="takeover">Yes,No</c:set>
<c:forTokens items="${takeover}" delims="," var="temp2">
         <c:if test="${returned_row[1]==temp2}">
          <option value="${temp2}" selected="selected"> ${temp2} </option>
          </c:if>
          
          <c:if test="${returned_row[1]!=temp2}">
          <option value="${temp2}"> ${temp2} </option>
          </c:if>
</c:forTokens>
</select><br>


Restructured :  <select name="restructured">
<c:set var="restructured">Yes,No</c:set>
<c:forTokens items="${restructured}" delims="," var="temp3">
         <c:if test="${returned_row[2]==temp3}">
          <option value="${temp3}" selected="selected"> ${temp3} </option>
          </c:if>
          
          <c:if test="${returned_row[2]!=temp3}">
          <option value="${temp3}"> ${temp3} </option>
          </c:if>
</c:forTokens>
</select><br>


CGTMSE :  <select name="cgtmse">
<c:set var="cgtmse">Yes,No</c:set>
<c:forTokens items="${cgtmse}" delims="," var="temp4">
         <c:if test="${returned_row[3]==temp4}">
          <option value="${temp4}" selected="selected"> ${temp4} </option>
          </c:if>
          
          <c:if test="${returned_row[3]!=temp4}">
          <option value="${temp4}"> ${temp4} </option>
          </c:if>
</c:forTokens>
</select><br>


PMEGP :  <select name="pmegp">
<c:set var="pmegp">Yes,No</c:set>
<c:forTokens items="${pmegp}" delims="," var="temp5">
         <c:if test="${returned_row[4]==temp5}">
          <option value="${temp5}" selected="selected"> ${temp5} </option>
          </c:if>
          
          <c:if test="${returned_row[4]!=temp5}">
          <option value="${temp5}"> ${temp5} </option>
          </c:if>
</c:forTokens>
</select><br>


Corporate loan :  <select name="corporate_loan">
<c:set var="corporate_loan">Yes,No</c:set>
<c:forTokens items="${corporate_loan}" delims="," var="temp6">
         <c:if test="${returned_row[5]==temp6}">
          <option value="${temp6}" selected="selected"> ${temp6} </option>
          </c:if>
          
          <c:if test="${returned_row[5]!=temp6}">
          <option value="${temp6}"> ${temp6} </option>
          </c:if>
</c:forTokens>
</select><br>

Foreign currency loan :  <select name="foreign_currency_loan">
<c:set var="foreign_currency_loan">Yes,No</c:set>
<c:forTokens items="${foreign_currency_loan}" delims="," var="temp7">
         <c:if test="${returned_row[6]==temp7}">
          <option value="${temp7}" selected="selected"> ${temp7} </option>
          </c:if>
          
          <c:if test="${returned_row[6]!=temp7}">
          <option value="${temp7}"> ${temp7} </option>
          </c:if>
</c:forTokens>
</select><br>

Export credit limit :  <select name="export_credit_limit">
<c:set var="export_credit_limit">Yes,No</c:set>
<c:forTokens items="${export_credit_limit}" delims="," var="temp8">
         <c:if test="${returned_row[7]==temp8}">
          <option value="${temp8}" selected="selected"> ${temp8} </option>
          </c:if>
          
          <c:if test="${returned_row[7]!=temp8}">
          <option value="${temp8}"> ${temp8} </option>
          </c:if>
</c:forTokens>
</select><br>

Pledge of shares :  <select name="pledge_shares">
<c:set var="pledge_shares">Yes,No</c:set>
<c:forTokens items="${pledge_shares}" delims="," var="temp9">
         <c:if test="${returned_row[8]==temp9}">
          <option value="${temp9}" selected="selected"> ${temp9} </option>
          </c:if>
          
          <c:if test="${returned_row[8]!=temp9}">
          <option value="${temp9}"> ${temp9} </option>
          </c:if>
</c:forTokens>
</select><br>

MSME category :  <select name="msme_category">
<c:set var="msme_category">Micro,Small,Medium,Not aplicable</c:set>
<c:forTokens items="${msme_category}" delims="," var="temp10">
         <c:if test="${returned_row[9]==temp10}">
          <option value="${temp10}" selected="selected"> ${temp10} </option>
          </c:if>
          
          <c:if test="${returned_row[9]!=temp10}">
          <option value="${temp10}"> ${temp10} </option>
          </c:if>
</c:forTokens>
</select><br>


Composite loan :  <select name="composite_loan">
<c:set var="composite_loan">Yes,No</c:set>
<c:forTokens items="${composite_loan}" delims="," var="temp11">
         <c:if test="${returned_row[10]==temp11}">
          <option value="${temp11}" selected="selected"> ${temp11} </option>
          </c:if>
          
          <c:if test="${returned_row[10]!=temp11}">
          <option value="${temp11}"> ${temp11} </option>
          </c:if>
</c:forTokens>
</select><br>


Forward contract :  <select name="forward_contract">
<c:set var="forward_contract">Yes,No</c:set>
<c:forTokens items="${forward_contract}" delims="," var="temp12">
         <c:if test="${returned_row[11]==temp12}">
          <option value="${temp12}" selected="selected"> ${temp12} </option>
          </c:if>
          
          <c:if test="${returned_row[11]!=temp12}">
          <option value="${temp12}"> ${temp12} </option>
          </c:if>
</c:forTokens>
</select><br>


Buyers credit :  <select name="buyers_credit">
<c:set var="buyers_credit">Yes,No</c:set>
<c:forTokens items="${buyers_credit}" delims="," var="temp13">
         <c:if test="${returned_row[12]==temp13}">
          <option value="${temp13}" selected="selected"> ${temp13} </option>
          </c:if>
          
          <c:if test="${returned_row[12]!=temp13}">
          <option value="${temp13}"> ${temp13} </option>
          </c:if>
</c:forTokens>
</select><br>



Food processing :  <select name="food_processing">
<c:set var="food_processing">Yes,No</c:set>
<c:forTokens items="${food_processing}" delims="," var="temp14">
         <c:if test="${returned_row[13]==temp14}">
          <option value="${temp14}" selected="selected"> ${temp14} </option>
          </c:if>
          
          <c:if test="${returned_row[13]!=temp14}">
          <option value="${temp14}"> ${temp14} </option>
          </c:if>
</c:forTokens>
</select><br>



Sick unit :  <select name="sick_unit">
<c:set var="sick_unit">Yes,No</c:set>
<c:forTokens items="${sick_unit}" delims="," var="temp15">
         <c:if test="${returned_row[14]==temp15}">
          <option value="${temp15}" selected="selected"> ${temp15} </option>
          </c:if>
          
          <c:if test="${returned_row[14]!=temp15}">
          <option value="${temp15}"> ${temp15} </option>
          </c:if>
</c:forTokens>
</select><br>


RBI divergent account :  <select name="rbi_divergent">
<c:set var="rbi_divergent">Yes,No</c:set>
<c:forTokens items="${rbi_divergent}" delims="," var="temp16">
         <c:if test="${returned_row[15]==temp16}">
          <option value="${temp16}" selected="selected"> ${temp16} </option>
          </c:if>
          
          <c:if test="${returned_row[15]!=temp16}">
          <option value="${temp16}"> ${temp16} </option>
          </c:if>
</c:forTokens>
</select><br>



Critical account :  <select name="critical_account">
<c:set var="critical_account">Yes,No</c:set>
<c:forTokens items="${critical_account}" delims="," var="temp17">
         <c:if test="${returned_row[16]==temp17}">
          <option value="${temp17}" selected="selected"> ${temp17} </option>
          </c:if>
          
          <c:if test="${returned_row[16]!=temp17}">
          <option value="${temp17}"> ${temp17} </option>
          </c:if>
</c:forTokens>
</select><br>



Trader :  <select name="trader">
<c:set var="trader">Yes,No</c:set>
<c:forTokens items="${trader}" delims="," var="temp18">
         <c:if test="${returned_row[17]==temp18}">
          <option value="${temp18}" selected="selected"> ${temp18} </option>
          </c:if>
          
          <c:if test="${returned_row[17]!=temp18}">
          <option value="${temp18}"> ${temp18} </option>
          </c:if>
</c:forTokens>
</select><br>


Retail credit :  <select name="retail_credit_category">
<c:set var="retail_credit_category">Yes,No</c:set>
<c:forTokens items="${retail_credit_category}" delims="," var="temp19">
         <c:if test="${returned_row[18]==temp19}">
          <option value="${temp19}" selected="selected"> ${temp19} </option>
          </c:if>
          
          <c:if test="${returned_row[18]!=temp19}">
          <option value="${temp19}"> ${temp19} </option>
          </c:if>
</c:forTokens>
</select><br>


SOD category :  <select name="sod_category">
<c:set var="sod_category">against real estate to traders,against real estate to contractors,against real estate to builders</c:set>
<c:forTokens items="${sod_category}" delims="," var="temp20">
         <c:if test="${returned_row[19]==temp20}">
          <option value="${temp20}" selected="selected"> ${temp20} </option>
          </c:if>
          
          <c:if test="${returned_row[19]!=temp20}">
          <option value="${temp20}"> ${temp20} </option>
          </c:if>
</c:forTokens>
</select><br>


LC devolvements :  <select name="lc_devolvements">
<c:set var="lc_devolvements">Yes,No</c:set>
<c:forTokens items="${lc_devolvements}" delims="," var="temp21">
         <c:if test="${returned_row[20]==temp21}">
          <option value="${temp21}" selected="selected"> ${temp21} </option>
          </c:if>
          
          <c:if test="${returned_row[20]!=temp21}">
          <option value="${temp21}"> ${temp21} </option>
          </c:if>
</c:forTokens>
</select><br>


BG invocations :  <select name="bg_invocations">
<c:set var="bg_invocations">Yes,No</c:set>
<c:forTokens items="${bg_invocations}" delims="," var="temp22">
         <c:if test="${returned_row[21]==temp22}">
          <option value="${temp22}" selected="selected"> ${temp22} </option>
          </c:if>
          
          <c:if test="${returned_row[21]!=temp22}">
          <option value="${temp22}"> ${temp22} </option>
          </c:if>
</c:forTokens>
</select><br>


Rent receivables :  <select name="rent_receivables">
<c:set var="rent_receivables">Yes,No</c:set>
<c:forTokens items="${rent_receivables}" delims="," var="temp23">
         <c:if test="${returned_row[22]==temp23}">
          <option value="${temp23}" selected="selected"> ${temp23} </option>
          </c:if>
          
          <c:if test="${returned_row[22]!=temp23}">
          <option value="${temp23}"> ${temp23} </option>
          </c:if>
</c:forTokens>
</select><br>


Rice mill :  <select name="rice_mill">
<c:set var="rice_mill">Yes,No</c:set>
<c:forTokens items="${rice_mill}" delims="," var="temp24">
         <c:if test="${returned_row[23]==temp24}">
          <option value="${temp24}" selected="selected"> ${temp24} </option>
          </c:if>
          
          <c:if test="${returned_row[23]!=temp24}">
          <option value="${temp24}"> ${temp24} </option>
          </c:if>
</c:forTokens>
</select><br>


Commercial real estate :  <select name="commercial_real_estate">
<c:set var="commercial_real_estate">Yes,No</c:set>
<c:forTokens items="${commercial_real_estate}" delims="," var="temp25">
         <c:if test="${returned_row[24]==temp25}">
          <option value="${temp25}" selected="selected"> ${temp25} </option>
          </c:if>
          
          <c:if test="${returned_row[24]!=temp25}">
          <option value="${temp25}"> ${temp25} </option>
          </c:if>
</c:forTokens>
</select><br>


Hotel :  <select name="hotel">
<c:set var="hotel">Yes,No</c:set>
<c:forTokens items="${hotel}" delims="," var="temp26">
         <c:if test="${returned_row[25]==temp26}">
          <option value="${temp26}" selected="selected"> ${temp26} </option>
          </c:if>
          
          <c:if test="${returned_row[25]!=temp26}">
          <option value="${temp26}"> ${temp26} </option>
          </c:if>
</c:forTokens>
</select><br>


Educational institution :  <select name="educational_institution">
<c:set var="educational_institution">Yes,No</c:set>
<c:forTokens items="${educational_institution}" delims="," var="temp27">
         <c:if test="${returned_row[26]==temp27}">
          <option value="${temp27}" selected="selected"> ${temp27} </option>
          </c:if>
          
          <c:if test="${returned_row[26]!=temp27}">
          <option value="${temp27}"> ${temp27} </option>
          </c:if>
</c:forTokens>
</select><br>


Public sector (PSU):  <select name="public_sector_psu">
<c:set var="public_sector_psu">Yes,No</c:set>
<c:forTokens items="${public_sector_psu}" delims="," var="temp28">
         <c:if test="${returned_row[27]==temp28}">
          <option value="${temp28}" selected="selected"> ${temp28} </option>
          </c:if>
          
          <c:if test="${returned_row[27]!=temp28}">
          <option value="${temp28}"> ${temp28} </option>
          </c:if>
</c:forTokens>
</select><br>


Advance against credit card receivables :  <select name="credit_card_receivables">
<c:set var="credit_card_receivables">Yes,No</c:set>
<c:forTokens items="${credit_card_receivables}" delims="," var="temp29">
         <c:if test="${returned_row[28]==temp29}">
          <option value="${temp29}" selected="selected"> ${temp29} </option>
          </c:if>
          
          <c:if test="${returned_row[28]!=temp29}">
          <option value="${temp29}"> ${temp29} </option>
          </c:if>
</c:forTokens>
</select><br>

Important customer :  <select name="imp_customer">
<c:set var="imp_customer">Yes,No</c:set>
<c:forTokens items="${imp_customer}" delims="," var="temp30">
         <c:if test="${returned_row[29]==temp30}">
          <option value="${temp30}" selected="selected"> ${temp30} </option>
          </c:if>
          
          <c:if test="${returned_row[29]!=temp30}">
          <option value="${temp30}"> ${temp30} </option>
          </c:if>
</c:forTokens>
</select><br>



<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>
</c:if>
</c:if>


<c:if test="${param.btn_mis_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delmis1 = (String) request.getParameter("delete_mis");
int delmis2=Integer.parseInt(delmis1);
dao2.delete_mis(delmis2);
%>
<h3>Deletion of record successful</h3>
<form action="/creditdept/mis.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>

 

<c:if test="${param.btn_mis_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.MisDao" scope="request">
</jsp:useBean>


<table id="t01">
   <tr>
    <th>Account</th>
    <th>Takeover</th> 
    <th>Restructured</th>
    <th>CGTMSE</th>
    <th>PMEGP</th>
    <th>Corporate loan</th>
    <th>Foreign currency loan</th>
    <th>Export credit limit</th>
    <th>Pledge of shares</th>
    <th>MSME category</th>
    <th>Composite loan</th>
    <th>Forward contract</th>
    <th>Buyers credit</th>
    <th>Food processing</th>
    <th>Sick unit</th>
    <th>RBI divergent account</th>
    <th>Critical account</th>
    <th>Trader</th>
    <th>Retail credit</th>
    <th>SOD category</th>
    <th>LC devolvements</th>
    <th>BG invocations</th>
    <th>Rent receivables</th>
    <th>Rice mill</th>
    <th>Commercial real estate</th>
    <th>Hotel</th>
    <th>Educational institution</th>
    <th>Public sector (PSU)</th>
    <th>Credit card receivables</th>
    <th>Important customer</th>
    </tr>
   
   <c:forEach items="${dao4._all_mis}" var="tempmis">

   <tr>      
           
<sql:query var="result2" dataSource="${dataSource}">
select account_name from accounts where aid=?
<sql:param value="${tempmis.aid}" />
</sql:query>
<c:set var="aid" value="${result2.rowsByIndex[0][0]}" />

       <td><c:out value="${aid}"/> </td>
       <td><c:out value="${tempmis.takeover}"/> </td>
       <td><c:out value="${tempmis.restructured}"/> </td>
       <td><c:out value="${tempmis.cgtmse}"/> </td>
       <td><c:out value="${tempmis.pmegp}"/> </td>
       <td><c:out value="${tempmis.corporate_loan}"/> </td>
       <td><c:out value="${tempmis.foreign_currency_loan}"/> </td>
       <td><c:out value="${tempmis.export_credit_limit}"/> </td>
       <td><c:out value="${tempmis.pledge_shares}"/> </td>
       <td><c:out value="${tempmis.msme_category}"/> </td>
       <td><c:out value="${tempmis.composite_loan}"/> </td>
       <td><c:out value="${tempmis.forward_contract}"/> </td>
       <td><c:out value="${tempmis.buyers_credit}"/> </td>
       <td><c:out value="${tempmis.food_processing}"/> </td>
       <td><c:out value="${tempmis.sick_unit}"/> </td>
       <td><c:out value="${tempmis.rbi_divergent}"/> </td>
       <td><c:out value="${tempmis.critical_account}"/> </td>
       <td><c:out value="${tempmis.trader}"/> </td>
       <td><c:out value="${tempmis.retail_credit_category}"/> </td>
       <td><c:out value="${tempmis.sod_category}"/> </td>
       <td><c:out value="${tempmis.lc_devolvements}"/> </td>
       <td><c:out value="${tempmis.bg_invocations}"/> </td>
       <td><c:out value="${tempmis.rent_receivables}"/> </td>
       <td><c:out value="${tempmis.rice_mill}"/> </td>
       <td><c:out value="${tempmis.commercial_real_estate}"/> </td>
       <td><c:out value="${tempmis.hotel}"/> </td>
       <td><c:out value="${tempmis.educational_institution}"/> </td>
       <td><c:out value="${tempmis.public_sector_psu}"/> </td>
       <td><c:out value="${tempmis.credit_card_receivables}"/> </td>
       <td><c:out value="${tempmis.imp_customer}"/> </td>
	</tr>
</c:forEach>
</table><br><br>
<form action="/creditdept/mis.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>
 

</body>
</html>